import 'dart:convert';
import 'package:app_travel/data/model/hotel_model.dart';
import 'package:app_travel/representation/screens/detail_hotel_screen.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:app_travel/representation/widgets/item_hotel_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({Key? key}) : super(key: key);

  static const String routeName = '/hotels_screen';

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  late Future<List<Hotel>> _futureHotels;

  @override
  void initState() {
    super.initState();
    _futureHotels = fetchHotels();
  }

  Future<List<Hotel>> fetchHotels() async {
    final response = await http.get(Uri.parse('https://localhost:7074/api/Hotel/hotels'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((hotel) => Hotel.fromJson(hotel)).toList();
    } else {
      throw Exception('Failed to load hotels');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      implementTraling: true,
      titleString: 'Hotels',
      child: FutureBuilder<List<Hotel>>(
        future: _futureHotels,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hotels available'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!
                    .map(
                      (hotel) => ItemHotelWidget(
                    hotelModel: hotel,
                    onTap: () {
                      Navigator.of(context).pushNamed(DetailHotelScreen.routeName, arguments: hotel);
                    },
                  ),
                )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
