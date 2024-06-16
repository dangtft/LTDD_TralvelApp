import 'package:flutter/material.dart';
import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/constants/textstyle_ext.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/representation/widgets/dash_line.dart';
import 'package:app_travel/representation/widgets/item_button_widget.dart';
import 'package:app_travel/data/model/hotel_booking_model.dart';

class ItemBookingWidget extends StatelessWidget {
  const ItemBookingWidget({
    Key? key,
    required this.bookingModel,
    this.onTap,
  }) : super(key: key);

  final dynamic bookingModel;
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
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kDefaultPadding),
                bottomRight: Radius.circular(kDefaultPadding),
              ),
              child: Image.network(
                bookingModel.imageUrl, // Use imageUrl from bookingModel
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookingModel.name,
                  style: TextStyles.defaultStyle.fontHeader.bold,
                ),
                SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    Image.asset(
                      bookingModel is HotelBooking
                          ? AssetHelper.icoLocationBlank
                          : AssetHelper.icoLocation,
                      width: kMinPadding * 2,
                      height: kMinPadding * 2,
                    ),
                    SizedBox(width: kMinPadding),
                    Expanded(
                      child: Text(
                        bookingModel is HotelBooking
                            ? '${bookingModel.checkInDate.toString()} - ${bookingModel.checkOutDate.toString()}'
                            : '${bookingModel.origin} - ${bookingModel.destination}',
                        style: TextStyles.fontBody,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    Image.asset(
                      AssetHelper.icoStar,
                      width: kMinPadding * 2,
                      height: kMinPadding * 2,
                    ),
                    SizedBox(width: kMinPadding),
                    Text(
                      bookingModel.rating.toString(),
                      style: TextStyles.fontBody,
                    ),
                    SizedBox(width: kMinPadding),
                    Text(
                      '(${bookingModel.reviews} reviews)',
                      style: TextStyles.fontBody,
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding),
                Text(
                  '20 days ago', // Placeholder text, adjust as needed
                  style: TextStyles.fontBody,
                ),
                DashLineWidget(),
                SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${bookingModel.price.toString()}',
                            style: TextStyles.defaultStyle.fontHeader.bold,
                          ),
                          SizedBox(height: kMinPadding),
                          Text(
                            '/night',
                            style: TextStyles.fontBody,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ItemButtonWidget(
                        data: bookingModel is HotelBooking
                            ? 'Rebook The Room'
                            : 'Rebook The Flight',
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
