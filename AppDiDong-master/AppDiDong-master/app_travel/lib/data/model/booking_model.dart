import 'package:app_travel/data/model/flightbooking_dto.dart';
import 'package:app_travel/data/model/hotelbooking_dto.dart';

class BookingModel {
  List<FlightBookingDTO> flightBookings;
  List<HotelBookingDTO> hotelBookings;

  BookingModel({
    required this.flightBookings,
    required this.hotelBookings,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> flightList = json['flightBookings'] ?? [];
    List<dynamic> hotelList = json['hotelBookings'] ?? [];

    List<FlightBookingDTO> flights = flightList.map((item) => FlightBookingDTO.fromJson(item)).toList();
    List<HotelBookingDTO> hotels = hotelList.map((item) => HotelBookingDTO.fromJson(item)).toList();

    return BookingModel(
      flightBookings: flights,
      hotelBookings: hotels,
    );
  }
}
