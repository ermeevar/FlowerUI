import 'package:flower_ui/states/profile.manipulation.dart';
import 'package:flower_ui/screens/store.widgets/store.content.dart';
import 'package:flower_ui/screens/store.widgets/store.information.dart';
import 'package:flower_ui/states/circleProgressBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoreMainMenu extends StatefulWidget {
  StoreMainMenuState createState() => StoreMainMenuState();
}

class StoreMainMenuState extends State<StoreMainMenu>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProfileManipulation.searchProfile(),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return vinousCircleProgressBarScaffold(this);
            case ConnectionState.done:
              return Scaffold(
                resizeToAvoidBottomInset: true,
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
