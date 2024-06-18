import 'dart:convert';
import 'package:app_travel/core/constants/color_constants.dart';
import 'package:app_travel/representation/screens/main_app.dart';
import 'package:app_travel/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/images/background_travel.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // If the form is valid, attempt login
                              _loginUser();
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignUpScreen.routeName);
                            },
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: ColorPalette.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // API Endpoint for login
    String apiUrl = 'https://localhost:7074/api/Hotel/login';

    try {
      // Send POST request to the API
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        int userId = jsonResponse['userId'];
        await _saveUserId(userId);
        // Successful login, navigate to main app screen
        Navigator.pushReplacementNamed(context, MainApp.routeName);
      } else if (response.statusCode == 404) {
        // Handle not found error
        _showErrorDialog('Invalid email or password');
      } else {
        // Handle other errors
        _showErrorDialog('Something went wrong');
      }
    } catch (e) {
      // Handle network errors
      _showErrorDialog('Network error. Please try again.');
    }
  }

  Future<void> _saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
