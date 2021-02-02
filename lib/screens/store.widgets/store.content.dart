import 'dart:convert';
import 'package:flower_ui/models/category.dart';
import 'package:flower_ui/models/connection.web.api.dart';
import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/store.dart';
import 'package:flower_ui/models/web.api.services.dart';
import 'package:flower_ui/screens/shop.widgets/shop.main.menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/store.product.dart';

class StoreContent extends StatefulWidget {
  StoreContent({Key key}):super(key:key);

  @override
  StoreContentState createState() => StoreContentState();
}

class StoreContentState extends State<StoreContent>
    with TickerProviderStateMixin {
  String _shopAddress;
  String _productName;
  String _productCost;
  String _productCategory;
  Store _store;
  List<Shop> _shops = List<Shop>();
  List<StoreProduct> _storeProducts = List<StoreProduct>();
  List<Category> _categories = List<Category>();

  StoreContentState(){
    _store= Store();
    _store.id=1;
    getShops();
    getCategories();
    getStoreProducts();
  }


  getShops(){
    WebApiServices.fetchShop().then((response){
      Iterable list = json.decode(response.body);
      List<Shop> shopsData = List<Shop>();
      shopsData = list
          .map((model)=>Shop.fromObject(model))
          .toList();
      //Iterable<Shop> filterList=shopsData.where((element) => element.storeId == _store.id);
      setState(() {
        _shops=shopsData.where((element) => element.storeId == _store.id).toList();
      });
    });
  }
  getStoreProducts(){
    WebApiServices.fetchStoreProduct().then((response){
      Iterable list = json.decode(response.body);
      List<StoreProduct> storeproductsData = List<StoreProduct>();
      storeproductsData = list
          .map((model)=>StoreProduct.fromObject(model))
          .toList();
      setState(() {
        _storeProducts=storeproductsData;
      });
    });
  }
  getCategories(){
    WebApiServices.fetchCategory().then((response){
      Iterable list = json.decode(response.body);
      List<Category> categories = List<Category>();
      categories = list
          .map((model)=>Category.fromObject(model))
          .toList();
      setState(() {
        _categories=categories;
      });
    });
  }

  List<DropdownMenuItem> _buildItems(List<Category> list){
    List<DropdownMenuItem> newList=List();

    for(var item in list){
      newList.add(DropdownMenuItem(child: Text(item.name), value: item.name));
    }

    return newList;
  }
  void _addShop(Shop shop) {
    setState(() {
      _shops.add(shop);
    });
  }
  void _deleteShop(Shop shop) {
    setState(() {
      _shops.remove(shop);
    });
  }
  void _addStoreProduct(StoreProduct product) {
    setState(() {
      _storeProducts.add(product);
    });
  }
  void _deleteStoreProduct(StoreProduct product) {
    setState(() {
      _storeProducts.remove(product);
    });
  }
  void _changeShopAddress(String addressName) {
    setState(() {
      this._shopAddress = addressName;
    });
  }
  void _changeProductName(String productName) {
    setState(() {
      this._productName = productName;
    });
  }
  void _changeProductCost(String productCost) {
    setState(() {
      this._productCost = productCost;
    });
  }
  void _changeProductCategory(String productCategory) {
    setState(() {
      this._productCategory = productCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            primary: false,
            toolbarHeight: 30,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Color.fromRGBO(110, 53, 76, 1),
              tabs: [
                Text(
                  "Магазины",
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Text(
                  "Ассортимент",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _shopsContent(context),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _productsContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _shopsContent(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(130, 147, 153, 1),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => _shopBottomSheet(context),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Colors.white,
        child: Expanded(
          child: _shops.length==0?Center(child: Container(color:Colors.white, child: Text("У вас нет ни одного магазина", style: Theme.of(context).textTheme.body1))):ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Color.fromRGBO(110, 53, 76, 1),
                thickness: 1.5,
                height: 0,
              ),
              itemCount: _shops.length+1,
              itemBuilder: (context, index) {
                return index+1==_shops.length+1?Container(height: 90,color: Colors.white):ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  title: Text(
                      _shops[index].address,
                      style: Theme.of(context).textTheme.body1
                  ),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Color.fromRGBO(110, 53, 76, 1)),
                    color: Color.fromRGBO(110, 53, 76, 1),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              ),
                              FlatButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ShopMainMenu(_shops[index])),
                                    );
                                  },
                                  child: Text(
                                      "Войти",
                                      style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white)
                                  ))
                            ],
                          )),
                      PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              FlatButton(
                                  onPressed: null,
                                  child: Text(
                                      "Изменить",
                                      style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white)
                                  ))
                            ],
                          )),
                      PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              FlatButton(
                                  onPressed: (){
                                    _deleteShop(_shops[index]);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                      "Удалить",
                                      style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white)
                                  ))
                            ],
                          )),
                    ],
                  ),
                );
              }),
        )
      ),
    );
  }
  Widget _productsContent(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: _storeProducts.length==0?Center(child: Container(color:Colors.white, child: Text("У вас нет ни одного товара", style: Theme.of(context).textTheme.body1))):ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Color.fromRGBO(110, 53, 76, 1),
              thickness: 1.5,
              height: 0,
            ),
            itemCount: _storeProducts.length+1,
            itemBuilder: (context, index) {
              return index+1==_storeProducts.length+1?Container(height: 90,color: Colors.white):Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/8a/eb/d8/8aebd875fbddd22bf3971c3a7159bdc7.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: Padding(
                      padding: EdgeInsets.only(left: 20),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _storeProducts[index].name,
                            style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _storeProducts[index].cost.toString() + " руб.",
                            style: Theme.of(context).textTheme.body1.copyWith(height: 2),
                          ),
                        ],
                      ),
                    )),
                    PopupMenuButton(
                      icon: Icon(Icons.more_vert, color: Color.fromRGBO(110, 53, 76, 1)),
                      color: Color.fromRGBO(110, 53, 76, 1),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            FlatButton(
                                onPressed: null,
                                child: Text(
                                  "Изменить",
                                  style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white)
                                ))
                          ],
                        )),
                        PopupMenuItem(
                          child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            FlatButton(
                              onPressed: (){
                              _deleteStoreProduct(_storeProducts[index]);
                              Navigator.pop(context);
                              },
                              child: Text(
                                "Удалить",
                                  style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white)
                              ))
                          ],
                        )),
                      ],
                    )
                  ],
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(130, 147, 153, 1),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => _productBottomSheet(context),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Widget _shopBottomSheet(context) {
    return Container(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                    cursorColor: Colors.white,
                    onChanged: (string) {
                      _changeShopAddress(string);
                    },
                    style: Theme.of(context).textTheme.body2,
                    decoration: InputDecoration(
                      labelText: "Адрес магазина",
                    )),
              ),
              new Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 30),
                  child: FlatButton(
                      onPressed: () {
                        // Shop shop = Shop({address=this._shopAddress, storeId=0});
                        // _addShop(shop);
                        // Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: new Text("Сохранить",
                            style: Theme.of(context).textTheme.body2.copyWith(color: Color.fromRGBO(130, 147, 153, 1))),
                      )))
            ],
          ),
        ),
      ),
    );
  }
  Widget _productBottomSheet(context) {
    return Container(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 15),
                child: TextFormField(
                    cursorColor: Colors.white,
                    onChanged: (string) {
                      _changeProductName(string);
                    },
                    style: Theme.of(context).textTheme.body2.copyWith(height:2),
                    decoration: InputDecoration(
                      labelText: "Наименование",
                    )),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15),
                child: TextFormField(
                    cursorColor: Colors.white,
                    onChanged: (string) {
                      _changeProductCost(string);
                    },
                    style: Theme.of(context).textTheme.body2.copyWith(height:2),
                    decoration: InputDecoration(
                      labelText: "Стоимость",
                      focusColor: Colors.white,
                    ))
              ),
              DropdownButton(
                dropdownColor: Color.fromRGBO(110, 53, 76, 1),
                value: _productCategory,
                itemHeight: 80,
                underline: Container(
                    height: 1,
                    color: Color.fromRGBO(55, 50, 52, 1)
                ),
                isExpanded: true,
                icon: Icon(Icons.arrow_downward, color: Color.fromRGBO(55, 50, 52, 1)),
                items: _buildItems(_categories),
                style: Theme.of(context).textTheme.body2,
                onChanged: (productCategory){
                  setState(() {
                    _changeProductCategory(productCategory);
                  });
                }
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 30),
                  child: FlatButton(
                      onPressed: () {
                        // StoreProduct product = StoreProduct(_productName, double.parse(_productCost));
                        // _addStoreProduct(product);
                        // Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: new Text("Сохранить",
                            style: Theme.of(context).textTheme.body2.copyWith(color: Color.fromRGBO(130, 147, 153, 1))),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
