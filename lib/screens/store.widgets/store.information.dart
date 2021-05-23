import 'package:flower_ui/states/profile.manipulation.dart';
import 'package:flower_ui/states/web.api.services.dart';
import 'package:flower_ui/screens/authorization.widgets/authorization.main.menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreInformation extends StatefulWidget {
  @override
  StoreInformationState createState() => StoreInformationState();
}

class StoreInformationState extends State<StoreInformation>
    with SingleTickerProviderStateMixin {
  bool _isTab = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: Color.fromRGBO(130, 147, 153, 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        child: _isTab ? _change(context) : _read(context),
        height: _isTab ? 470 : 200,
        duration: Duration(seconds: 1),
      ),
    );
  }

  Widget _read(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            backgroundColor: Colors.transparent,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileManipulation.store.name != null
                  ? Text(ProfileManipulation.store.name,
                      style: Theme.of(context).textTheme.title)
                  : Text(""),
              ProfileManipulation.store.firstPhone != null
                  ? Text(ProfileManipulation.store.firstPhone,
                      style:
                          Theme.of(context).textTheme.body2.copyWith(height: 2))
                  : Text(""),
              ProfileManipulation.store.secondPhone != null
                  ? Text(ProfileManipulation.store.secondPhone,
                      style: Theme.of(context).textTheme.body2)
                  : Text(""),
              new FlatButton(
                  onPressed: () {
                    _taped();
                  },
                  padding: EdgeInsets.zero,
                  child: new Text("Изменить",
                      style: new TextStyle(
                          height: 2,
                          fontSize: 19,
                          fontFamily: "SourceSansPro",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none))),
            ],
          )
        ],
      ),
    );
  }

  //#region Change
  Widget _change(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    _taped();
                  }),
              getProfileNavigationButton(),
            ],
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            backgroundColor: Colors.transparent,
          ),
          getName(context),
          getFirstPhone(context),
          getSecondPhone(context),
          save(context)
        ],
      ),
    );
  }

  Container save(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: FlatButton(
        onPressed: () {
          _taped();
        },
        padding: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: new Text(
            "Сохранить",
            style: Theme.of(context).textTheme.body2.copyWith(
                  color: Color.fromRGBO(130, 147, 153, 1),
                ),
          ),
        ),
      ),
    );
  }

  Padding getSecondPhone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: TextFormField(
        onChanged: (secondPhone) {
          setState(() {
            ProfileManipulation.store.secondPhone = secondPhone;
          });
        },
        cursorColor: Colors.white,
        initialValue: ProfileManipulation.store.secondPhone != null
            ? ProfileManipulation.store.secondPhone
            : "",
        style: Theme.of(context).textTheme.body2,
        decoration: InputDecoration(
          labelText: "Дополнительный телефон",
          focusColor: Colors.white,
        ),
      ),
    );
  }

  Padding getFirstPhone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: TextFormField(
        onChanged: (firstPhone) {
          setState(() {
            ProfileManipulation.store.firstPhone = firstPhone;
          });
        },
        cursorColor: Colors.white,
        initialValue: ProfileManipulation.store.firstPhone != null
            ? ProfileManipulation.store.firstPhone
            : "",
        style: Theme.of(context).textTheme.body2,
        decoration: InputDecoration(
          labelText: "Основной телефон",
          focusColor: Colors.white,
        ),
      ),
    );
  }

  Padding getName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: TextFormField(
        onChanged: (name) {
          setState(() {
            ProfileManipulation.store.name = name;
          });
        },
        cursorColor: Colors.white,
        key: Key("name"),
        initialValue: ProfileManipulation.store.name != null
            ? ProfileManipulation.store.name
            : "",
        style: Theme.of(context).textTheme.body2,
        decoration: InputDecoration(
          labelText: "Наименование",
          focusColor: Colors.white,
        ),
      ),
    );
  }

  PopupMenuButton<dynamic> getProfileNavigationButton() {
    return PopupMenuButton(
      color: Color.fromRGBO(110, 53, 76, 1),
      icon: Icon(Icons.more_horiz, color: Colors.white),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              FlatButton(
                onPressed: () async {
                  await toAuthorizationPage();
                },
                padding: EdgeInsets.zero,
                child: new Text(
                  "Выйти",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
            child: Row(
          children: [
            Icon(Icons.delete, color: Colors.white),
            new FlatButton(
                onPressed: () async {
                  await WebApiServices.deleteAccount(
                      ProfileManipulation.account.id);
                  await toAuthorizationPage();
                },
                padding: EdgeInsets.zero,
                child: new Text("Удалить",
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Colors.white)))
          ],
        )),
      ],
    );
  }

  toAuthorizationPage() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.setInt("AccountId", 0);
    prefs.setInt("StoreId", 0);

    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => AuthorizationMainMenu(),
      ),
    );
  }

  void _taped() {
    setState(() {
      _isTab = !_isTab;
    });
  }
  //#endregion
}
