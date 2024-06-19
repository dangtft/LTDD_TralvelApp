import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/login.dart';
import 'package:app_travel/representation/screens/main_app.dart';
import 'package:app_travel/representation/screens/payment_flight_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_travel/data/model/flight_model.dart';
import 'package:app_travel/representation/screens/select_location.dart';
import 'package:app_travel/representation/screens/ticket.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:app_travel/representation/widgets/item_button_widget.dart';
import 'package:app_travel/representation/widgets/item_options_booking.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookTicket extends StatefulWidget {
  const BookTicket({Key? key, required this.flight}) : super(key: key);

  static const String routeName = '/book_ticket';
  final Flight flight;

  @override
  State<BookTicket> createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  String? ticket;
  String locationDestination = '';
  String flightLocation = '';
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }
  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
    if (userId == null) {
      // Show dialog if userId is null
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dialog from being dismissed
        builder: (context) => AlertDialog(
          title: Text('Not Logged In'),
          content: Text('Please log in to proceed with payment.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName); // Navigate to LoginScreen
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
                Navigator.of(context).pop(); // Pop PaymentScreen to go back
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: 'Booking Ticket',
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: kMediumPadding * 2,
            ),
            ItemOptionsBookingWidget(
              title: 'Flight Location',
              value: widget.flight.location,
              icon: AssetHelper.icoLocation,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationSelection(
                      onLocation: (location) {
                        setState(() {
                          flightLocation = location;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            ItemOptionsBookingWidget(
              title: 'Destination',
              value: widget.flight.destination,
              icon: AssetHelper.icoLocation,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationSelection(
                      onLocation: (location) {
                        setState(() {
                          locationDestination = location;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            ItemOptionsBookingWidget(
              title: 'Ticket',
              value: ticket ?? 'Ticket',
              icon: AssetHelper.icoTicket,
              onTap: () async {
                final result = await Navigator.of(context).pushNamed(Ticket.routeName);
                if (result is List<int>) {
                  setState(() {
                    ticket = '${result[0]}';
                  });
                }
              },
            ),
            ItemButtonWidget(
              data: 'Payment',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FlightPaymentScreen(
                      flightName: widget.flight.flightName ?? '',
                      location: flightLocation,
                      destination: locationDestination,
                      totalPrice: widget.flight.price * int.parse(ticket!) ?? 0.0,
                      departureTime: widget.flight.departureTime ?? DateTime.now(),
                      dayFlight: widget.flight.dayFlight ?? 0,
                      numberOfTickets: int.tryParse(ticket ?? '1') ?? 1,
                      userId: userId!,
                      flightId: widget.flight.flightId,
                      onPaymentComplete: (bool success) {
                        if (success) {
                          Navigator.of(context).popUntil((route) => route.settings.name == MainApp.routeName);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Payment failed. Please try again.')),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
