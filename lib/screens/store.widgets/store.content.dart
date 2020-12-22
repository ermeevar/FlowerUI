import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/screens/store.widgets/store.information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/storeProduct.dart';

class StoreContent extends StatefulWidget {
  @override
  StoreContentState createState() => StoreContentState();
}

class StoreContentState extends State<StoreContent> {
  List<Shop> _shops = [
    new Shop("г. Казань, Мавлекаева 67", 0),
    new Shop(
        "г. Казань, Проспект Победы 3009000000000000000000000000000000000000000000000000000000000000000000000000099hgjhgjhgjhhgjhghhghjhj",
        0),
    new Shop(
        "г. Казань, Солнечный город 1, 2 этаж;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;",
        0)
  ];
  List<StoreProduct> _storeProducts = [
    new StoreProduct("Ландыш", 137.80),
    new StoreProduct("Тюльпан", 137.80),
    new StoreProduct("Роза", 137.80),
    new StoreProduct(
        "Еще роза, 100000000 розззззззззззззззззззззззззззззззззззззззззззззз",
        137.80),
    new StoreProduct("Много роз", 137.80),
    new StoreProduct("Роза роза роза", 137.80),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: new Padding(
      padding: EdgeInsets.all(10),
      child: new PageView(children: [
        _shopsContent(context),
        _productsContent(context),
      ]),
    ));
  }

  Widget _shopsContent(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Color.fromRGBO(110, 53, 76, 1),
      ),
      itemCount: _shops.length,
      itemBuilder: (context, index) {
        return new Container(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Expanded(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: new Text(
                _shops[index].address,
                style: new TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 15,
                    color: Color.fromRGBO(55, 50, 52, 1),
                    decoration: TextDecoration.none),
              ),
            )),
            new FlatButton(
                onPressed: () {},
                padding: EdgeInsets.all(0),
                child: new Text(
                  "Войти",
                  style: new TextStyle(
                      height: 2,
                      fontSize: 15.0,
                      fontFamily: "MontserratBold",
                      color: Color.fromRGBO(110, 53, 76, 1),
                      decoration: TextDecoration.none),
                )),
          ],
        ));
      },
    );
  }

  Widget _productsContent(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Color.fromRGBO(110, 53, 76, 1),
      ),
      itemCount: _storeProducts.length,
      itemBuilder: (context, index) {
        return new Container(
            height: 105,
            alignment: Alignment.centerLeft,
            child: new Expanded(
              child: Padding(
                  padding: EdgeInsets.all(0),
                  child: new Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new Padding(
                        padding: EdgeInsets.only(
                            right: 40, top: 5, left: 5, bottom: 5),
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
                          new Expanded(
                              child: Text(_storeProducts[index].name,
                              overflow: TextOverflow.clip,
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Montserrat",
                                  color: Color.fromRGBO(55, 50, 52, 1),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none))
                          ),
                          new Text(
                              _storeProducts[index].cost.toString() + " руб.",
                              style: new TextStyle(
                                  height: 2,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Montserrat",
                                  color: Color.fromRGBO(55, 50, 52, 1),
                                  decoration: TextDecoration.none)),
                          new FlatButton(
                              onPressed: () {},
                              padding: EdgeInsets.all(0),
                              child: new Text(
                                "Изменить",
                                style: new TextStyle(
                                    height: 1,
                                    fontSize: 15.0,
                                    fontFamily: "MontserratBold",
                                    color: Color.fromRGBO(110, 53, 76, 1),
                                    decoration: TextDecoration.none),
                              )),
                        ],
                      )
                    ],
                  )),
            ));
      },
    );
  }
}
