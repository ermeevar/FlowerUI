import 'package:flower_ui/models/order.dart';
import 'package:flower_ui/models/shop.dart';
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
  List<Order> _orders = [];

  getShopProducts() {
    WebApiServices.fetchOrders().then((response) {
      var ordersData = orderFromJson(response.data);
      setState(() {
        _orders = ordersData
            .where((element) => element.shopId == _shop.id)
            .toList();
      });
    });
  }

  ShopContentState(this._shop) {
    getShopProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: _ordersContent(context),
          ),
        ),
      ),
    );
  }

  Widget _ordersContent(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: _orders.length == 0
              ? Center(
                  child: Container(
                      color: Colors.white,
                      child: Text("В магазине нет ни одного заказа",
                          style: Theme.of(context).textTheme.body1)))
              : ListView.separated(
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
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 20),
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
                                    _orders[index].id.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _orders[index].templateId.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(height: 2),
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
}
