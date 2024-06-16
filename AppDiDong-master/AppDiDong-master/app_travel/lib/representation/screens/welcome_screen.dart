import 'package:app_travel/core/constants/color_constants.dart';
import 'package:app_travel/login.dart';
import 'package:app_travel/representation/screens/main_app.dart';
import 'package:app_travel/sign_up.dart';
import 'package:flutter/material.dart';

class WelcommeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 5),
            Align(alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(MainApp.routeName);
                },
                child: Text(
                    'SKIP',
                  style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset("assets/images/background_travel.png"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: ColorPalette.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: ColorPalette.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}