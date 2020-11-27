import 'package:http/http.dart' as http;

class WebApiServices{
  static String storeUrl = "url";
  static String shopUrl = "url";
  static String categoryUrl = "url";
  static String storeProductUrl = "url";
  static String shopProductUrl = "url";

  static Future fetchStore() async{
    return await http.get(storeUrl);
  }
  static Future fetchShop() async{
    return await http.get(shopUrl);
  }
  static Future fetchCategory() async{
    return await http.get(categoryUrl);
  }
  static Future fetchStoreProduct() async{
    return await http.get(storeProductUrl);
  }
  static Future fetchShopProduct() async{
    return await http.get(shopProductUrl);
  }
}