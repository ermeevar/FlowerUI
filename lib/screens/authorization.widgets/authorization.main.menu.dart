import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthorizationMainMenu extends StatefulWidget {
  AuthorizationMainMenuState createState() => AuthorizationMainMenuState();
}

class AuthorizationMainMenuState extends State<AuthorizationMainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.clip,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(110, 53, 76, 1),
                  Color.fromRGBO(130, 147, 153, 1),
                ],
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 10,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 35,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
              ),
            ),
          ),
          Positioned(
            top: -20,
            right: -25,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
              ),
            ),
          ),
          Positioned(
            top: -30,
            right: 40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "Вход",
                  style: Theme.of(context).textTheme.title,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, top: 40),
                  child: TextFormField(
                      onChanged: (secondPhone) {},
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.body2,
                      decoration: InputDecoration(
                        labelText: "Логин",
                        focusColor: Colors.white,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, top: 30),
                  child: TextFormField(
                      onChanged: (secondPhone) {},
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.body2,
                      decoration: InputDecoration(
                        labelText: "Пароль",
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(top: 80),
                  child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 90),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: new Text(
                          "ВОЙТИ",
                          style: Theme.of(context).textTheme.body2.copyWith(
                                color: Color.fromRGBO(110, 53, 76, 1),
                              ),
                        ),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: FlatButton(
                    onPressed: null,
                    padding: EdgeInsets.zero,
                    child: new Text(
                      "Зарегистрироваться",
                      style: Theme.of(context).textTheme.body2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 20,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
