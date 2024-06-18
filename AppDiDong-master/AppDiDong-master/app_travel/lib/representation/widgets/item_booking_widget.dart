import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/constants/textstyle_ext.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/data/model/hotelbooking_dto.dart';
import 'package:app_travel/representation/widgets/dash_line.dart';
import 'package:app_travel/representation/widgets/item_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemBookingWidget extends StatelessWidget {
  const ItemBookingWidget({
    Key? key,
    required this.bookingModel,
    this.onTap,
  }) : super(key: key);

  final dynamic bookingModel;
  final Function()? onTap;

  String _formatDate(DateTime? date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return date != null ? formatter.format(date) : '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: kMediumPadding),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(),
        SizedBox(height: kDefaultPadding),
        _buildTitle(),
        SizedBox(height: kDefaultPadding),
        _buildDetails(context),
        SizedBox(height: kDefaultPadding),
        DashLineWidget(),
        SizedBox(height: kDefaultPadding),
        _buildPriceAndButton(context),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: kDefaultPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultPadding),
          bottomRight: Radius.circular(kDefaultPadding),
        ),
        child: Image.network(
          bookingModel is HotelBookingDTO
              ? bookingModel.hotelImageUrl ?? ''
              : bookingModel.flightImageUrl ?? '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      bookingModel is HotelBookingDTO
          ?bookingModel.hotelName ?? ''
          : bookingModel.flightName ?? '',
      style: TextStyles.defaultStyle.fontHeader.bold,
    );
  }

  Widget _buildDetails(BuildContext context) {
    return bookingModel is HotelBookingDTO
        ? _buildHotelDetails(context)
        : _buildFlightDetails(context);
  }

  Widget _buildHotelDetails(BuildContext context) {
    final HotelBookingDTO hotelBooking = bookingModel as HotelBookingDTO;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [

            SizedBox(width: kMinPadding),
            Expanded(child: Text(
                '${hotelBooking.roomName}'
              ),
            ),


          ],
        ),
        SizedBox(height: kDefaultPadding),
        Row(
          children: [
            Image.network(
              hotelBooking.roomImage ?? '',
              fit: BoxFit.cover,
              height: 150,
              width: 340,
            ),
          ],
        ),
        SizedBox(height: kDefaultPadding),
        Row(
          children: [
            Expanded(
              child: Text(
                '${_formatDate(hotelBooking.checkInDate)} - ${_formatDate(hotelBooking.checkOutDate)}',
                style: TextStyles.fontBody,
              ),
            ),
          ],
        ),
        SizedBox(height: kDefaultPadding),
        Row(
          children: [
            Text(
              '\$${hotelBooking.price.toString()}',
              style: TextStyles.defaultStyle.fontHeader.bold,
            ),
          ],
        )
      ],
    );
  }


  Widget _buildFlightDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              AssetHelper.icoLocation,
              width: kMinPadding * 2,
              height: kMinPadding * 2,
            ),
            SizedBox(width: kMinPadding),
          ],
        ),

      ],
    );
  }

  Widget _buildPriceAndButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ItemButtonWidget(
            data: bookingModel is HotelBookingDTO
                ? 'Rebook The Room'
                : 'Rebook The Flight',
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
