import 'package:flower_ui/entities/order.dart';
import 'package:flower_ui/entities/order.status.dart';
import 'package:flower_ui/entities/shop.dart';
import 'package:flower_ui/states/calc.dart';
import 'package:flower_ui/states/divider.dart';
import 'package:flower_ui/states/web.api.services.dart';
import 'package:flower_ui/screens/order.widgets/order.main.menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShopContent extends StatefulWidget {
  Shop _shop;

  ShopContent(this._shop);

  @override
  ShopContentState createState() => ShopContentState(_shop);
}

class ShopContentState extends State<ShopContent>
    with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  Shop _shop;
  List<Order> _orders = [];
  List<OrderStatus> _orderStatuses = [];

  ShopContentState(this._shop) {
    _getOrders();
    _getOrderStatuses();
  }

  //#region GetData
  Future<void> _refresh()async{
    setState(() async{
      await _getOrders();
      await _getOrderStatuses();
    });
  }

  _getOrders() async {
    await WebApiServices.fetchOrders().then((response) {
      var ordersData = orderFromJson(response.data);
      setState(() {
        _orders = ordersData
            .where((element) => element.shopId == _shop.id)
            .toList()
            .reversed
            .toList();
      });
    });
  }

  _getOrderStatuses() async {
    WebApiServices.fetchOrderStatuses().then((response) {
      var orderStatusesData = orderStatusFromJson(response.data);
      setState(() {
        _orderStatuses = orderStatusesData;
      });
    });
  }
  //#endregion

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: _ordersContent(context),
          ),
        ),
      ),
    );
  }

  OrderStatus _getOrderStatusById(int orderStatusId) {
    return _orderStatuses.firstWhere((element) => element.id == orderStatusId);
  }

  Scaffold _ordersContent(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: _orders.length == 0
            ? showNullOrderError(context)
            : _buildOrderList(),
      ),
    );
  }

  Widget _buildOrderList() {
    return RefreshIndicator(
      color: Color.fromRGBO(110, 53, 76, 1),
      key: refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => getDivider(),
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderMainMenu(
                    _orders[index],
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://www.meme-arsenal.com/memes/70c29cb4ca092108a7b2084a24af52f6.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                    getOrderValueContent(index, context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded getOrderValueContent(int index, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "№ " + _orders[index].id.toString(),
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 25),
            ),
            Text(
                DateFormat('Заказ на dd.MM.yyyy hh:mm')
                    .format(_orders[index].finish)
                    .toString(),
                style: Theme.of(context).textTheme.body1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getOrderStatusById(_orders[index].orderStatusId).name,
                  style: Theme.of(context).textTheme.body1.copyWith(
                        height: 2,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(110, 53, 76, 1),
                      ),
                ),
                Text(
                  Calc.roundDouble(_orders[index].cost, 2).toString() + " ₽",
                  style: Theme.of(context).textTheme.body1.copyWith(
                        height: 2,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(110, 53, 76, 1),
                      ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Center showNullOrderError(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Text("В магазине нет ни одного заказа",
            style: Theme.of(context).textTheme.body1),
      ),
    );
  }
}
