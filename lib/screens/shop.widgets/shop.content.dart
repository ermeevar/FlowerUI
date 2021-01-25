import 'package:flower_ui/models/order.dart';
import 'package:flower_ui/models/store.product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopContent extends StatefulWidget {
  @override
  ShopContentState createState() => ShopContentState();
}

class ShopContentState extends State<ShopContent>
    with TickerProviderStateMixin {
  bool _isEmpty=false;

  List<Order> _orders = [
    Order("59HY800HJJ", "В обработке"),
    Order("890HH009DJ", "В обработке"),
    Order("889045JU8J", "Готов"),
    Order("J5453KJH4H", "Выдан покупателю"),
    Order("34B5J343HJ", "Выдан покупателю"),
    Order("34K3HH45JH", "Выдан покупателю"),
    Order("34I53HH4JH", "Выдан покупателю"),
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            primary: false,
            toolbarHeight: 30,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Color.fromRGBO(110, 53, 76, 1),
              tabs: [
                Text(
                  "Заказы",
                  style: new TextStyle(
                      fontFamily: "MontserratBold",
                      fontSize: 15,
                      color:  Color.fromRGBO(110, 53, 76, 1),
                      decoration: TextDecoration.none),
                ),
                Text(
                  "Ассортимент",
                  style: new TextStyle(
                      fontFamily: "MontserratBold",
                      fontSize: 15,
                      color:  Color.fromRGBO(110, 53, 76, 1),
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: _ordersContent(context),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: _productsContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _ordersContent(BuildContext context){
    return Scaffold(
      body: Container(
        color: Colors.white,
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Color.fromRGBO(110, 53, 76, 1),
              thickness: 1.5,
              height: 0,
            ),
            itemCount: _orders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              'https://www.meme-arsenal.com/memes/70c29cb4ca092108a7b2084a24af52f6.jpg'),
                          backgroundColor: Colors.transparent,
                        ),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _orders[index].name,
                                    style: new TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 20,
                                        color: Color.fromRGBO(55, 50, 52, 1),
                                        decoration: TextDecoration.none),
                                  ),
                                  Text(
                                    _orders[index].state,
                                    style: new TextStyle(
                                        height: 2,
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        color: Color.fromRGBO(55, 50, 52, 1),
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
  Widget _productsContent(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Color.fromRGBO(110, 53, 76, 1),
              thickness: 1.5,
              height: 0,
            ),
            itemCount: _storeProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/d/db/Rosa_Peer_Gynt_1.jpg'),
                        backgroundColor: Colors.transparent,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _storeProducts[index].name,
                                style: new TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 20,
                                    color: Color.fromRGBO(55, 50, 52, 1),
                                    decoration: TextDecoration.none),
                              ),
                              Text(
                                _storeProducts[index].cost.toString() + " руб.",
                                style: new TextStyle(
                                    height: 2,
                                    fontFamily: "Montserrat",
                                    fontSize: 15,
                                    color: Color.fromRGBO(55, 50, 52, 1),
                                    decoration: TextDecoration.none),
                              ),
                            ],
                          ),
                        )),
                      Switch(
                        inactiveTrackColor: Color.fromRGBO(130, 147, 153, 1),
                        activeColor: Colors.white,
                          activeTrackColor: Color.fromRGBO(110, 53, 76, 1),
                          value: _isEmpty,
                          onChanged: (isEmpty){
                            setState(() {
                              _isEmpty=isEmpty;
                            });
                          }
                      )
                  ],
                ),
              ));
            },
          )),
    );
  }
}