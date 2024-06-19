import 'dart:convert';
import 'package:app_travel/data/model/flight_model.dart';
import 'package:app_travel/representation/screens/book_ticket.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:app_travel/representation/widgets/item_flight_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({Key? key, required this.destination}) : super(key: key);

  static const String routeName = '/flight_screen';
  final String destination;

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  late Future<List<Flight>> _futureFlights;

  @override
  void initState() {
    super.initState();
    _futureFlights = fetchFlights(widget.destination);
  }

  Future<List<Flight>> fetchFlights(String destination) async {
    final response =
    await http.get(Uri.parse('https://localhost:7074/api/Hotel/flight/$destination'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((flight) => Flight.fromJson(flight)).toList();
    } else {
      throw Exception('Failed to load flights');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(

      titleString: 'Flights',
      child: FutureBuilder<List<Flight>>(
        future: _futureFlights,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No flights available'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!
                    .map(
                      (flight) => ItemFlightWidget(
                    flightModel: flight,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookTicket(
                            flight: flight,
                          ),
                        ),
                      );
                    },
                  ),
                )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
