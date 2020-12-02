import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/store.dart';
import 'package:flutter/material.dart';

class StoreMainMenu extends StatelessWidget {
  Store _store = new Store("Твой букетик", "Свежие цветочки", "89008004050");
  List<Shop> _shops =[
    new Shop("г. Казань, Мавлекаева 67", 0),
    new Shop("г. Казань, Проспект Победы 30", 0),
    new Shop("г. Казань, Солнечный город 1, 2 этаж", 0)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
              children: [
              new Container(
                color: Colors.blue,
                child: new Row(
                  children: [
                    //new Image()?,
                    new Column(
                      children: [
                        new Text(
                          _store.name,
                          style: new TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Arial",
                            color: Colors.white
                          )
                        ),
                        new Text(
                          _store.firstPhone,
                          style: new TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Arial",
                            color: Colors.white
                          )
                        ),
                        new Text(
                          _store.secondPhone == null? " " : _store.secondPhone,
                          style: new TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Arial",
                            color: Colors.white
                          )
                        ),
                        new GestureDetector(
                          child: new Text(
                            "Изменить",
                            style: new TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Arial",
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            )
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),


          ]
        )
        )
    );
  }
}