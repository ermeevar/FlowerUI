import 'package:flower_ui/models/shop.dart';
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
              Container(
                padding: EdgeInsets.only(right: 25),
                child: Expanded(child: Container(
                        padding: EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 0),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(130, 147, 153, 1),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30)
                            )
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }
                              ),
                              Expanded(child: Text(
                                _shop.address,
                                style: new TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none))),
                            ]
                        )
                      ))
                  ),
              ShopContent()
            ],
          )
      )
    );
  }
}