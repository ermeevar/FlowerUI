import 'package:flower_ui/entities/order.status.dart';
import 'package:flower_ui/states/web.api.services.dart';
import 'package:flower_ui/screens/order.widgets/order.bouquet.content.dart';
import 'package:flower_ui/screens/order.widgets/order.information.dart';
import 'package:flutter/material.dart';
import 'package:flower_ui/entities/order.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        child: Column(
          children: [
            _header(context),
            _body(),
          ],
        ),
      ),
    );
  }

  Expanded _body() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          OrderInformation(order),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: OrderBouquetContent(order),
          ),
        ],
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
