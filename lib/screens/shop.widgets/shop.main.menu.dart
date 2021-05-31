import 'package:flower_ui/entities/shop.dart';
import 'package:flower_ui/screens/shop.widgets/shop.content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopMainMenu extends StatelessWidget {
  Shop _shop;

  ShopMainMenu(this._shop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: [
            getTitle(context),
            Expanded(
              child: ShopContent(_shop),
            ),
          ],
        ),
      ),
    );
  }

  //#region Title
  Container getTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 25, left: 10),
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 0),
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Color.fromRGBO(130, 147, 153, 1),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Text(
              _shop.address,
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: Color.fromRGBO(130, 147, 153, 1)),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration drawBackground() {
    return BoxDecoration(
        color: Color.fromRGBO(130, 147, 153, 1),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)));
  }
  //#endregion
}
