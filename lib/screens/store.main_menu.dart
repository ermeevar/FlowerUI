import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/store.dart';
import 'package:flutter/material.dart';

class StoreMainMenu extends StatelessWidget {
  Store _store =
      new Store("Букет столицы", "Свежие цветочки", "8(900)800-40-50");
  List<Shop> _shops = [
    new Shop("г. Казань, Мавлекаева 67", 0),
    new Shop("г. Казань, Проспект Победы 30", 0),
    new Shop("г. Казань, Солнечный город 1, 2 этаж", 0)
  ];

  List<Widget> _viewPages = [
    new Container(
      color: Colors.black,
    ),
    new Container(
      color: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(children: <Widget>[
              new Container(
                color: Color.fromRGBO(130, 147, 153, 100),
                padding: const EdgeInsets.all(20),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    new CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        new Text(_store.name,
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none)),
                        new Text(_store.firstPhone,
                            style: new TextStyle(
                                height: 2,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                decoration: TextDecoration.none)),
                        new Text(
                            // _store.secondPhone == null
                            //     ? " "
                            //     : _store.secondPhone,
                            "8(950)245-78-78",
                            style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                decoration: TextDecoration.none)),
                        new GestureDetector(
                            child: new Text("Изменить",
                                style: new TextStyle(
                                    height: 2,
                                    fontSize: 15.0,
                                    fontFamily: "MontserratBold",
                                    color: Colors.white,
                                    decoration: TextDecoration.none)))
                      ],
                    )
                  ],
                ),
              ),
              new Expanded(
                  child: ListView.builder(
                    itemCount: _shops.length,
                    itemBuilder: (context, index) {
                      return new Container(
                          height: 50,
                          child: new Text(
                            _shops[index].address,
                            style: new TextStyle(
                                fontFamily: "Arial",
                                fontSize: 15,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ));
                    },
              )),
              new Expanded(
                child: new PageView(
                  children: _viewPages,
                ),
              )
            ])));
  }
}
