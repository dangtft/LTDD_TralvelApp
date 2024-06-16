import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/data/model/hotel_model.dart';
import 'package:app_travel/representation/screens/detail_hotel_screen.dart';
import 'package:app_travel/representation/widgets/container_booking.dart';
import 'package:app_travel/representation/widgets/item_booking_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  static const routeName = '/booking_screen';

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<Hotel> booking = [];

  @override
  void initState() {
    super.initState();
    fetchBookingData();
  }

  Future<void> fetchBookingData() async {
    final response = await http.get(Uri.parse('https://localhost:7074/api/Hotel/hotels'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        booking = data.map((json) => Hotel.fromJson(json)).toList();
      });
    } else {
      // Xử lý lỗi nếu có
      throw Exception('Failed to load booking data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBooking(
      implementTraling: true,
      titleString: 'Booking',
      child: SingleChildScrollView(
        child: Column(
          children: booking
              .map(
                (e) => ItemBookingWidget(
              hotelModel: e,
              onTap: () {
                Navigator.of(context).pushNamed(DetailHotelScreen.routeName, arguments: e);
              },
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}
