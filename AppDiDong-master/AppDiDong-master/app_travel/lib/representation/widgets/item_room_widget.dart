import 'package:flutter/material.dart';
import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/constants/textstyle_ext.dart';
import 'package:app_travel/representation/widgets/dash_line.dart';
import 'package:app_travel/representation/widgets/item_button_widget.dart';
import '../../data/model/room_model.dart';

class ItemRoomWidget extends StatelessWidget {
  const ItemRoomWidget({
    Key? key,
    required this.roomModel,
    this.onTap,
    this.numberOfRoom,
  }) : super(key: key);

  final Room roomModel;
  final Function()? onTap;
  final int? numberOfRoom;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMediumPadding),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: kMediumPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomModel.roomName,
                      style: TextStyles.defaultStyle.fontHeader.bold,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      'Room Size: ${roomModel.roomSize} m2',
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      '\$${roomModel.price.toString()}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Image.network(
                  roomModel.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            ],
          ),
          DashLineWidget(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${roomModel.price.toString()}',
                      style: TextStyles.defaultStyle.fontHeader.bold,
                    ),
                    SizedBox(
                      height: kMinPadding,
                    ),
                    Text(
                      '/night',
                      style: TextStyles.defaultStyle.fontCaption,
                    )
                  ],
                ),
              ),
              Expanded(
                child: numberOfRoom == null
                    ? ItemButtonWidget(
                  data: 'Choose',
                  onTap: onTap,
                )
                    : Text(
                  '$numberOfRoom room',
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
