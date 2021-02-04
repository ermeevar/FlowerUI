import 'dart:convert';

import 'package:flower_ui/models/order.dart';
import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/shop.product.dart';
import 'package:flower_ui/models/store.dart';
import 'package:flower_ui/models/store.product.dart';
import 'package:flower_ui/models/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopContent extends StatefulWidget {
  Shop _shop;

  ShopContent(this._shop);

  @override
  ShopContentState createState() => ShopContentState(_shop);
}

class ShopContentState extends State<ShopContent>
    with TickerProviderStateMixin {
  Shop _shop;
  bool _isEmpty=false;
  List<Order> _orders=[];
  List<StoreProduct> _storeProducts=[];
  List<ShopProduct> _shopProducts=[];

  getShopProducts(){
    List<ShopProduct> shopProductsData = List<ShopProduct>();
    List<StoreProduct> storeProductsData = List<StoreProduct>();
    List<ShopProduct> shopProductsDataF = List<ShopProduct>();
    List<StoreProduct> storeProductsDataF = List<StoreProduct>();

    WebApiServices.fetchStoreProduct().then((response){
      Iterable list = json.decode(response.body);
      storeProductsData = list
          .map((model)=>StoreProduct.fromObject(model))
          .toList();
    });
    WebApiServices.fetchShopProduct().then((response){
      Iterable list = json.decode(response.body);
      shopProductsData = list
          .map((model)=>ShopProduct.fromObject(model))
          .toList()
          .where((element) => element.id==_shop.id);
    });

    for(int i =0; i<shopProductsData.length; i++){
      for(int ii =0; ii<storeProductsData.length; ii++){
        if(shopProductsData[i].storeProductId==storeProductsData[ii].id){
          shopProductsDataF.add(shopProductsData[i]);
          storeProductsDataF.add(storeProductsData[ii]);
        }
      }
    }

    setState(() {
      _shopProducts=shopProductsDataF;
      _storeProducts=storeProductsDataF;
    });
  }

  ShopContentState(this._shop);

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
                style: Theme.of(context).textTheme.subtitle
                ),
                Text(
                  "Ассортимент",
                    style: Theme.of(context).textTheme.subtitle
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
          child: _orders.length==0?Center(child: Container(color:Colors.white, child: Text("В магазине нет ни одного заказа", style: Theme.of(context).textTheme.body1))):ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Color.fromRGBO(110, 53, 76, 1),
              thickness: 1.5,
              height: 0,
            ),
            itemCount: _orders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
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
                                  style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _orders[index].state,
                                  style: Theme.of(context).textTheme.body1.copyWith(height: 2),
                                ),
                              ],
                            ),
                          )),
                    ],
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
          child: _storeProducts.length==0?Center(child: Container(color:Colors.white, child: Text("Пока товаров никаких нет, ожидайте", style: Theme.of(context).textTheme.body1))):ListView.separated(
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
                                  style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold)
                              ),
                              Text(
                                _storeProducts[index].cost.toString() + " руб.",
                                  style: Theme.of(context).textTheme.body1.copyWith(height: 2)
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