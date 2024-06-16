import 'dart:convert';
import 'package:app_travel/data/model/flight_model.dart';
import 'package:app_travel/representation/screens/book_ticket.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:app_travel/representation/widgets/item_flight_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({Key? key}) : super(key: key);

  static const String routeName = '/flight_screen';

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  late Future<List<Flight>> _futureFlights;

  @override
  void initState() {
    super.initState();
    _futureFlights = fetchFlights();
  }

  Future<List<Flight>> fetchFlights() async {
    final response = await http.get(Uri.parse('https://localhost:7074/api/Hotel/flights'));

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
      implementTraling: true,
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
                      Navigator.of(context).pushNamed(BookTicket.routeName);
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
