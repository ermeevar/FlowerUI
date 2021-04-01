import 'dart:convert';
import 'dart:io';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:flower_ui/models/product.dart';
import 'package:flower_ui/models/shop.dart';

class WebApiServices {
  static Dio dio = Dio();

  static String _androidEmulatorLoopback = "10.0.2.2";
  static String _localhost = "localhost";
  static String _port = "5001";
  static String _baseUrl = "https://$_androidEmulatorLoopback:$_port";

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

  WebApiServices() {
    dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: "https://10.0.2.2")).interceptor);
  }

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future fetchShop() async {
    return await Dio().get<String>(
      _shopUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future fetchStore() async {
    return await Dio().get<String>(
      _storeUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future fetchProductCategory() async {
    return await Dio().get<String>(
      _productCategoryUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future fetchAccount() async {
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

  static Future fetchBouquet() async {
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

  static Future fetchProduct() async {
    return await Dio().get<String>(
      _productUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchBouquetProduct() async {
    return await Dio().get<String>(
      _bouquetProductUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchTemplate() async {
    return await Dio().get<String>(
      _templateUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchTemplateCategory() async {
    return await Dio().get<String>(
      _templateCategoryUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future postShop(Shop shop) async {
    var reverseShop = shop.toJson();
    var shopJson = json.encode(reverseShop);
    var response = await dio.post(_shopUrl,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: shopJson);
    return response.statusCode;
  }

  static Future postProduct(Product product) async {
    var reverseProduct = product.toJson();
    var productJson = json.encode(reverseProduct);
    var response = await dio.post(_productUrl,
        options: Options(headers: header), data: productJson);
    return response.statusCode;
  }

  static Future deleteShop(int id) async {
    var response = await dio.delete(_shopUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteProduct(int id) async {
    var response = await dio.delete(_productUrl + id.toString());
    return response.statusCode;
  }

  static Future putShop(Shop shop) async {
    var reverseShop = shop.toJsonPut();
    var shopJson = json.encode(reverseShop);
    var response = await dio.put(_shopUrl + shop.id.toString(),
        queryParameters: header, data: shopJson);
    return response.statusCode;
  }

  static Future putProduct(Product product) async {
    var productShop = product.toJsonPut();
    var productJson = json.encode(productShop);
    var response = await dio.put(_productUrl + product.id.toString(),
        queryParameters: header, data: productJson);
    return response.statusCode;
  }
}
