import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/extensions/date_ext.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/representation/screens/flight_screen.dart';
import 'package:app_travel/representation/screens/select_date_screen.dart';
import 'package:app_travel/representation/screens/select_location.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:app_travel/representation/widgets/item_button_widget.dart';
import 'package:app_travel/representation/widgets/item_options_booking.dart';
import 'package:flutter/material.dart';

class FlightsBookingScreen extends StatefulWidget {
  const FlightsBookingScreen({Key? key, this.destination}) : super(key: key);

  static const String routeName = '/flights_booking_screen';

  final String? destination;

  @override
  State<FlightsBookingScreen> createState() => _FlightsBookingScreenState();
}

class _FlightsBookingScreenState extends State<FlightsBookingScreen> {
  String? selectDate;
  String locationDestination = 'Việt Nam';
  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: 'Flight Booking',
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: kMediumPadding * 2,
            ),
            ItemOptionsBookingWidget(

              title: 'Destination',
              value: widget.destination ?? locationDestination,
              icon: AssetHelper.icoLocation,
              onTap: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationSelection(
                      onLocation: (location){
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
              title: 'Select Date',
              value: selectDate ?? 'Select date',
              icon: AssetHelper.icoCalendal,
              onTap: () async {
                final result = await Navigator.of(context).pushNamed(SelectDateScreen.routeName);
                if (result is List<DateTime?>) {
                  setState(() {
                    selectDate = '${result[0]?.getStartDate}';
                  });
                }
              },
            ),
            ItemButtonWidget(
              data: 'Search',
              onTap: () {
                Navigator.of(context).pushNamed(FlightsScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
