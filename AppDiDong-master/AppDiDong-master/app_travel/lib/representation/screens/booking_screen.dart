import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:app_travel/data/model/flight_booking_model.dart';
import 'package:app_travel/data/model/hotel_booking_model.dart';
import 'package:app_travel/representation/screens/detail_hotel_screen.dart';
import 'package:app_travel/representation/screens/detail_flight_screen.dart';
import 'package:app_travel/representation/widgets/container_booking.dart';
import 'package:app_travel/representation/widgets/item_booking_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  static const routeName = '/booking_screen';

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<HotelBooking> hotelBookings = [];
  List<FlightBooking> flightBookings = [];
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    fetchBookings();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
  }

  Future<void> fetchBookings() async {
    try {
      final response = await http.get(
        Uri.parse('https://localhost:7074/api/Hotel/bookings/$userId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> hotelData = data['hotelBookings'];
        final List<dynamic> flightData = data['flightBookings'];

        List<HotelBooking> hotelBookingsList = hotelData.map((json) {
          return HotelBooking.fromJson(json);
        }).toList();

        List<FlightBooking> flightBookingsList = flightData.map((json) {
          return FlightBooking.fromJson(json);
        }).toList();

        setState(() {
          hotelBookings = hotelBookingsList;
          flightBookings = flightBookingsList;
        });
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBooking(
      titleString: 'Booking',
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Display hotel bookings
            ...hotelBookings.map(
                  (hotel) => ItemBookingWidget(
                bookingModel: hotel,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    DetailHotelScreen.routeName,
                    arguments: hotel,
                  );
                },
              ),
            ),
            // Display flight bookings
            ...flightBookings.map(
                  (flight) => ItemBookingWidget(
                bookingModel: flight,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    DetailFlightScreen.routeName,
                    arguments: flight,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
