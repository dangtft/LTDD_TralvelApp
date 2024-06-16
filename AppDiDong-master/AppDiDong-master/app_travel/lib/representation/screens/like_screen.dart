import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/constants/textstyle_ext.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/core/helpers/image_helper.dart';
import 'package:app_travel/representation/screens/hotel_booking_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/container_booking.dart';

class LikeScreen extends StatefulWidget{
   const LikeScreen({Key? key}) : super(key: key);

   static const routeName = '/like_screen';

  @override
  State<LikeScreen> createState() => _LikeState();

}

class _LikeState extends State<LikeScreen>{
  final List<Map<String, String>> listImageLeft = [
    {
      'name': 'Đà Nẵng',
      'image': AssetHelper.DaNang,
    },
    {
      'name': 'Đà Lạt',
      'image': AssetHelper.DaLat,
    },
    {
      'name': 'Hà Nội',
      'image': AssetHelper.HaNoi,
    },
    {
      'name': 'Hạ Long',
      'image': AssetHelper.HaLong,
    },
  ];
  final List<Map<String, String>> listImageRight = [
    {
      'name': 'Vũng Tàu',
      'image': AssetHelper.VungTau,
    },
    {
      'name': 'Phú Quốc',
      'image': AssetHelper.PhuQuoc,
    },
    {
      'name': 'Quảng Ngãi',
      'image': AssetHelper.QuangNgai,
    },
    {
      'name': 'Đồng Tháp',
      'image': AssetHelper.DongThap,
    },
  ];

  Widget _buidlImageAllScreen(String name, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(HotelBookingScreen.routeName, arguments: name);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ImageHelper.loadFromAsset(
              image,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              radius: BorderRadius.circular(kItemPadding),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            Positioned(
              left: kDefaultPadding,
              bottom: kDefaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyles.defaultStyle.whiteTextColor.bold,
                  ),
                  SizedBox(
                    height: kItemPadding,
                  ),
                  Container(
                    padding: EdgeInsets.all(kMinPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMinPadding),
                      color: Colors.white.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Color(0xffFFC107),
                        ),
                        SizedBox(
                          width: kItemPadding,
                        ),
                        Text('5.0')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  ContainerBooking(
      implementTraling: true,
      titleString: 'Like',
      child: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                child: Column(
                  children: listImageLeft.map(
                          (e) => _buidlImageAllScreen(
                            e['name']!,
                            e['image']!,
                    ),
                  ).toList(),
                ),
            ),
            SizedBox(
              width: kDefaultPadding,
            ),
            Expanded(
              child: Column(
                children: listImageRight.map(
                      (e) => _buidlImageAllScreen(
                    e['name']!,
                    e['image']!,
                  ),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
