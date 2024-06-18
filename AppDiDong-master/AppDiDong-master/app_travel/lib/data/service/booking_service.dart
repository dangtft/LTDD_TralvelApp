import 'dart:convert';
import 'package:app_travel/data/model/flightbooking_dto.dart';
import 'package:app_travel/data/model/hotelbooking_dto.dart';
import 'package:http/http.dart' as http;

class BookingService {
  final String baseUrl;

  BookingService(this.baseUrl);

  Future<List<HotelBookingDTO>> getHotelBookingsByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/hotelbookings/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => HotelBookingDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hotel bookings');
    }
  }

  Future<List<FlightBookingDTO>> getFlightBookingsByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/flightbookings/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => FlightBookingDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load flight bookings');
    }
  }
}
