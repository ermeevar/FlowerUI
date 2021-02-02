import 'dart:convert';

import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/web.api.services.dart';

class ConnectionWebApi{

  List<Shop> getShops(){
    WebApiServices.fetchShop().then((response){
      Iterable list = json.decode(response.body);
      List<Shop> shopsData = List<Shop>();
      shopsData = list
          .map((model)=>Shop.fromObject(model))
          .toList();

      return shopsData;
    });
  }
}