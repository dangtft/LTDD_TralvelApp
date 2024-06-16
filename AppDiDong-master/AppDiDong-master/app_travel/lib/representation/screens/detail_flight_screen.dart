import 'package:flutter/material.dart';
import 'package:app_travel/data/model/flight_model.dart';
import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/helpers/image_helper.dart';
import 'package:app_travel/representation/widgets/dash_line.dart';
import 'package:app_travel/representation/widgets/item_button_widget.dart';

class DetailFlightScreen extends StatelessWidget {
  static const routeName = '/detail_flight_screen';

  final Flight flight;

  const DetailFlightScreen({
    Key? key,
    required this.flight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: ImageHelper.loadFromAsset(
              flight.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: kMediumPadding * 3,
            left: kMediumPadding,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    kDefaultPadding,
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(kItemPadding),
                child: Icon(
                  Icons.arrow_back,
                  size: kDefaultPadding,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding * 2),
                    topRight: Radius.circular(kDefaultPadding * 2),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: kDefaultPadding),
                        Text(
                          flight.flightName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 5),
                            Text(flight.location),
                          ],
                        ),
                        DashLineWidget(),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 5),
                            Text(flight.destination),
                          ],
                        ),
                        DashLineWidget(),
                        Row(
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 5),
                            Text('Departure Time: ${flight.departureTime.toLocal()}'),
                          ],
                        ),
                        DashLineWidget(),
                        Row(
                          children: [
                            Icon(Icons.attach_money),
                            SizedBox(width: 5),
                            Text('Price: \$${flight.price.toString()}'),
                          ],
                        ),
                        DashLineWidget(),
                        Row(
                          children: [
                            Icon(Icons.airplanemode_active),
                            SizedBox(width: 5),
                            Text('Day Flight: ${flight.dayFlight.toString()}'),
                          ],
                        ),
                        SizedBox(height: kDefaultPadding),
                        Text(
                          'Flight Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 2),

                        SizedBox(height: kDefaultPadding),
                        ImageHelper.loadFromAsset(
                          flight.imageUrl,
                          width: double.infinity,
                        ),
                        SizedBox(height: kDefaultPadding),
                        ItemButtonWidget(
                          data: 'Select Ticket',
                          onTap: () {
                            // Implement action for selecting flight ticket
                          },
                        ),
                        SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
