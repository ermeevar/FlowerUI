import 'package:flower_ui/entities/order.dart';
import 'package:flower_ui/entities/order.status.dart';
import 'package:flower_ui/entities/user.dart';
import 'package:flower_ui/states/calc.dart';
import 'package:flower_ui/states/nullContainer.dart';
import 'package:flower_ui/states/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderInformation extends StatefulWidget {
  Order _order;

  OrderInformation(this._order);

  OrderInformationState createState() => new OrderInformationState(_order);
}

class OrderInformationState extends State<OrderInformation> {
  Order _order = Order();
  User _user = User();
  bool isCardTapped = false;
  List<OrderStatus> _orderStatuses = [];

  OrderInformationState(this._order) {
    _getProductCategories();
    _getUsers();
  }

  //#region GetData
  _getProductCategories() async {
    await WebApiServices.fetchOrderStatuses().then((response) {
      var orderStatusesData = orderStatusFromJson(response.data);
      setState(() {
        _orderStatuses = orderStatusesData;
      });
    });
  }

  _getUsers() async {
    await WebApiServices.fetchUsers().then((response) {
      var usersData = userFromJson(response.data);
      setState(() {
        _user = usersData.firstWhere((element) => element.id == _order.userId);
      });
    });
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dataCost(context), //Cost
          _productState(context),
          _user.id != null ? _userInfo(context) : showNullUserError(context),
          _order.card != null ? _card(context) : nullContainer(),
        ],
      ),
    );
  }

  Text showNullUserError(BuildContext context) {
    return Text(
      "Ошибка",
      style: Theme.of(context)
          .textTheme
          .body1
          .copyWith(fontSize: 15, color: Colors.black54),
    );
  }

  Center _dataCost(context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              DateFormat('dd.MM.yyyy hh:mm').format(_order.finish).toString(),
              style: Theme.of(context).textTheme.body1.copyWith(
                    fontSize: 23,
                    color: Color.fromRGBO(110, 53, 76, 1),
                  ),
            ),
            Text(
              Calc.roundDouble(_order.cost, 2).toString() + " ₽",
              style: Theme.of(context).textTheme.body1.copyWith(
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  //#region State
  Widget _productState(context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitleStatus(context),
          buildStatusList(context),
        ],
      ),
    );
  }

  Container buildStatusList(context) {
    return Container(
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
    );
  }

  Text getTitleStatus(context) {
    return Text(
      "Статус заказа",
      style: Theme.of(context)
          .textTheme
          .body1
          .copyWith(color: Colors.black54, fontSize: 15),
    );
  }
  //endregion

  Widget _userInfo(context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
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
      ),
    );
  }

  Widget _card(context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: ExpansionPanelList(
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
      ),
    );
  }
}
