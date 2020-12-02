import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/store.dart';
import 'package:flutter/material.dart';

class StoreMainMenu extends StatelessWidget {
  Store _store = new Store("Твой букетик", "Свежие цветочки", "89008004050");
  List<Shop> _shops =[
    new Shop("г. Казань, Мавлекаева 67", 0, null),
    new Shop("г. Казань, Проспект Победы 30", 0, null),
    new Shop("г. Казань, Солнечный город 1, 2 этаж", 0, null)
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: [
          new Container(
            color: Color(0x829399),
            child: new Row(
              children: [
                new Image(),
                new Column(
                  children: [
                    new Text(
                      _store.name,
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Montesserat",
                        color: Colors.white
                      )
                    ),
                    new Text(
                      _store.firstPhone,
                      style: new TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Montesserat",
                        color: Colors.white
                      )
                    ),
                    new Text(
                      _store.secondPhone,
                      style: new TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Montesserat",
                        color: Colors.white
                      )
                    ),
                    new GestureDetector(
                      child: new Text(
                        "Изменить",
                        style: new TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Montesserat",
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
          new ListView.builder(
            itemCount: _shops.length,
            itemBuilder: (BuildContext context, int index){
              return new Container(
                color: Color(0x829399),
                height: 50.0,
                child: new Row(
                  children: [
                    new Text(
                      _shops[index].address,
                      style: new TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Montesserat",
                        color: Color(0x373234),
                        fontWeight: FontWeight.bold
                      )
                    ),
                    new Image()
                  ],
                ),
              );
            }
          )
        ]
      )


    );
  }
}