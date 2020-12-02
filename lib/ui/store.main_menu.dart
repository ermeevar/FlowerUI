import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/store.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  Store _store = new Store("Твой букетик", "Свежие цветочки", "89008004050");
  List<Shop> _shops =[
    new Shop("г. Казань, Мавлекаева 67", 0, null),
    new Shop("г. Казань, Проспект Победы 30", 0, null),
    new Shop("г. Казань, Солнечный город 1, 2 этаж", 0, null)
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new Text("hello"),
    );
  }
}