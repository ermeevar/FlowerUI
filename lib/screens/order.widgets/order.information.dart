import 'dart:math';

import 'package:flower_ui/models/order.dart';
import 'package:flower_ui/models/order.status.dart';
import 'package:flower_ui/models/user.dart';
import 'package:flower_ui/models/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderInformation extends StatefulWidget {
  Order _order;

  OrderInformation(this._order);

  OrderInformationState createState() => new OrderInformationState(_order);
}

class OrderInformationState extends State<OrderInformation> {
  Order _order;
  List<OrderStatus> _orderStatuses = [];
  User _user = User();
  bool isCardTapped = false;

  OrderInformationState(this._order) {
    _getProductCategories();
    _getUser();
  }

  _getProductCategories() async {
    await WebApiServices.fetchOrderStatuses().then((response) {
      var orderStatusesData = orderStatusFromJson(response.data);
      setState(() {
        _orderStatuses = orderStatusesData;
      });
    });
  }

  _getUser() async {
    await WebApiServices.fetchUsers().then((response) {
      var usersData = userFromJson(response.data);
      setState(() {
        _user = usersData.firstWhere((element) => element.id == _order.userId);
      });
    });
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: _dataCost(context),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: _productState(context),
          ),
          _user.id != null
              ? Container(
                  padding: EdgeInsets.only(top: 20),
                  child: _userName(context),
                )
              : Text(
                  "Ошибка",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(fontSize: 15, color: Colors.black54),
                ),
          _order.card != null
              ? Container(
                  padding: EdgeInsets.only(top: 20),
                  child: _card(context),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
    );
  }

  Widget _dataCost(context) {
    return Column(
      children: [
        Text(
          DateFormat('dd.MM.yyyy hh:mm').format(_order.finish).toString(),
          style: Theme.of(context).textTheme.body1.copyWith(
                fontSize: 23,
                color: Color.fromRGBO(110, 53, 76, 1),
              ),
        ),
        Text(
          roundDouble(_order.cost, 2).toString() + " ₽",
          style: Theme.of(context).textTheme.body1.copyWith(
                height: 1.5,
              ),
        ),
      ],
    );
  }

  Widget _productState(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Статус заказа",
          style: Theme.of(context)
              .textTheme
              .body1
              .copyWith(color: Colors.black54, fontSize: 15),
        ),
        Container(
          padding: EdgeInsets.only(top: 5),
          child: Wrap(
            children: List.generate(
              _orderStatuses.length,
              (index) => Container(
                padding: EdgeInsets.only(right: 5),
                child: ChoiceChip(
                  label: Text(
                    _orderStatuses[index].name,
                    style: Theme.of(context).textTheme.body1.copyWith(
                        color: _order.orderStatusId == _orderStatuses[index].id
                            ? Colors.white
                            : Color.fromRGBO(110, 53, 76, 1),
                        fontSize: 15),
                  ),
                  selectedColor: Color.fromRGBO(110, 53, 76, 1),
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: Color.fromRGBO(110, 53, 76, 1),
                  ),
                  selected: _order.orderStatusId == _orderStatuses[index].id,
                  onSelected: (isSelect) {
                    setState(() {
                      isSelect
                        ? _order.orderStatusId = _orderStatuses[index].id
                        : _order.orderStatusId = null;
                      WebApiServices.putOrder(_order);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _userName(context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.account_circle,
            size: 30,
            color: Color.fromRGBO(110, 53, 76, 1),
          ),
        ),
        Text(
          _user.name + " " + _user.surname,
          style: Theme.of(context).textTheme.body1.copyWith(
                height: 1.5,
              ),
        ),
      ],
    );
  }

  Widget _card(context) {
    return ExpansionPanelList(
      expansionCallback: (index, istapped) {
        setState(() {
          isCardTapped = !isCardTapped;
        });
      },
      elevation: 1,
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                "Открытка",
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Colors.black54, fontSize: 15),
              ),
            );
          },
          isExpanded: isCardTapped,
          body: Container(
            padding: EdgeInsets.only(
              bottom: 10,
              left: 10,
              right: 10,
            ),
            child: Text(
              _order.card,
              //overflow: TextOverflow.clip,
              softWrap: true,
              style: Theme.of(context).textTheme.body1.copyWith(
                    height: 1.5,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
