import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/storeProduct.dart';

class StoreMainMenu extends StatelessWidget {
  Store _store =
      new Store("Букет столицы", "Свежие цветочки", "8(900)800-40-50");
  List<Shop> _shops = [
    new Shop("г. Казань, Мавлекаева 67", 0),
    new Shop("г. Казань, Проспект Победы 30", 0),
    new Shop("г. Казань, Солнечный город 1, 2 этаж", 0)
  ];
  List<StoreProduct> _storeProducts = [
    new StoreProduct("Ландыш", 137.80),
    new StoreProduct("Тюльпан", 137.80),
    new StoreProduct("Роза", 137.80),
    new StoreProduct("Еще роза, 100000000 розззззззззззззззззззззззззззззззззззззззззззззз", 137.80),
    new StoreProduct("Много роз", 137.80),
    new StoreProduct("Роза роза роза", 137.80),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: null,
          floatingActionButton: new FloatingActionButton(
            onPressed: (){

            },
            backgroundColor: Color.fromRGBO(130, 147, 153, 1),
            child: Icon(Icons.add_outlined),
          ),
          body: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(children: <Widget>[
                new Container(
                  color: Color.fromRGBO(130, 147, 153, 1),
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
                          new FlatButton(
                              onPressed: () {
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.black,
                                  content: const Text("hello"),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      print('Done pressed!');
                                    },
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                              child: new Text("Изменить",
                                  style: new TextStyle(
                                      height: 2,
                                      fontSize: 15.0,
                                      fontFamily: "MontserratBold",
                                      color: Colors.white,
                                      decoration: TextDecoration.none))),
                        ],
                      )
                    ],
                  ),
                ),
                new Expanded(
                    child: new Padding(
                  padding: EdgeInsets.all(20),
                  child: new PageView(children: [
                    new ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Color.fromRGBO(110, 53, 76, 1),
                      ),
                      itemCount: _shops.length,
                      itemBuilder: (context, index) {
                        return new Container(
                            height: 30,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Text(
                                  _shops[index].address,
                                  style: new TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      color: Color.fromRGBO(55, 50, 52, 1),
                                      decoration: TextDecoration.none),
                                ),
                                new FlatButton(
                                    onPressed: () {

                                    },
                                    padding: EdgeInsets.all(0),
                                    child: new Text("Войти",
                                        style: new TextStyle(
                                            height: 2,
                                            fontSize: 15.0,
                                            fontFamily: "MontserratBold",
                                            color: Color.fromRGBO(110, 53, 76, 1),
                                            decoration: TextDecoration.none),
                                    )
                                ),
                              ],
                            )
                        );
                      },
                    ),
                    new ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Color.fromRGBO(110, 53, 76, 1),
                      ),
                      itemCount: _storeProducts.length,
                      itemBuilder: (context, index) {
                        return new Container(
                          height: 105,
                            alignment: Alignment.centerLeft,
                            child: new Container(
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: new Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     new Padding(
                                       padding: EdgeInsets.only(right: 40, top: 5, left: 5, bottom: 5),
                                        child: new CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            'https://upload.wikimedia.org/wikipedia/commons/d/db/Rosa_Peer_Gynt_1.jpg'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                     ),
                                     new Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         new Text(_storeProducts[index].name,
                                             overflow: TextOverflow.clip,
                                             style: new TextStyle(
                                                 fontSize: 20.0,
                                                 fontFamily: "Montserrat",
                                                 color: Color.fromRGBO(55, 50, 52, 1),
                                                 fontWeight: FontWeight.normal,
                                                 decoration: TextDecoration.none)),
                                         new Text(_storeProducts[index].cost.toString() + " руб.",
                                             style: new TextStyle(
                                                 height: 2,
                                                 fontSize: 15.0,
                                                 fontWeight: FontWeight.normal,
                                                 fontFamily: "Montserrat",
                                                 color: Color.fromRGBO(55, 50, 52, 1),
                                                 decoration: TextDecoration.none)),
                                         new FlatButton(
                                             onPressed: () {

                                             },
                                             padding: EdgeInsets.all(0),
                                             child: new Text("Изменить",
                                               style: new TextStyle(
                                                   height: 1,
                                                   fontSize: 15.0,
                                                   fontFamily: "MontserratBold",
                                                   color: Color.fromRGBO(110, 53, 76, 1),
                                                   decoration: TextDecoration.none),
                                             )
                                         ),
                                       ],
                                     )
                                   ],
                                )
                              ),
                            )
                        );
                      },
                    ),
                  ]),
                ))
              ])),
        ));
  }
}
