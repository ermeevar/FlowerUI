import 'dart:math';

import 'package:flower_ui/models/order.status.dart';
import 'package:flower_ui/models/web.api.services.dart';
import 'package:flower_ui/screens/order.widgets/order.bouquet.content.dart';
import 'package:flower_ui/screens/order.widgets/order.information.dart';
import 'package:flutter/material.dart';
import 'package:flower_ui/models/order.dart';

class OrderMainMenu extends StatefulWidget {
  Order order;

  OrderMainMenu(this.order);

  @override
  OrderMainMenuState createState() => OrderMainMenuState(order);
}

class OrderMainMenuState extends State<OrderMainMenu> {
  Order order;
  List<OrderStatus> _orderStatuses = [];

  OrderMainMenuState(this.order) {
    _getOrderStatuses();
  }

  _getOrderStatuses() async {
    WebApiServices.fetchOrderStatuses().then((response) {
      var orderStatusesData = orderStatusFromJson(response.data);
      setState(() {
        _orderStatuses = orderStatusesData;
      });
    });
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        child: Column(
          children: [
            _header(context),
            Expanded(child: ListView(
              padding: EdgeInsets.zero,
              children: [
                OrderInformation(order),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 30),
                    child: OrderBouquetContent(order),
                  ),
                ),
              ],
            ),),
          ],
        ),
      ),
    );
  }

  Widget _header(context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          GestureDetector(
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromRGBO(130, 147, 153, 1),
                ),
                Text(
                  "Заказ " + order.id.toString(),
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Color.fromRGBO(130, 147, 153, 1),
                        fontSize: 23,
                      ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
