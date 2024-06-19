import 'dart:convert';
import 'package:app_travel/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlightPaymentScreen extends StatefulWidget {
  final String flightName;
  final String location;
  final String destination;
  final double totalPrice;
  final DateTime departureTime;
  final int dayFlight;
  final int numberOfTickets;
  final int userId;
  final int flightId;
  final Function(bool) onPaymentComplete;

  const FlightPaymentScreen({
    Key? key,
    required this.flightName,
    required this.location,
    required this.destination,
    required this.totalPrice,
    required this.departureTime,
    required this.dayFlight,
    required this.numberOfTickets,
    required this.userId,
    required this.flightId,
    required this.onPaymentComplete,
  }) : super(key: key);

  @override
  _FlightPaymentScreenState createState() => _FlightPaymentScreenState();
}

class _FlightPaymentScreenState extends State<FlightPaymentScreen> {
  bool isProcessing = false;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Payment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10.0),
            Text(
              'Flight: ${widget.flightName}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'From: ${widget.location}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'To: ${widget.destination}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Total Price: \$${widget.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Departure Time: ${_formatDate(widget.departureTime)}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Day of Flight: ${widget.dayFlight}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Number of Tickets: ${widget.numberOfTickets}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                if (userId == null) {
                  // Show dialog indicating user needs to log in
                  showDialog(
                    context: context,
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
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                setState(() {
                  isProcessing = true;
                });

                // Simulate payment process
                await Future.delayed(Duration(seconds: 2));

                // After payment, construct FlightBookingDTO object
                var bookingDto = {
                  'userId': userId,
                  'flightId': widget.flightId,
                  'bookingDate': DateTime.now().toIso8601String(),
                  'status': 'Booked',
                  'flightName': widget.flightName,
                  'flightImageUrl': '',
                  'location': widget.location,
                  'destination': widget.destination,
                  'totalPrice': widget.totalPrice * widget.numberOfTickets,
                  'departureTime': widget.departureTime.toIso8601String(),
                  'dayFlight': widget.dayFlight,
                  'numberOfTickets': widget.numberOfTickets,
                };

                // Call API to book flight and handle response
                try {
                  var bookedFlight = await bookFlight(bookingDto);

                  // Handle success
                  widget.onPaymentComplete(true);

                  // Show success dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Booking Successful'),
                        content: Text('Your flight has been booked successfully.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.popUntil(context, ModalRoute.withName('/main_app'));
                            },
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  // Handle error
                  print('Failed to book flight: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to book flight. Please try again later.')),
                  );
                } finally {
                  setState(() {
                    isProcessing = false;
                  });
                }
              },
              child: isProcessing ? CircularProgressIndicator() : Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  Future<dynamic> bookFlight(Map<String, dynamic> bookingDto) async {
    var url = Uri.parse('https://localhost:7074/api/Hotel/bookflight');

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bookingDto),
      );

      if (response.statusCode == 201) {
        // Booking successful, return response body
        return jsonDecode(response.body);
      } else {
        // Booking failed, throw exception
        throw Exception('Failed to book flight');
      }
    } catch (e) {
      throw Exception('Failed to connect to server');
    }
  }
}

