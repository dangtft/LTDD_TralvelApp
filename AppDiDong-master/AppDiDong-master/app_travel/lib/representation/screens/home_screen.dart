
import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/constants/textstyle_ext.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/core/helpers/image_helper.dart';
import 'package:app_travel/representation/screens/all_screen.dart';
import 'package:app_travel/representation/screens/flights_booking_screen.dart';
import 'package:app_travel/representation/screens/hotel_booking_screen.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> listImageLeft = [
    {
      'name': 'Đà Nẵng',
      'image': AssetHelper.DaNang,
    },
    {
      'name': 'Đà Lạt',
      'image': AssetHelper.DaLat,
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
  ];

  Widget _buildItemCategory(Widget icon, Color color, Function() onTap, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: kMediumPadding,
            ),
            child: icon,
            decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(kItemPadding)),
          ),
          SizedBox(
            height: kItemPadding,
          ),
          Text(title)
        ],
      ),
    );
  }

  Widget _buidlImageHomScreen(String name, String image) {
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
                        Text('4.5')
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
    return AppBarContainer(
      titleString: 'home',
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kItemPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi !', style: TextStyles.defaultStyle.fontHeader.whiteTextColor.bold),
                SizedBox(
                  height: kMediumPadding,
                ),
                Text(
                  'Where are you going next?',
                  style: TextStyles.defaultStyle.fontCaption.whiteTextColor,
                )
              ],
            ),
            Spacer(),
            Icon(
              FontAwesomeIcons.bell,
              size: kDefaultIconSize,
              color: Colors.white,
            ),
            SizedBox(
              width: kMinPadding,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  kItemPadding,
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(kItemPadding),
              child: ImageHelper.loadFromAsset(
                AssetHelper.logo,
              ),
            ),
          ],
        ),
      ),
      implementLeading: false,
      child: Column(
        children: [
          TextField(
            enabled: true,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Search your destination',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.black,
                  size: 14,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    kItemPadding,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: kItemPadding),
            ),
            style: TextStyles.defaultStyle,
            onChanged: (value) {},
            onSubmitted: (String submitValue) {},
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            children: [
              Expanded(
                child: _buildItemCategory(
                    ImageHelper.loadFromAsset(
                      AssetHelper.icoHotel,
                      width: kDefaultIconSize,
                      height: kDefaultIconSize,
                    ),
                    Color(0xffFE9C5E),
                        () {
                      Navigator.of(context).pushNamed(HotelBookingScreen.routeName);
                    },
                    'Hotels'
                ),
              ),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: _buildItemCategory(
                    ImageHelper.loadFromAsset(
                      AssetHelper.icoPlane,
                      width: kDefaultIconSize,
                      height: kDefaultIconSize,
                    ),
                    Color(0xffF77777),
                        () {
                          Navigator.of(context).pushNamed(FlightsBookingScreen.routeName);
                        },
                    'Flights'
                ),
              ),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: _buildItemCategory(
                    ImageHelper.loadFromAsset(
                      AssetHelper.icoHotelPlane,
                      width: kDefaultIconSize,
                      height: kDefaultIconSize,
                    ),
                    Color(0xff3EC8BC),
                        () {
                          Navigator.of(context).pushNamed(AllScreen.routeName);
                        },
                    'All'
                ),
              ),
            ],
          ),
          SizedBox(
            height: kMediumPadding,
          ),
          Row(
            children: [
              Text(
                'Popular Destinations',
                style: TextStyles.defaultStyle.bold,
              ),
              Spacer(),
              Text(
                'See All',
                style: TextStyles.defaultStyle.bold.primaryTextColor,
              ),
            ],
          ),
          SizedBox(
            height: kMediumPadding,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: listImageLeft
                          .map(
                            (e) => _buidlImageHomScreen(
                          e['name']!,
                          e['image']!,
                        ),
                      )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding,
                  ),
                  Expanded(
                    child: Column(
                      children: listImageRight
                          .map(
                            (e) => _buidlImageHomScreen(
                          e['name']!,
                          e['image']!,
                        ),
                      )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
