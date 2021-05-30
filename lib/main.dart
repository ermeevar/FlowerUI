import 'dart:io';
import 'package:flower_ui/screens/authorization.widgets/authorization.main.menu.dart';
import 'package:flower_ui/screens/store.widgets/store.main.menu.dart';
import 'package:flower_ui/states/certificate.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  HttpOverrides.global = new Certificate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Color.fromRGBO(110, 53, 76, 1),
            actionTextColor: Colors.white,
          ),
          textTheme: TextTheme(
            body1: TextStyle(
                fontSize: 15,
                fontFamily: "SourceSansPro",
                color: Color.fromRGBO(55, 50, 52, 1),
                decoration: TextDecoration.none),
            body2: TextStyle(
                fontSize: 15,
                fontFamily: "SourceSansPro",
                color: Colors.white,
                decoration: TextDecoration.none),
            title: TextStyle(
                fontSize: 30,
                fontFamily: "Philosopher",
                color: Colors.white,
                decoration: TextDecoration.none),
            subtitle: TextStyle(
                fontSize: 20,
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
              ))),
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Color.fromRGBO(130, 147, 153, 1),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))))),
      home: FutureBuilder<bool>(
          future: isAuthorized(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Scaffold(
                  body: Center(
                    child: Text(
                      "Загрузка...",
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                );
              case ConnectionState.done:
                return snapshot.data
                    ? StoreMainMenu()
                    : AuthorizationMainMenu();
            }
          }),
    );
  }

  Future<bool> isAuthorized() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.getInt('AccountId') == null || prefs.getInt('AccountId') == 0)
      return false;
    else
      return true;
  }
}
