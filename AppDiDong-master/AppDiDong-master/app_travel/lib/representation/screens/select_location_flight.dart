import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/data/model/flight_model.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';


class LocationSelectionFlight extends StatelessWidget {
  final Function(String) onLocation;
  final List<Flight> flights; // List of Hotel objects
  LocationSelectionFlight({required this.onLocation, required this.flights});

  static const String routeName = '/select_location_flight';

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: 'Select Destination',
      paddingContent: EdgeInsets.all(kMediumPadding),
      child: Column(
        children: [
          SizedBox(height: kMediumPadding),
          Expanded(
            child: ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      flights[index].location, // Use location from Hotel object
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onTap: () {
                      onLocation(flights[index].location); // Pass location to callback
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
