import 'package:flower_ui/models/shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/store.product.dart';

class StoreContent extends StatefulWidget {
  @override
  StoreContentState createState() => StoreContentState();
}

class StoreContentState extends State<StoreContent>
    with TickerProviderStateMixin {
  String address;
  List<Shop> _shops = [
    new Shop("г. Казань, Мавлекаева 67", 0),
    new Shop(
        "г. Казань, Проспект Победы 3000000000000000000000000099hgjhgjhgjhhgjhghhghjhj",
        0),
    new Shop(
        "г. Казань, Солнечный город 1, 2 этаж",
        0),
    new Shop("г. Казань, Мавлекаева 67", 0),
    new Shop(
        "г. Казань, Проспект Победы 3000000000000000000000000099hgjhgjhgjhhgjhghhghjhj",
        0),
    new Shop(
        "г. Казань, Солнечный город 1, 2 этаж",
        0),
    new Shop("г. Казань, Мавлекаева 67", 0),
    new Shop(
        "г. Казань, Проспект Победы 3000000000000000000000000099hgjhgjhgjhhgjhghhghjhj",
        0),
    new Shop(
        "г. Казань, Солнечный город 1, 2 этаж",
        0),
    new Shop("г. Казань, Мавлекаева 67", 0),
    new Shop(
        "г. Казань, Проспект Победы 3000000000000000000000000099hgjhgjhgjhhgjhghhghjhj",
        0),
    new Shop(
        "г. Казань, Солнечный город 1, 2 этаж",
        0),
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

  void _addShop(Shop shop){
    setState(() {
      _shops.add(shop);
    });
  }

  void  _changeAddress(String addressName){
    setState(() {
      this.address=addressName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            primary: false,
            toolbarHeight: 20,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Color.fromRGBO(110, 53, 76, 1),
              tabs: [
                Text(
                  "Магазины",
                  style: new TextStyle(
                      fontFamily: "MontserratBold",
                      fontSize: 15,
                      color: Color.fromRGBO(110, 53, 76, 1),
                      decoration: TextDecoration.none),
                ),
                Text(
                  "Ассортимент",
                  style: new TextStyle(
                      fontFamily: "MontserratBold",
                      fontSize: 15,
                      color: Color.fromRGBO(110, 53, 76, 1),
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: _shopsContent(context),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: _productsContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopsContent(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Color.fromRGBO(110, 53, 76, 1),
              thickness: 1.5,
              height: 0,
            ),
            itemCount: _shops.length,
            itemBuilder: (context, index) {
              return new Container(
                  padding: EdgeInsets.all(10),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Expanded(
                        child: Text(
                          _shops[index].address,
                          style: new TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 15,
                              color: Color.fromRGBO(55, 50, 52, 1),
                              decoration: TextDecoration.none),
                        ),
                      ),
                      new FlatButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(0),
                          child: new Text(
                            "Войти",
                            style: new TextStyle(
                                fontSize: 15.0,
                                fontFamily: "MontserratBold",
                                color: Color.fromRGBO(110, 53, 76, 1),
                                decoration: TextDecoration.none),
                          )),
                    ],
                  ));
            },
          )),
          FlatButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => _addShopBottomSheet(context),
              );
            },
            padding: EdgeInsets.zero,
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(130, 147, 153, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: new Text(
                    "Добавить магазин",
                    style: new TextStyle(
                        fontSize: 15.0,
                        fontFamily: "MontserratBold",
                        color: Colors.white,
                        decoration: TextDecoration.none)),
              )
          ),
        ],
      ),
    );
  }

  Widget _productsContent(BuildContext context) {
    return Expanded(child: ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Color.fromRGBO(110, 53, 76, 1),
        thickness: 1.5,
        height: 0,
      ),
      itemCount: _storeProducts.length,
      itemBuilder: (context, index) {
        return new Container(
          padding: EdgeInsets.only(top:10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/d/db/Rosa_Peer_Gynt_1.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  Expanded(child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Expanded(
                            child: Text(_storeProducts[index].name,
                                //overflow: TextOverflow.clip,
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "MontserratBold",
                                    color: Color.fromRGBO(55, 50, 52, 1),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none)),
                          ),
                        ),
                        Text(
                            _storeProducts[index].cost.toString() + " руб.",
                            style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Montserrat",
                                color: Color.fromRGBO(55, 50, 52, 1),
                                decoration: TextDecoration.none)),
                      ],
                    ),
                  )),
                ],
              )),
              Column(
                children: [
                  Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(110, 53, 76, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )
                      ),
                      child:  Expanded(child: Text("Цветок",
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none)))
                  ),
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
              ),
            ],
          ),
        );
      },
    ));
  }

  Widget _addShopBottomSheet(context){
    return Container(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: [
              TextFormField(
                cursorColor: Colors.white,
                onChanged: (string){
                  _changeAddress(string);
                },
                style: new TextStyle(
                    height: 2,
                    fontSize: 15.0,
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    decoration: TextDecoration.none),
                decoration: InputDecoration(
                  labelText: "Адрес магазина",
                  focusColor: Colors.white,
                )
              ),
              new Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 30),
                child: FlatButton(
                    onPressed: (){
                      Shop shop = Shop(this.address, 0);
                      _addShop(shop);
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: new Text(
                          "Сохранить",
                          style: new TextStyle(
                              fontSize: 15.0,
                              fontFamily: "MontserratBold",
                              color: Color.fromRGBO(130, 147, 153, 1),
                              decoration: TextDecoration.none)),
                    )
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
