import 'package:flower_ui/entities/product.category.dart';
import 'package:flower_ui/screens/store.widgets/store.main.menu.dart';
import 'package:flower_ui/states/divider.dart';
import 'package:flower_ui/states/image.controller.dart';
import 'package:flower_ui/states/profile.manipulation.dart';
import 'package:flower_ui/entities/shop.dart';
import 'package:flower_ui/states/spaceContainer.dart';
import 'package:flower_ui/states/web.api.services.dart';
import 'package:flower_ui/screens/shop.widgets/shop.main.menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../entities/product.dart';

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

  //#region GetData
  StoreContentState() {
    _getShops();
    _getProductCategories();
    _getProducts();
  }

  Future<void> _refresh() async {
    setState(() {
      _getShops();
      _getProductCategories();
      _getProducts();
    });
  }

  _getShops() async {
    _shops = [];
    await WebApiServices.fetchShops().then((response) {
      var shopsData = shopFromJson(response.data);
      setState(() {
        _shops = shopsData
            .where((element) => element.storeId == ProfileManipulation.store.id)
            .toList();
      });
    });
  }

  _getProducts() async {
    await WebApiServices.fetchProducts().then((response) {
      var productsData = productFromJson(response.data);
      setState(() {
        _products = productsData
            .where((element) => element.storeId == ProfileManipulation.store.id)
            .toList();
      });
    });
  }

  _getProductCategories() async {
    await WebApiServices.fetchProductCategories().then((response) {
      var productCategoriesData = productCategoryFromJson(response.data);
      setState(() {
        _productCategories = productCategoriesData;
      });
    });
  }
  //#endregion

  //#region BuildTabBar
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            primary: false,
            toolbarHeight: 60,
            bottom: getTabBar(context),
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

  TabBar getTabBar(BuildContext context) {
    return TabBar(
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
    );
  }
  //#endregion

  //#region Shops
  Widget _shopsContent(BuildContext context) {
    return Scaffold(
      floatingActionButton: getAddButton(context),
      body: Container(
        color: Colors.white,
        child:
            _shops.length == 0 ? showNullShopsError(context) : buildShopList(),
      ),
    );
  }

  Widget buildShopList() {
    return RefreshIndicator(
      color: Color.fromRGBO(110, 53, 76, 1),
      key: StoreMainMenuState.refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView.separated(
          separatorBuilder: (context, index) => getDivider(),
          itemCount: _shops.length + 1,
          itemBuilder: (context, index) {
            return index + 1 == _shops.length + 1
                ? getSpaceContainer()
                : ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    title: Text(_shops[index].address,
                        style: Theme.of(context).textTheme.body1),
                    trailing: getShopMenuButton(index),
                  );
          }),
    );
  }

  PopupMenuButton<dynamic> getShopMenuButton(int index) {
    return PopupMenuButton(
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
                        builder: (context) => ShopMainMenu(_shops[index])),
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
                    builder: (context) => _shopBottomSheet(context),
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
                  if (await WebApiServices.deleteShop(_shops[index].id) ==
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
    );
  }

  Center showNullShopsError(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Text("У вас нет ни одного магазина",
            style: Theme.of(context).textTheme.body1),
      ),
    );
  }

  FloatingActionButton getAddButton(BuildContext context) {
    return FloatingActionButton(
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
    );
  }

  Widget _shopBottomSheet(context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: 200,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: [
              getAddress(context),
              getSaveShopButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Container getSaveShopButton(context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 30),
      child: FlatButton(
        onPressed: () async {
          _shop.storeId = ProfileManipulation.store.id;
          _shop.accountId = ProfileManipulation.account.id;
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
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: new Text(
            "Сохранить",
            style: Theme.of(context).textTheme.body2.copyWith(
                  color: Color.fromRGBO(130, 147, 153, 1),
                ),
          ),
        ),
      ),
    );
  }

  Padding getAddress(context) {
    return Padding(
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
    );
  }
  //#endregion

  //#region Products
  ProductCategory _getCategoryById(int index) {
    return _productCategories.firstWhere((element) => element.id == index);
  }

  Widget _productsContent(BuildContext context) {
    return Scaffold(
      floatingActionButton: getSaveProductButton(context),
      body: Container(
        color: Colors.white,
        child: _products.length == 0
            ? showNullProductError(context)
            : buildProductList(),
      ),
    );
  }

  FloatingActionButton getSaveProductButton(BuildContext context) {
    return FloatingActionButton(
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
    );
  }

  Widget buildProductList() {
    return RefreshIndicator(
      color: Color.fromRGBO(110, 53, 76, 1),
      key: StoreMainMenuState.refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView.separated(
        separatorBuilder: (context, index) => getDivider(),
        itemCount: _products.length + 1,
        itemBuilder: (context, index) {
          return index + 1 == _products.length + 1
              ? getSpaceContainer()
              : getProductItem(index, context);
        },
      ),
    );
  }

  Padding getProductItem(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getImage(_products[index]),
          getProductValueInfo(index, context),
          getProductMenuButton(index)
        ],
      ),
    );
  }

  Card _getImage(Product product) {
    return Card(
      elevation: 0,
      shape: CircleBorder(),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 25,
        child: product.picture == null
            ? Icon(
                Icons.image_not_supported,
                color: Colors.black38,
                size: 25,
              )
            : ClipOval(
                child: Image(
                  image: MemoryImage(product.picture),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  PopupMenuButton<dynamic> getProductMenuButton(int index) {
    return PopupMenuButton(
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
                onPressed: () async {
                  _product = _products[index];
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => _productBottomSheet(context),
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
                  if (await WebApiServices.deleteProduct(_products[index].id) ==
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
    );
  }

  Expanded getProductValueInfo(int index, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _products[index].name +
                  " | " +
                  _getCategoryById(_products[index].productCategoryId).name,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              _products[index].cost.toString() + " руб.",
              style: Theme.of(context).textTheme.body1.copyWith(height: 2),
            ),
          ],
        ),
      ),
    );
  }

  Center showNullProductError(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Text(
          "У вас нет ни одного товара",
          style: Theme.of(context).textTheme.body1,
        ),
      ),
    );
  }

  Future showOptionsForPhoto(context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Выбрать из галереи',
              style: Theme.of(context).textTheme.body1,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              var pickedImage = await ImageController.getImageFromGallery();
              if (pickedImage != null) {
                setState(() {
                  _product.picture = pickedImage;
                });
              }
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Камера',
              style: Theme.of(context).textTheme.body1,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              var pickedImage = await ImageController.getImageFromCamera();
              if (pickedImage != null) {
                setState(() {
                  _product.picture = pickedImage;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  GestureDetector getProfileImage(context) {
    return GestureDetector(
      onTap: () async {
        await showOptionsForPhoto(context);
      },
      child: _getImage(_product),
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
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: getProfileImage(context),
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
                      _product.storeId = ProfileManipulation.store.id;

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
  //#endregion
}
