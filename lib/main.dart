
import 'package:fl_xcel/screens/login.dart';
import 'package:fl_xcel/screens/signup.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
          primarySwatch: Colors.blue,
          accentColor: Colors.greenAccent
      ),
      initialRoute: '/login',
      routes:{
        '/login': (BuildContext context) => LoginRoute(),
        '/signUp': (BuildContext context) => SignUpRoute()
      },
    );
  }
}

