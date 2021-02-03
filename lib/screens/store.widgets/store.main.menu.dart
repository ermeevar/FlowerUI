import 'package:flower_ui/models/store.dart';
import 'package:flower_ui/screens/store.widgets/store.content.dart';
import 'package:flower_ui/screens/store.widgets/store.information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreMainMenu extends StatelessWidget {
  Store store;

  StoreMainMenu(){
    store=new Store();
    store.id=1;
    store.name="Букет столицы";
    store.firstPhone="8(900)200-20-20";
    store.secondPhone="8(950)245-78-78";
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
          StoreContent(store),
        ])),
    );
  }
}
