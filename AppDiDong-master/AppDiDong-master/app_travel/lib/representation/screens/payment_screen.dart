import 'package:app_travel/login.dart';
import 'package:flutter/material.dart';
import 'package:app_travel/data/model/hotel_booking_model.dart';
import 'package:app_travel/representation/screens/select_date_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  final String roomName;
  final double totalPrice;
  final int userId;
  final int roomId;
  final Function(bool) onPaymentComplete;

  const PaymentScreen({
    Key? key,
    required this.roomName,
    required this.totalPrice,
    required this.userId,
    required this.roomId,
    required this.onPaymentComplete,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isProcessing = false;
  int? userId;
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

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

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10.0),
            Text(
              'Room: ${widget.roomName}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Total Amount: \$${widget.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            ItemOptionsBookingWidget(
              title: 'Select Date',
              value: _checkInDate != null && _checkOutDate != null
                  ? '${_formatDate(_checkInDate!)} - ${_formatDate(_checkOutDate!)}'
                  : 'Select date',
              icon: Icons.calendar_today,
              onTap: () async {
                final result = await Navigator.of(context).pushNamed(SelectDateScreen.routeName);
                if (result is List<DateTime?>) {
                  setState(() {
                    _checkInDate = result[0];
                    _checkOutDate = result[1];
                  });
                }
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                if (_checkInDate == null || _checkOutDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select check-in and check-out dates.')),
                  );
                  return;
                }

                setState(() {
                  isProcessing = true;
                });

                // Simulate payment process
                await Future.delayed(Duration(seconds: 2));

                // After payment, construct HotelBooking object
                var booking = HotelBooking(
                  userId: userId ?? 0,
                  roomId: widget.roomId,
                  checkInDate: _checkInDate!,
                  checkOutDate: _checkOutDate!,
                  status: "Booked",
                );

                // Call API to book hotel and handle response
                try {
                  var bookedHotel = await bookHotel(booking);

                  // Handle success
                  widget.onPaymentComplete(true);

                  Navigator.pop(context);
                } catch (e) {
                  // Handle error
                  print('Failed to book hotel: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to book hotel. Please try again later.')),
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

  Future<HotelBooking> bookHotel(HotelBooking booking) async {
    // Replace with actual API endpoint to book hotel
    var response = await fetchBookHotelAPI(booking);

    if (response.statusCode == 201) {
      // Booking successful, return booked hotel object
      return HotelBooking.fromJson(jsonDecode(response.body));
    } else {
      // Booking failed, throw exception
      throw Exception('Failed to book hotel');
    }
  }

  Future<http.Response> fetchBookHotelAPI(HotelBooking booking) async {

    var url = Uri.parse('https://localhost:7074/api/Hotel/bookhotel');

    // Replace with actual API call method (POST, PUT, etc.)
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(booking.toJson()),
    );

    return response;
  }
}

class ItemOptionsBookingWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const ItemOptionsBookingWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.grey),
                SizedBox(width: 10.0),
                Text(title, style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Text(value, style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
