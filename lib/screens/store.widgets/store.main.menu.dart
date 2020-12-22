import 'package:flower_ui/screens/store.widgets/store.content.dart';
import 'package:flower_ui/screens/store.widgets/store.information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreMainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
