import 'package:http/http.dart' as http;

class WebApiServices{
  static String _storeUrl = "https://127.0.0.1:5001/stores";
  static String _shopUrl = "https://10.0.2.2:5001/shops";
  static String _categoryUrl = "https://10.0.2.2:5001/categories";
  static String _storeProductUrl = "https://10.0.2.2:5001/storeproducts";
  static String _shopProductUrl = "https://10.0.2.2:5001/shopproducts";

  static Future fetchStore() async{
    return await http.get(_storeUrl);
  }
  static Future fetchShop() async{
    return await http.get(_shopUrl);
  }
  static Future fetchCategory() async{
    return await http.get(_categoryUrl);
  }
  static Future fetchStoreProduct() async{
    return await http.get(_storeProductUrl);
  }
  static Future fetchShopProduct() async{
    return await http.get(_shopProductUrl);
  }
}