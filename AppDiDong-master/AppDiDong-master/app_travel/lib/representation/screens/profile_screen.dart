import 'dart:convert';
import 'package:app_travel/data/service/auth_service.dart';
import 'package:app_travel/representation/screens/change_password_screen.dart';
import 'package:app_travel/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_travel/core/constants/dismension_constants.dart';
import 'package:app_travel/core/helpers/assets_helper.dart';
import 'package:app_travel/data/model/user_model.dart';
import 'package:app_travel/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User?> _userFuture;
  int? userId;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUserId();
  }

  Future<User?> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
    if (userId != null) {
      return fetchUser(userId!);
    } else {
      return null;
    }
  }

  Future<User?> fetchUser(int userId) async {
    final response = await http.get(Uri.parse('https://localhost:7074/api/Hotel/GetUser/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      
    }
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Not Logged In'),
        content: Text('Please log in to view your profile.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss dialog
              Navigator.of(context).pushNamed(LoginScreen.routeName); // Navigate to LoginScreen
            },
            child: Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss dialog
              Navigator.of(context).pushNamed(SignUpScreen.routeName); // Navigate to SignUpScreen
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<User?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You are not logged in.'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showLoginDialog(),
                    child: Text('Login'),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            );
          } else {
            User user = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(AssetHelper.avata),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(user.email),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(user.phone),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text(user.address),
                  ),
                  SizedBox(height: kDefaultPadding),
                  ElevatedButton(
                    onPressed: () async {
                      await AuthService.logout(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  ElevatedButton(
                    onPressed: () {
                      // Handle change password logic
                      Navigator.of(context).pushReplacementNamed(ChangePasswordScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
