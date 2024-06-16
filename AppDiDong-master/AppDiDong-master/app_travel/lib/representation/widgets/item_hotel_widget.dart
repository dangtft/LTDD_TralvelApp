import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/constants/textstyle_ext.dart';
import 'package:app_travel/core/helpers/image_helper.dart';
import 'package:app_travel/data/model/hotel_model.dart';
import 'package:app_travel/representation/widgets/dash_line.dart';
import 'package:app_travel/representation/widgets/item_button_widget.dart';
import 'package:flutter/material.dart';

class ItemHotelWidget extends StatelessWidget {
  const ItemHotelWidget({
    Key? key,
    required this.hotelModel,
    this.onTap,
  }) : super(key: key);

  final Hotel hotelModel;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kDefaultPadding),
              topRight: Radius.circular(kDefaultPadding),
            ),
            child: Image.network(
              hotelModel.imageUrl ?? '',
              height: 200, // Set the desired height of the image
              width: double.infinity,
              fit: BoxFit.cover, // Ensure the image covers the container
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Center(
                  child: Icon(Icons.error),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotelModel.hotelName ?? '',
                  style: TextStyles.defaultStyle.fontHeader.bold,
                ),
                SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: kMinPadding),
                    Text(
                      hotelModel.location ?? '',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      ' - from destination',
                      style: TextStyles.defaultStyle.subTitleTextColor.fontCaption,
                      maxLines: 2,
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: kMinPadding),
                    Text(
                      hotelModel.rating?.toString() ?? '',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      ' ( reviews)',
                      style: TextStyles.defaultStyle.subTitleTextColor,
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
                            '\$${hotelModel.price?.toString() ?? ''}',
                            style: TextStyles.defaultStyle.fontHeader.bold,
                          ),
                          SizedBox(height: kMinPadding),
                          Text(
                            '/night',
                            style: TextStyles.defaultStyle.fontCaption,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ItemButtonWidget(
                        data: 'Book a room',
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
