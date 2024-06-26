import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/core/helpers/image_helper.dart';
import 'package:flutter/material.dart';
class ItemUtilityHotelWidget extends StatelessWidget {
  const ItemUtilityHotelWidget({Key? key}) : super(key: key);

  static const List<Map<String, String>> listUtilityHotel = [
    {'icon': AssetHelper.icoWifi, 'name': 'Free\nWifi'},
    {'icon': AssetHelper.icoNonRefund, 'name': 'Non-\nRefundable'},
    {'icon': AssetHelper.icoBreakfast, 'name': 'Free-\nBreakfast'},
    {'icon': AssetHelper.icoNonSmoke, 'name': 'Non-\nSmoking'},
  ];

  Widget _buildItemUtilityHotelWidget({required String icon, required String name}) {
    return Column(
      children: [
        ImageHelper.loadFromAsset(
          icon,
        ),
        SizedBox(
          height: kTopPadding,
        ),
        Text(name, textAlign: TextAlign.center,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: listUtilityHotel
            .map(
              (e) => _buildItemUtilityHotelWidget(
            icon: e['icon']!,
            name: e['name']!,
          ),
        )
            .toList(),
      ),
    );
  }
}
