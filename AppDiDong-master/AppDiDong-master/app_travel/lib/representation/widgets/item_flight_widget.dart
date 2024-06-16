import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/constants/textstyle_ext.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/core/helpers/image_helper.dart';
import 'package:app_travel/data/model/flight_model.dart';
import 'package:app_travel/representation/widgets/dash_line.dart';
import 'package:app_travel/representation/widgets/item_button_widget.dart';
import 'package:flutter/material.dart';

class ItemFlightWidget extends StatelessWidget {
  const ItemFlightWidget({
    Key? key,
    required this.flightModel,
    this.onTap,
  }) : super(key: key);

  final Flight flightModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: kMediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: kDefaultPadding),
            child: ImageHelper.loadFromAsset(
              flightModel.imageUrl,
              radius: BorderRadius.only(
                topLeft: Radius.circular(kDefaultPadding),
                bottomRight: Radius.circular(kDefaultPadding),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flightModel.flightName,
                  style: TextStyles.defaultStyle.fontHeader.bold,
                ),
                SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    ImageHelper.loadFromAsset(AssetHelper.icoLocationBlank),
                    SizedBox(width: kMinPadding),
                    Text(flightModel.location),
                  ],
                ),
                SizedBox(height: kDefaultPadding),
                DashLineWidget(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${flightModel.price.toString()}',
                            style: TextStyles.defaultStyle.fontHeader.bold,
                          ),
                          SizedBox(height: kMinPadding),
                          Text(
                            '/ticket',
                            style: TextStyles.defaultStyle.fontCaption,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ItemButtonWidget(
                        data: 'Book tickets',
                        onTap: onTap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
