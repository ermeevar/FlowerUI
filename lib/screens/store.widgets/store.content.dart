import 'dart:convert';
import 'package:flower_ui/models/category.dart';
import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/store.dart';
import 'package:flower_ui/models/web.api.services.dart';
import 'package:flower_ui/screens/shop.widgets/shop.main.menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/store.product.dart';

class StoreContent extends StatefulWidget {
  Store _store;

  StoreContent(Store store){
    _store=store;
  }

  @override
  StoreContentState createState() => StoreContentState(_store);
}

class StoreContentState extends State<StoreContent>
    with TickerProviderStateMixin {

  Store _store;

  //shop data
  List<Shop> _shops = List<Shop>();
  Shop _shoosenShop = Shop();
  String _shopAddress;

  //store-product data
  List<StoreProduct> _storeProducts = List<StoreProduct>();
  StoreProduct _choosenStoreProduct = StoreProduct();
  List<int> _picture;
  String _productName;
  String _productCost;
  String _productCategory;

  List<Category> _categories = List<Category>();

  StoreContentState(Store store){
    _store=store;
    _getShops();
    _getCategories();
    _getStoreProducts();
  }

  List<DropdownMenuItem> _buildItems(List<Category> list){
    List<DropdownMenuItem> newList=List();

    for(var item in list){
      newList.add(DropdownMenuItem(child: Text(item.name), value: item.name));
    }

    return newList;
  }

  _getShops(){
    WebApiServices.fetchShop().then((response){
      Iterable list = json.decode(response.body);
      List<Shop> shopsData = List<Shop>();
      shopsData = list
          .map((model)=>Shop.fromObject(model))
          .toList();
      setState(() {
        _shops=shopsData.where((element) => element.storeId == _store.id).toList();
      });
    });
  }
  _getStoreProducts(){
    WebApiServices.fetchStoreProduct().then((response){
      Iterable list = json.decode(response.body);
      List<StoreProduct> storeproductsData = List<StoreProduct>();
      storeproductsData = list
          .map((model)=>StoreProduct.fromObject(model))
          .toList();
      setState(() {
        _storeProducts=storeproductsData.where((element) => element.storeId==_store.id).toList();
      });
    });
  }
  _getCategories(){
    WebApiServices.fetchCategory().then((response){
      Iterable list = json.decode(response.body);
      List<Category> categoriesData = List<Category>();
      categoriesData = list
          .map((model)=>Category.fromObject(model))
          .toList();
      setState(() {
        _categories=categoriesData;
      });
    });
  }

  _addShop(Shop shop) async{
   if(await WebApiServices.postShop(shop)==202){
     _getShops();
   }
  }
  _deleteShop(int id) async{
    if(await WebApiServices.deleteShop(id)==204){
      _getShops();
    }
  }
  _updateShop(Shop shop) async{
    if(await WebApiServices.putShop(shop)==204){
      _getShops();
    }

    _shoosenShop=new Shop();
  }

  _addStoreProduct(StoreProduct storeProduct) async{
    if(await WebApiServices.postStoreProduct(storeProduct)==202){
      _getStoreProducts();
    }
  }
  _deleteStoreProduct(int id) async{
    if(await WebApiServices.deleteStoreProduct(id)==200){
      _getStoreProducts();
    }
  }
  _changeProductName(String productName) {

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
                                  onPressed: () async{
                                    _shoosenShop=_shops[index];
                                    await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) => _shopBottomSheet(context),
                                    );

                                    Navigator.pop(context);
                              },
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
                                    _deleteShop(_shops[index].id);
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
                    _storeProducts[index].picture==null?
                      Icon(Icons.image_not_supported, color: Color.fromRGBO(130, 147, 153, 1), size: 50,)
                      :CircleAvatar(
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
                                onPressed: (){
                                  _choosenStoreProduct=_storeProducts[index];
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => _productBottomSheet(context),
                                  );

                                  Navigator.pop(context);
                                },
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
                              _deleteStoreProduct(_storeProducts[index].id);
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
                    initialValue: _shoosenShop.id != 0 ? _shoosenShop.address : "",
                    cursorColor: Colors.white,
                    onChanged: (addressName) {
                      setState(() {
                        this._shopAddress = addressName;
                      });
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
                        Shop shop = Shop();
                        shop.storeId=_store.id;
                        shop.address=_shopAddress;

                        if(_shoosenShop.id==null){
                          shop.id=0;
                          _addShop(shop);
                        }
                        else{
                          shop.id=_shoosenShop.id;
                          _updateShop(shop);
                        }

                        Navigator.pop(context);
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
                    onChanged: (productName) {
                      setState(() {
                        this._productName = productName;
                      });
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
                    onChanged: (productCost) {
                      setState(() {
                        this._productCost = productCost;
                      });
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
                    this._productCategory = productCategory;
                  });
                }
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 30),
                  child: FlatButton(
                      onPressed: () {
                        StoreProduct storeProduct = StoreProduct();
                        storeProduct.storeId=_store.id;
                        storeProduct.picture=_picture;
                        storeProduct.name=_productName;
                        storeProduct.cost=double.parse(_productCost);
                        storeProduct.categoryId=_categories.firstWhere((element) => element.name==_productCategory).id;

                        if(_choosenStoreProduct.id==null){
                          storeProduct.id=0;
                          _addStoreProduct(storeProduct);
                        }
                        else{
                          // storeProduct.id=_choosenStoreProduct.id;
                          // _updateShop(storeProduct);
                        }

                        Navigator.pop(context);
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
