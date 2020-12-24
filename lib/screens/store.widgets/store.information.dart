import 'package:flower_ui/models/store.dart';
import 'package:flutter/material.dart';

class StoreInformation extends StatefulWidget{
  @override
  StoreInformationState createState() => StoreInformationState();
}

class StoreInformationState extends State<StoreInformation>
    with SingleTickerProviderStateMixin{
  Store store = new Store("Букет столицы", "Свежие цветочки", "8(900)800-40-50");
  String name = "";
  String firstPhone = "";
  String secondFhone = "";

  bool _isTab = false;

  void _taped(){
    setState(() {
      _isTab = !_isTab;
    });
  }
  void _save(){
    setState(() {
      store.name = name;
      store.firstPhone = firstPhone;
      //secondFhone!=null? store.secondPhone = secondFhone : "";
    });
  }
  void _changeName(String name){
    setState(() {
      this.name=name;
    });
  }
  void _changeFirstPhone(String firstPhone){
    setState(() {
      this.firstPhone=firstPhone;
    });
  }
  void _changeSecondPhone(String secondPhone){
    setState(() {
      this.secondFhone=secondPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: Color.fromRGBO(130, 147, 153, 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
            )
        ),
        child: _isTab? _change(context) : _read(context),
        height: _isTab? 480 : 200,
        duration: Duration(seconds: 1),
      ),
    );
  }
  Widget _read (BuildContext context){
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
              name!=null?Text(store.name,
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Montserrat",
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none)): Text(""),
              firstPhone!=null?Text(store.firstPhone,
                  style: new TextStyle(
                      height: 2,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Montserrat",
                      color: Colors.white,
                      decoration: TextDecoration.none)):Text(""),
              secondFhone!=null?Text(
                // _store.secondPhone == null
                //     ? " "
                //     : _store.secondPhone,
                  "8(950)245-78-78",
                  style: new TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Montserrat",
                      color: Colors.white,
                      decoration: TextDecoration.none)) : Text(""),
              new FlatButton(
                  onPressed: () {
                    _taped();
                  },
                  padding: EdgeInsets.zero,
                  child: new Text("Изменить",
                      style: new TextStyle(
                          height: 2,
                          fontSize: 15.0,
                          fontFamily: "MontserratBold",
                          color: Colors.white,
                          decoration: TextDecoration.none))),
            ],
          )
        ],
      ),
    );
  }
  Widget _change (BuildContext context){
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
                  }
              ),
              PopupMenuButton(
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
                              onPressed: null,
                              padding: EdgeInsets.zero,
                              child: new Text("Выйти",
                                  style: new TextStyle(
                                      height: 2,
                                      fontSize: 15.0,
                                      fontFamily: "MontserratBold",
                                      color: Colors.white,
                                      decoration: TextDecoration.none))
                          )
                        ],
                      )),
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.white),
                          new FlatButton(
                              onPressed: null,
                              padding: EdgeInsets.zero,
                              child: new Text("Удалить",
                                  style: new TextStyle(
                                      height: 2,
                                      fontSize: 15.0,
                                      fontFamily: "MontserratBold",
                                      color: Colors.white,
                                      decoration: TextDecoration.none))
                          )
                        ],
                      )),
                ],
              ),
            ],
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            backgroundColor: Colors.transparent,
          ),
          TextFormField(
            onChanged: (name){
              _changeName(name);
            },
            cursorColor: Colors.white,
            key: Key("name"),
            initialValue: store.name != null ? store.name : "",
            style: new TextStyle(
                height: 2,
                fontSize: 15.0,
                fontFamily: "Montserrat",
                color: Colors.white,
                decoration: TextDecoration.none),
            decoration: InputDecoration(
              labelText: "Наименование",
              focusColor: Colors.white,
            )
          ),
          TextFormField(
            onChanged: (firstPhone){
              _changeFirstPhone(firstPhone);
            },
            cursorColor: Colors.white,
            initialValue: store.firstPhone != null ? store.firstPhone : "",
            style: new TextStyle(
                height: 2,
                fontSize: 15.0,
                fontFamily: "Montserrat",
                color: Colors.white,
                decoration: TextDecoration.none),
            decoration: InputDecoration(
              labelText: "Основной телефон",
              focusColor: Colors.white,
            )
          ),
          TextFormField(
            onChanged: (secondPhone){
              _changeSecondPhone(secondPhone);
            },
            cursorColor: Colors.white,
            initialValue: store.secondPhone != null ? store.secondPhone : "",
            style: new TextStyle(
                height: 2,
                fontSize: 15.0,
                fontFamily: "Montserrat",
                color: Colors.white,
                decoration: TextDecoration.none),
            decoration: InputDecoration(
                labelText: "Дополнительный телефон",
                focusColor: Colors.white,
              )
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: FlatButton(
                onPressed: (){
                  _taped();
                  _save();
                },
                padding: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: new Text(
                      "Сохранить",
                      style: new TextStyle(
                          fontSize: 15.0,
                          fontFamily: "MontserratBold",
                          color: Color.fromRGBO(130, 147, 153, 1),
                          decoration: TextDecoration.none)),
                )
            ),
          )
        ],
      ),
    );
  }
}