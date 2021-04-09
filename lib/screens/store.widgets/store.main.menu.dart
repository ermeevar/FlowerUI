import 'package:connectivity/connectivity.dart';
import 'package:flower_ui/models/account.dart';
import 'package:flower_ui/models/store.dart';
import 'package:flower_ui/screens/store.widgets/store.content.dart';
import 'package:flower_ui/screens/store.widgets/store.information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreMainMenu extends StatelessWidget {
  static Store store;
  static Account account;

  StoreMainMenu() {
    store = Store();
    store.id = 1;
    store.name = "Букет столицы";
    store.firstPhone = "8(900)200-20-20";
    store.secondPhone = "8(950)245-78-78";

    account = Account();
    account.id = 1;
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      await _showConnectionError();
    }
  }

  Future<void> _showConnectionError() async {
    return showDialog<void>(
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Text('Нет соединения с интернетом', style: Theme.of(context).textTheme.body1,),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(children: <Widget>[
            StoreInformation(store),
            StoreContent(),
          ])),
    );
  }
}
