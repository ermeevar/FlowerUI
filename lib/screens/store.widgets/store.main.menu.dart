import 'package:connectivity/connectivity.dart';
import 'package:flower_ui/models/account.dart';
import 'package:flower_ui/models/profile.info.dart';
import 'package:flower_ui/models/store.dart';
import 'package:flower_ui/models/web.api.services.dart';
import 'package:flower_ui/screens/store.widgets/store.content.dart';
import 'package:flower_ui/screens/store.widgets/store.information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreMainMenu extends StatefulWidget {
  StoreMainMenuState createState() => StoreMainMenuState();
}

class StoreMainMenuState extends State<StoreMainMenu>
    with SingleTickerProviderStateMixin {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  StoreMainMenuState() {
    checkConnection();
  }

  getProfile() async {
    final SharedPreferences prefs = await _prefs;

    await WebApiServices.fetchAccount().then((response) {
      var accountData = accountFromJson(response.data);
      ProfileInfo.account = accountData
          .firstWhere((element) => element.id == prefs.getInt('AccountId'));
      print(ProfileInfo.account.id);
    });

    await WebApiServices.fetchStore().then((response) {
      var storeData = storeFromJson(response.data);
      ProfileInfo.store = storeData
          .firstWhere((element) => element.id == prefs.getInt('StoreId'));
    });
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
    return FutureBuilder(
        future: getProfile(),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                body: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor:
                        ColorTween(begin:Color.fromRGBO(110, 53, 76, 1),
                            end: Color.fromRGBO(130, 147, 153, 1))
                            .animate(
                          AnimationController(
                              duration: const Duration(microseconds: 10),
                              vsync: this),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            case ConnectionState.done:
              return Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Column(children: <Widget>[
                      StoreInformation(),
                      StoreContent(),
                    ])),
              );
          }
        });
  }
}
