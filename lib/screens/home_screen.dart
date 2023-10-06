import 'package:flutter/material.dart';
import 'package:univenty/auth.dart';
import 'package:univenty/main.dart';

class HomeScreen extends StatelessWidget {
  final authHandler = new Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome: ")),
      body: Center(
          child: Column(
            children: <Widget>[
              Text("Home page", textScaleFactor: 2),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.red),
                  onPressed: () {
                    authHandler.handleSignout();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white, fontSize: 22)
                  ),
              )
          ]
        )
      )
    );
  }
}