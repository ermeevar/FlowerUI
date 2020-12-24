import 'package:flower_ui/models/shop.dart';
import 'package:flutter/material.dart';

class ShopMainMenu extends StatelessWidget {
  Shop _shop;

  ShopMainMenu(this._shop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          color:  Color.fromRGBO(130, 147, 153, 1),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    //width: 200,
                    padding: EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30)
                        )
                    ),
                    child: Text(
                        _shop.address,
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Montserrat",
                            color: Color.fromRGBO(110, 53, 76, 1),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none)),
                    duration: Duration(seconds: 1),
                  )
                ],
              ),

            ],
          )
      )
    );
  }
}