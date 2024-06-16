import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:app_travel/representation/widgets/item_button_widget.dart';
import 'package:app_travel/representation/widgets/item_change_guest_and_room.dart';
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  const Ticket({Key? key}) : super(key: key);

  static const String routeName = '/ticket';

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket>{
  final GlobalKey<ItemChangeGuestAndRoomState> _itemCountGuest = GlobalKey<ItemChangeGuestAndRoomState>();


  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: 'Add Ticket',
      paddingContent: EdgeInsets.all(kMediumPadding),
      child: Column(
        children: [
          SizedBox(
            height: kMediumPadding,
          ),
          ItemChangeGuestAndRoom(
            key: _itemCountGuest,
            initData: 1,
            icon: AssetHelper.icoTicket,
            value: 'Ticket',
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          ItemButtonWidget(
            data: 'Done',
            onTap: () {
              Navigator.of(context).pop([
                _itemCountGuest.currentState!.number,
              ]);
            },
          ),
        ],
      ),
    );
  }
}