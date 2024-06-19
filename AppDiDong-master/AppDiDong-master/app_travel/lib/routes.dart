import 'package:app_travel/data/model/flight_model.dart';
import 'package:app_travel/data/model/hotel_model.dart';
import 'package:app_travel/data/model/room_model.dart';
import 'package:app_travel/representation/screens/all_screen.dart';
import 'package:app_travel/representation/screens/book_ticket.dart';
import 'package:app_travel/representation/screens/change_password_screen.dart';
import 'package:app_travel/representation/screens/check_out_screen.dart';
import 'package:app_travel/representation/screens/detail_hotel_screen.dart';
import 'package:app_travel/representation/screens/flight_screen.dart';
import 'package:app_travel/representation/screens/flights_booking_screen.dart';
import 'package:app_travel/representation/screens/guest_and_room_screen.dart';
import 'package:app_travel/representation/screens/home_screen.dart';
import 'package:app_travel/representation/screens/hotel_booking_screen.dart';
import 'package:app_travel/representation/screens/hotels_screen.dart';
import 'package:app_travel/login.dart';
import 'package:app_travel/representation/screens/main_app.dart';
import 'package:app_travel/representation/screens/rooms_screen.dart';
import 'package:app_travel/representation/screens/select_date_screen.dart';
import 'package:app_travel/representation/screens/ticket.dart';
import 'package:app_travel/representation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_travel/sign_up.dart';

final Map<String, WidgetBuilder> routes = {
  MainApp.routeName: (context) => MainApp(),
  HotelsScreen.routeName: (context) {
    final String location = ModalRoute.of(context)!.settings.arguments as String;
    return HotelsScreen(location: location);
  },
  FlightsScreen.routeName: (context) {
    final String destination = ModalRoute.of(context)!.settings.arguments as String;
    return FlightsScreen(destination : destination);
},
  SelectDateScreen.routeName: (context) => SelectDateScreen(),
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  GuestAndRoomScreen.routeName: (context) => GuestAndRoomScreen(),
  Ticket.routeName: (context) => Ticket(),
  RoomsScreen.routeName: (context) => RoomsScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AllScreen.routeName: (context) => AllScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  DetailHotelScreen.routeName: (context) {
    final Hotel hotelModel = ModalRoute.of(context)!.settings.arguments as Hotel;
    return DetailHotelScreen(
      hotelModel: hotelModel,
    );
  },

};

MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case DetailHotelScreen.routeName:
      final Hotel hotelModel = settings.arguments as Hotel;
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => DetailHotelScreen(
          hotelModel: hotelModel,
        ),
      );
    case CheckOutScreen.routeName:
      final Room roomModel = settings.arguments as Room;
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => CheckOutScreen(
          roomModel: roomModel,
        ),
      );

    case HotelBookingScreen.routeName:
      final String? destination = settings.arguments as String?;
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => HotelBookingScreen(
          destination: destination,
        ),
      );
    case FlightsBookingScreen.routeName:
      final String? destination = settings.arguments as String?;
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => FlightsBookingScreen(
          destination: destination,
        ),
      );
    case BookTicket.routeName:
      final Flight flight = settings.arguments as Flight;
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => BookTicket(
          flight: flight,
        ),
      );
    default:
      return null;
  }
}
