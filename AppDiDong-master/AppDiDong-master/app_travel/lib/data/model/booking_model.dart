import 'package:app_travel/data/model/flight_booking_model.dart';
import 'package:app_travel/data/model/hotel_booking_model.dart';

class BookingModel {
  List<FlightBooking> flightBookings;
  List<HotelBooking> hotelBookings;

  BookingModel({
    required this.flightBookings,
    required this.hotelBookings,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> flightList = json['flightBookings'] ?? [];
    List<dynamic> hotelList = json['hotelBookings'] ?? [];

    List<FlightBooking> flights = flightList.map((item) => FlightBooking.fromJson(item)).toList();
    List<HotelBooking> hotels = hotelList.map((item) => HotelBooking.fromJson(item)).toList();

    return BookingModel(
      flightBookings: flights,
      hotelBookings: hotels,
    );
  }
}