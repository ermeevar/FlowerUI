import 'dart:io';
import 'package:flower_ui/screens/authorization.widgets/authorization.main.menu.dart';
import 'package:flower_ui/screens/store.widgets/store.main.menu.dart';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(
              fontSize: 19,
              fontFamily: "SourceSansPro",
              color: Color.fromRGBO(55, 50, 52, 1),
              decoration: TextDecoration.none),
          body2: TextStyle(
              fontSize: 19,
              fontFamily: "SourceSansPro",
              color: Colors.white,
              decoration: TextDecoration.none),
          title: TextStyle(
              fontSize: 30,
              fontFamily: "Philosopher",
              color: Colors.white,
              decoration: TextDecoration.none),
          subtitle: TextStyle(
              fontSize: 19,
              fontFamily: "Philosopher",
              color: Color.fromRGBO(110, 53, 76, 1),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
            contentPadding: EdgeInsets.zero,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
          )
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Color.fromRGBO(130, 147, 153, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))
          )
        )
      ),
      home: AuthorizationMainMenu(),
    );
  }
}
