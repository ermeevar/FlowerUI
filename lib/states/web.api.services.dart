import 'dart:convert';
import 'dart:io';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:flower_ui/entities/bouquet.dart';
import 'package:flower_ui/entities/bouquet.product.dart';
import 'package:flower_ui/entities/product.dart';
import 'package:flower_ui/entities/shop.dart';
import 'package:flower_ui/entities/store.dart';
import 'package:flower_ui/entities/user.dart';
import '../entities/account.dart';
import '../entities/order.dart';

class WebApiServices {
  static Dio dio = Dio();

  //#region Server
  static String _androidEmulatorLoopback = "10.0.2.2";
  static String _localhost = "localhost";
  static String _port = "5001";
  static String _baseUrl = "https://$_androidEmulatorLoopback:$_port";
  //#endregion

  //#region URL's
  static String _storeUrl = _baseUrl + "/stores/";
  static String _shopUrl = _baseUrl + "/shops/";
  static String _productUrl = _baseUrl + "/products/";
  static String _orderUrl = _baseUrl + "/orders/";
  static String _bouquetUrl = _baseUrl + "/bouquets/";
  static String _bouquetProductUrl = _baseUrl + "/bouquetproducts/";
  static String _orderStatusUrl = _baseUrl + "/orderstatuses/";
  static String _accountUrl = _baseUrl + "/accounts/";
  static String _templateUrl = _baseUrl + "/templates/";
  static String _templateCategoryUrl = _baseUrl + "/templatecategories/";
  static String _productCategoryUrl = _baseUrl + "/productcategories/";
  static String _userUrl = _baseUrl + "/users/";
  //#endregion

  WebApiServices() {
    dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: "https://10.0.2.2")).interceptor);
  }

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  //#region GET response strings
  static Future fetchShops() async {
    return await Dio().get<String>(
      _shopUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future fetchStores() async {
    return await Dio().get<String>(
      _storeUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future fetchProductCategories() async {
    return await Dio().get<String>(
      _productCategoryUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future fetchAccounts() async {
    return await Dio().get<String>(
      _accountUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future fetchOrders() async {
    return await Dio().get<String>(
      _orderUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchBouquets() async {
    return await Dio().get<String>(
      _bouquetUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchOrderStatuses() async {
    return await Dio().get<String>(
      _orderStatusUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchProducts() async {
    return await Dio().get<String>(
      _productUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchBouquetProducts() async {
    return await Dio().get<String>(
      _bouquetProductUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchTemplates() async {
    return await Dio().get<String>(
      _templateUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchTemplateCategories() async {
    return await Dio().get<String>(
      _templateCategoryUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchUsers() async {
    return await Dio().get<String>(
      _userUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }
  //#endregion

  //#region POST
  static Future postShop(Shop shop) async {
    var reverseShop = shop.toJson();
    var shopJson = json.encode(reverseShop);
    var response = await dio.post(_shopUrl,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: shopJson);
    return response.statusCode;
  }

  static Future postStore(Store store) async {
    var reverseStore = store.toJson();
    var storeJson = json.encode(reverseStore);
    var response = await dio.post(_storeUrl,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: storeJson);
    return response.statusCode;
  }

  static Future postAccount(Account account) async {
    var reverseAccount = account.toJson();
    var accountJson = json.encode(reverseAccount);
    var response = await dio.post(_accountUrl,
        options: Options(headers: header), data: accountJson);
    return response.statusCode;
  }

  static Future postOrder(Order order) async {
    var reverseOrder = order.toJson();
    var orderJson = json.encode(reverseOrder);
    var response = await dio.post(_orderUrl,
        options: Options(headers: header), data: orderJson);
    return response.statusCode;
  }

  static Future postBouquet(Bouquet bouquet) async {
    var reverseBouquet = bouquet.toJson();
    var bouquetJson = json.encode(reverseBouquet);
    var response = await dio.post(_bouquetUrl,
        options: Options(headers: header), data: bouquetJson);
    return response.statusCode;
  }

  static Future postProduct(Product product) async {
    var reverseProduct = product.toJson();
    var productJson = json.encode(reverseProduct);
    var response = await dio.post(_productUrl,
        options: Options(headers: header), data: productJson);
    return response.statusCode;
  }

  static Future postBouquetProduct(BouquetProduct bouquetProduct) async {
    var reverseBouquetProduct = bouquetProduct.toJson();
    var bouquetProductJson = json.encode(reverseBouquetProduct);
    var response = await dio.post(_bouquetProductUrl,
        options: Options(headers: header), data: bouquetProductJson);
    return response.statusCode;
  }

  static Future postUser(User user) async {
    var reverseUser = user.toJson();
    var userJson = json.encode(reverseUser);
    var response = await dio.post(_userUrl,
        options: Options(headers: header), data: userJson);
    return response.statusCode;
  }
  //#endregion

  //#region PUT
  static Future putShop(Shop shop) async {
    var reverseShop = shop.toJsonUpdate();
    var shopJson = json.encode(reverseShop);
    var response = await dio.put(_shopUrl + shop.id.toString(),
        queryParameters: header, data: shopJson);
    return response.statusCode;
  }

  static Future putStore(Store store) async {
    var reverseStore = store.toJsonUpdate();
    var storeJson = json.encode(reverseStore);
    var response = await dio.put(_storeUrl + store.id.toString(),
        queryParameters: header, data: storeJson);
    return response.statusCode;
  }

  static Future putAccount(Account account) async {
    var reverseAccount = account.toJsonUpdate();
    var accountJson = json.encode(reverseAccount);
    var response = await dio.put(_accountUrl + account.id.toString(),
        queryParameters: header, data: accountJson);
    return response.statusCode;
  }

  static Future putOrder(Order order) async {
    var reverseOrder = order.toJsonUpdate();
    var orderJson = json.encode(reverseOrder);
    var response = await dio.put(_orderUrl + order.id.toString(),
        queryParameters: header, data: orderJson);
    return response.statusCode;
  }

  static Future putBouquet(Bouquet bouquet) async {
    var reverseBouquet = bouquet.toJsonUpdate();
    var bouquetJson = json.encode(reverseBouquet);
    var response = await dio.put(_bouquetUrl + bouquet.id.toString(),
        queryParameters: header, data: bouquetJson);
    return response.statusCode;
  }

  static Future putProduct(Product product) async {
    var reverseProduct = product.toJsonUpdate();
    var productJson = json.encode(reverseProduct);
    var response = await dio.put(_productUrl + product.id.toString(),
        queryParameters: header, data: productJson);
    return response.statusCode;
  }

  static Future putBouquetProduct(BouquetProduct bouquetProduct) async {
    var reverseBouquetProduct = bouquetProduct.toJsonUpdate();
    var bouquetProductJson = json.encode(reverseBouquetProduct);
    var response = await dio.put(_bouquetProductUrl + bouquetProduct.id.toString(),
        queryParameters: header, data: bouquetProductJson);
    return response.statusCode;
  }

  static Future putUser(User user) async {
    var reverseUser = user.toJsonUpdate();
    var userJson = json.encode(reverseUser);
    var response = await dio.put(_userUrl + user.id.toString(),
        queryParameters: header, data: userJson);
    return response.statusCode;
  }
  //#endregion

  //#region DELETE
  static Future deleteShop(int id) async {
    var response = await dio.delete(_shopUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteStore(int id) async {
    var response = await dio.delete(_storeUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteAccount(int id) async {
    var response = await dio.delete(_accountUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteOrder(int id) async {
    var response = await dio.delete(_orderUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteBouquet(int id) async {
    var response = await dio.delete(_bouquetUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteProduct(int id) async {
    var response = await dio.delete(_productUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteBouquetProduct(int id) async {
    var response = await dio.delete(_bouquetProductUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteUser(int id) async {
    var response = await dio.delete(_userUrl + id.toString());
    return response.statusCode;
  }
  //#endregion
}
