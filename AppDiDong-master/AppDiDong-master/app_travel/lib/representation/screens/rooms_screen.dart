import 'dart:convert';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/data/model/room_model.dart';
import 'package:app_travel/representation/screens/check_out_screen.dart';
import 'package:app_travel/representation/widgets/app_bar_container.dart';
import 'package:app_travel/representation/widgets/item_room_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  static const String routeName = '/rooms_screen';

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  late Future<List<Room>> _futureRooms;

  @override
  void initState() {
    super.initState();
    _futureRooms = fetchRooms();
  }

  Future<List<Room>> fetchRooms() async {
    final response = await http.get(Uri.parse('https://localhost:7074/api/Hotel/rooms'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((room) => Room.fromJson(room)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: 'Select room',
      child: FutureBuilder<List<Room>>(
        future: _futureRooms,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No rooms available'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!
                    .map(
                      (room) => ItemRoomWidget(
                    roomModel: room,
                    onTap: () {
                      Navigator.of(context).pushNamed(CheckOutScreen.routeName, arguments: room);
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
