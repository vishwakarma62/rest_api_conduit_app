import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rest_api_conduit_app/ui/bottomnavigationar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      autologin();
    });
  }

  String? isLoggedIn;
  void autologin() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getString("login");
    print(isLoggedIn);
    if (isLoggedIn != null) {
      if (isLoggedIn == "islogin") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return BottomNavigation(index: 0,);
        }));
        print("is true");
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
        print("is false");
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
      print("is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FlutterLogo(
          size: MediaQuery.of(context).size.height,
        ),
        color: Colors.white,
      ),
    );
  }
}
