import 'package:flower_ui/models/product.category.dart';
import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/web.api.services.dart';
import 'package:flower_ui/screens/shop.widgets/shop.main.menu.dart';
import 'package:flower_ui/screens/store.widgets/store.main.menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';

class StoreContent extends StatefulWidget {
  @override
  StoreContentState createState() => StoreContentState();
}

class StoreContentState extends State<StoreContent>
    with TickerProviderStateMixin {
  Shop _shop = Shop();
  Product _product = Product();
  List<ProductCategory> _productCategories = [];
  List<Shop> _shops = [];
  List<Product> _products = [];

  StoreContentState() {
    _getShops();
    _getProductCategories();
    _getProducts();
  }

  _getShops() async {
    _shops = [];
    await WebApiServices.fetchShop().then((response) {
      var shopsData = shopFromJson(response.data);
      setState(() {
        _shops = shopsData
            .where((element) => element.storeId == StoreMainMenu.store.id)
            .toList();
      });
    });
  }

  _getProducts() async {
    await WebApiServices.fetchProduct().then((response) {
      var productsData = productFromJson(response.data);
      setState(() {
        _products = productsData
            .where((element) => element.storeId == StoreMainMenu.store.id)
            .toList();
      });
    });
  }

  _getProductCategories() async {
    await WebApiServices.fetchProductCategory().then((response) {
      var productCategoriesData = productCategoryFromJson(response.data);
      setState(() {
        _productCategories = productCategoriesData;
      });
    });
  }

  ProductCategory _getCategoryById(int index) {
    return _productCategories.firstWhere((element) => element.id == index);
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
            toolbarHeight: 40,
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
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => _shopBottomSheet(context),
          );

          setState(() {
            _shop = Shop();
            _getShops();
          });
        },
        child: Icon(Icons.add),
      ),
      body: Container(
          color: Colors.white,
          child: Expanded(
            child: _shops.length == 0
                ? Center(
                    child: Container(
                        color: Colors.white,
                        child: Text("У вас нет ни одного магазина",
                            style: Theme.of(context).textTheme.body1)))
                : ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Color.fromRGBO(110, 53, 76, 1),
                          thickness: 1.5,
                          height: 0,
                        ),
                    itemCount: _shops.length + 1,
                    itemBuilder: (context, index) {
                      return index + 1 == _shops.length + 1
                          ? Container(height: 90, color: Colors.white)
                          : ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                              title: Text(_shops[index].address,
                                  style: Theme.of(context).textTheme.body1),
                              trailing: PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Color.fromRGBO(110, 53, 76, 1),
                                ),
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
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShopMainMenu(
                                                          _shops[index])),
                                            );
                                          },
                                          child: Text(
                                            "Войти",
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
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        FlatButton(
                                          onPressed: () async {
                                            _shop = _shops[index];
                                            await showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) =>
                                                  _shopBottomSheet(context),
                                            );

                                            await setState(() {
                                              _shop = Shop();
                                              _getShops();
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Изменить",
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
                                        FlatButton(
                                          onPressed: () async {
                                            if (await WebApiServices.deleteShop(
                                                    _shops[index].id) ==
                                                204) {
                                              _getShops();
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Удалить",
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                    }),
          )),
    );
  }

  Widget _productsContent(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: _products.length == 0
            ? Center(
                child: Container(
                  color: Colors.white,
                  child: Text(
                    "У вас нет ни одного товара",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Color.fromRGBO(110, 53, 76, 1),
                  thickness: 1.5,
                  height: 0,
                ),
                itemCount: _products.length + 1,
                itemBuilder: (context, index) {
                  return index + 1 == _products.length + 1
                      ? Container(height: 90, color: Colors.white)
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _products[index].picture == null
                                  ? Icon(
                                      Icons.image_not_supported,
                                      color: Color.fromRGBO(130, 147, 153, 1),
                                      size: 50,
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          'https://i.pinimg.com/originals/8a/eb/d8/8aebd875fbddd22bf3971c3a7159bdc7.png'),
                                      backgroundColor: Colors.transparent,
                                    ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _products[index].name +
                                            " | " +
                                            _getCategoryById(_products[index]
                                                    .productCategoryId)
                                                .name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .body1
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _products[index].cost.toString() +
                                            " руб.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .body1
                                            .copyWith(height: 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                icon: Icon(Icons.more_vert,
                                    color: Color.fromRGBO(110, 53, 76, 1)),
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
                                          onPressed: () async {
                                            _product = _products[index];
                                            await showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) =>
                                                  _productBottomSheet(context),
                                            );

                                            await setState(() {
                                              _product = Product();
                                              _getProducts();
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Изменить",
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
                                        FlatButton(
                                          onPressed: () async {
                                            if (await WebApiServices
                                                    .deleteProduct(
                                                        _products[index].id) ==
                                                200) {
                                              _getProducts();
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Удалить",
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(130, 147, 153, 1),
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => _productBottomSheet(context),
          );

          setState(() {
            _product = Product();
            _getProducts();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _shopBottomSheet(context) {
    return Container(
      height: 200,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  initialValue: _shop.id != null ? _shop.address : "",
                  cursorColor: Colors.white,
                  onChanged: (addressName) {
                    setState(() {
                      this._shop.address = addressName;
                    });
                  },
                  style: Theme.of(context).textTheme.body2,
                  decoration: InputDecoration(
                    labelText: "Адрес магазина",
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 30),
                child: FlatButton(
                  onPressed: () async {
                    _shop.storeId = StoreMainMenu.store.id;
                    _shop.accountId = StoreMainMenu.account.id;
                    if (_shop.id == null) {
                      await WebApiServices.postShop(_shop);
                    } else
                      await WebApiServices.putShop(_shop);

                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: new Text("Сохранить",
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(color: Color.fromRGBO(130, 147, 153, 1))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productBottomSheet(context) {
    return Container(
      height: 420,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Wrap(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Wrap(
                      children: List.generate(
                        _productCategories.length,
                        (index) => Container(
                          padding: EdgeInsets.all(5),
                          child: ChoiceChip(
                            label: Text(
                              _productCategories[index].name,
                              style: Theme.of(context).textTheme.body1,
                            ),
                            selectedColor: Colors.white,
                            disabledColor: Colors.white10,
                            selected: _product.productCategoryId ==
                                _productCategories[index].id,
                            onSelected: (isSelect) {
                              setState(() {
                                isSelect
                                    ? _product.productCategoryId =
                                        _productCategories[index].id
                                    : _product.productCategoryId = null;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    initialValue: _product.id != null ? _product.name : "",
                    cursorColor: Colors.white,
                    onChanged: (productName) {
                      setState(() {
                        this._product.name = productName;
                      });
                    },
                    style:
                        Theme.of(context).textTheme.body2.copyWith(height: 2),
                    decoration: InputDecoration(
                      labelText: "Наименование",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextFormField(
                    initialValue:
                        _product.id != null ? _product.cost.toString() : "",
                    cursorColor: Colors.white,
                    onChanged: (productCost) {
                      setState(() {
                        this._product.cost = double.parse(productCost);
                      });
                    },
                    style:
                        Theme.of(context).textTheme.body2.copyWith(height: 2),
                    decoration: InputDecoration(
                      labelText: "Стоимость",
                      focusColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 30),
                  child: FlatButton(
                    onPressed: () async {
                      _product.storeId = StoreMainMenu.store.id;

                      if (_product.id == null)
                        await WebApiServices.postProduct(_product);
                      else
                        await WebApiServices.putProduct(_product);

                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: new Text("Сохранить",
                          style: Theme.of(context).textTheme.body2.copyWith(
                              color: Color.fromRGBO(130, 147, 153, 1))),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
