import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/login.dart';
import 'package:app_travel/representation/widgets/container_booking.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ContainerBooking(
      implementTraling: true,
      titleString: 'Profile',
      child: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AssetHelper.avata), // Use AssetImage if the image is a local asset
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Text(
              'Nguyễn Văn A',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('nguyenvana@example.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+84 123 456 789'),
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Hà Nội, Việt Nam'),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor, padding: EdgeInsets.symmetric(vertical: 12), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Đăng xuất',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
