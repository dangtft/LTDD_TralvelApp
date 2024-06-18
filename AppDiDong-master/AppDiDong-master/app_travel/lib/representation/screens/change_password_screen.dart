import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/change_password';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<int?> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<void> _changePassword() async {
    int? userId = await _loadUserId();

    if (userId == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('User ID not found.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final String newPassword = _newPasswordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('New Password and Confirm Password do not match.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final String apiUrl = 'https://localhost:7074/api/Hotel/changePassword';

    final Map<String, dynamic> requestData = {
      'userId': userId,
      'newPassword': newPassword,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // Xử lý thành công
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Password changed successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Xử lý lỗi
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to change password. Please try again later.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
