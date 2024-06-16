
import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/extensions/date_ext.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/representation/screens/guest_and_room_screen.dart';
import 'package:app_travel/representation/screens/hotels_screen.dart';
import 'package:app_travel/representation/screens/main_app.dart';
import 'package:app_travel/representation/screens/select_date_screen.dart';
import 'package:app_travel/representation/screens/select_location.dart';
import 'package:app_travel/representation/screens/ticket.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:app_travel/representation/widgets/item_button_widget.dart';
import 'package:app_travel/representation/widgets/item_options_booking.dart';
import 'package:flutter/material.dart';

class BookTicket extends StatefulWidget {
  const BookTicket({Key? key, this.destination}) : super(key: key);

  static const String routeName = '/book_ticket.dart';

  final String? destination;

  @override
  State<BookTicket> createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  String? ticket;
  String locationDestination = 'Việt Nam';
  String Flightlocation = 'Việt Nam';
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
              value: widget.destination ?? Flightlocation,
              icon: AssetHelper.icoLocation,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationSelection(
                    onLocation: (location){
                      setState(() {
                        Flightlocation = location;
                      });
                    },
                  ),
                  ),
                );
              },
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
              title: 'Ticket',
              value: ticket ?? 'Ticket',
              icon: AssetHelper.icoTicket,
              onTap: () async {
                final result = await Navigator.of(context).pushNamed(Ticket.routeName);
                if (result is List<int>) {
                  setState(() {
                    ticket = '${result[0]} ';
                  });
                }
              },
            ),
            ItemButtonWidget(
              data: 'PayMent',
              onTap: () {
                Navigator.of(context).popUntil((route) => route.settings.name == MainApp.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
