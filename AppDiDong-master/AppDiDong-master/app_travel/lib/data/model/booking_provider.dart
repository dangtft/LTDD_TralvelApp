import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_travel/data/model/flightbooking_dto.dart';
import 'package:app_travel/data/model/hotelbooking_dto.dart';

class BookingProvider extends ChangeNotifier {
  late List<HotelBookingDTO> _hotelBookings;
  late List<FlightBookingDTO> _flightBookings;
  late int _userId;
  final String _baseUrl;

  BookingProvider(String baseUrl)
      : _baseUrl = baseUrl {
    _hotelBookings = [];
    _flightBookings = [];
    _userId = -1; // Default value to indicate no user ID loaded yet
  }

  List<HotelBookingDTO> get hotelBookings => _hotelBookings;
  List<FlightBookingDTO> get flightBookings => _flightBookings;
  int get userId => _userId;

  Future<void> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('userId') ?? -1;
    await fetchBookings();
    notifyListeners();
  }

  Future<void> fetchBookings() async {
    if (_userId == -1) return; // Check if user ID is loaded

    try {
      final hotelResponse = await http.get(Uri.parse('$_baseUrl/hotelbookings/$_userId'));
      final flightResponse = await http.get(Uri.parse('$_baseUrl/flightbookings/$_userId'));

      if (hotelResponse.statusCode == 200) {
        List<dynamic> hotelData = jsonDecode(hotelResponse.body);
        _hotelBookings = hotelData.map((json) => HotelBookingDTO.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load hotel bookings');
      }

      if (flightResponse.statusCode == 200) {
        List<dynamic> flightData = jsonDecode(flightResponse.body);
        _flightBookings = flightData.map((json) => FlightBookingDTO.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load flight bookings');
      }

      notifyListeners(); // Notify listeners of changes
    } catch (e) {
      print('Error fetching bookings: $e');
    }
  }
}
