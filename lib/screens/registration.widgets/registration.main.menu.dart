import 'package:flower_ui/entities/account.dart';
import 'package:flower_ui/entities/store.dart';
import 'package:flower_ui/states/profile.manipulation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationMainMenu extends StatefulWidget {
  RegistrationMainMenuState createState() => RegistrationMainMenuState();
}

class RegistrationMainMenuState extends State<RegistrationMainMenu> {
  Store _store= Store();
  Account _account = Account();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        overflow: Overflow.clip,
        children: [
          buildBackgroundGradient(context),
          buildBackgroundCircle(),
          getContent(context),
        ],
      ),
    );
  }

  //#region Content
  Center getContent(BuildContext context) {
    return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                "Регистрация",
                style: Theme.of(context).textTheme.title,
              ),
              getName(context),
              getPhone(context),
              getLogin(context),
              getPassword(context),
              signUp(context),
              Spacer(),
            ],
          ),
        );
  }

  Container signUp(BuildContext context) {
    return Container(
              padding: EdgeInsets.only(top: 50),
              child: FlatButton(
                  onPressed: () async {
                    if(await ProfileManipulation.addStore(_account, _store) == true)
                      Navigator.pop(context);
                    else
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Произошла ошибка", style: Theme.of(context).textTheme.body2,),
                          action: SnackBarAction(
                            label: "Понятно",
                            onPressed: () {
                              // Code to execute.
                            },
                          ),
                        ),
                      );

                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 90),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(40))),
                    child: new Text(
                      "СОХРАНИТЬ",
                      style: Theme.of(context).textTheme.body2.copyWith(
                            color: Color.fromRGBO(110, 53, 76, 1),
                          ),
                    ),
                  )),
            );
  }

  Padding getPassword(BuildContext context) {
    return Padding(
              padding: EdgeInsets.only(right: 40, left: 40, top: 20),
              child: TextFormField(
                  onChanged: (password) {
                    setState(() {
                      this._account.passwordHash = password;
                    });
                  },
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.body2,
                  decoration: InputDecoration(
                    labelText: "Пароль",
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                  )),
            );
  }

  Padding getLogin(BuildContext context) {
    return Padding(
              padding: EdgeInsets.only(right: 40, left: 40, top: 20),
              child: TextFormField(
                  onChanged: (login) {
                    setState(() {
                      this._account.login = login;
                    });
                  },
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.body2,
                  decoration: InputDecoration(
                    labelText: "Логин",
                    focusColor: Colors.white,
                  )),
            );
  }

  Padding getPhone(BuildContext context) {
    return Padding(
              padding: EdgeInsets.only(right: 40, left: 40, top: 20),
              child: TextFormField(
                  onChanged: (phone) {
                    setState(() {
                      this._store.firstPhone = phone;
                    });
                  },
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.body2,
                  decoration: InputDecoration(
                    labelText: "Телефон",
                    focusColor: Colors.white,
                  )),
            );
  }

  Padding getName(BuildContext context) {
    return Padding(
              padding: EdgeInsets.only(right: 40, left: 40, top: 40),
              child: TextFormField(
                  onChanged: (name) {
                    setState(() {
                      this._store.name = name;
                    });
                  },
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.body2,
                  decoration: InputDecoration(
                    labelText: "Наименование сети",
                    focusColor: Colors.white,
                  )),
            );
  }
  //#endregion

  //#region Background
  Stack buildBackgroundCircle() {
    return Stack(
      children: [
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
    );
  }

  Container buildBackgroundGradient(BuildContext context) {
    return Container(
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
    );
  }
  //#endregion
}
