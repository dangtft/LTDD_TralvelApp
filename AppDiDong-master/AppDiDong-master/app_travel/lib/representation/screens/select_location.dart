import 'package:app_travel/core/constants/color_constants.dart';
import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';

class LocationSelection extends StatelessWidget {
  final Function(String) onLocation;
  LocationSelection({required this.onLocation});

  static const String routeName = '/select_location';
  @override
  Widget build(BuildContext context) {
    final locations = ['Đà Nẵng', 'Đà Lạt', 'Vũng Tàu', 'Phú Quóc', 'Hà Nội', 'Hạ Long', 'Quảng Ngãi', 'Đồng Tháp'];
    return   AppBarContainer(
      titleString: 'Select Location',
      paddingContent: EdgeInsets.all(kMediumPadding),
      child: Column(
        children: [
          SizedBox(
            height: kMediumPadding,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      locations[index],
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onTap: () {
                      onLocation(locations[index]);
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
