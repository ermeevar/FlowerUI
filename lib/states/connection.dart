import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Connection{
  static checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return false;
    }

    return true;
  }

  static Future<void> _showConnectionError() async {
    return showDialog<void>(
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Text(
              'Нет соединения с интернетом',
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                onPressed: () {
                  exit(0);
                },
                child: new Text(
                  "Закрыть",
                  style: Theme.of(context).textTheme.body1.copyWith(
                    color: Color.fromRGBO(130, 147, 153, 1),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}