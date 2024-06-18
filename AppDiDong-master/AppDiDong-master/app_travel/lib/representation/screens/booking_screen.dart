import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_travel/representation/widgets/container_booking.dart';
import 'package:app_travel/representation/widgets/item_booking_widget.dart';
import 'package:app_travel/representation/screens/detail_hotel_screen.dart';
import 'package:app_travel/representation/screens/detail_flight_screen.dart';
import 'package:app_travel/data/model/booking_provider.dart';


class Booking extends StatelessWidget {
  const Booking({Key? key}) : super(key: key);

  static const routeName = '/booking_screen';

  @override
  Widget build(BuildContext context) {
    final baseUrl = 'https://localhost:7074/api/Hotel';
    return ChangeNotifierProvider(
      create: (_) => BookingProvider(baseUrl)..loadUserId(),
      child: Consumer<BookingProvider>(
        builder: (context, provider, _) {
          if (provider.userId == -1) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Loading...'),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return BookingContent(); // Show content once user ID is loaded
          }
        },
      ),
    );
  }
}

class BookingContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);
    return ContainerBooking(
      titleString: 'Booking',
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Hiển thị danh sách đặt phòng khách sạn
            ...provider.hotelBookings.map(
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
            // Hiển thị danh sách đặt vé máy bay
            ...provider.flightBookings.map(
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
