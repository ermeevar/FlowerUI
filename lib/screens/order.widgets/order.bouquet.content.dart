import 'dart:math';

import 'package:flower_ui/models/bouquet.product.dart';
import 'package:flower_ui/models/order.dart';
import 'package:flower_ui/models/product.category.dart';
import 'package:flower_ui/models/product.dart';
import 'package:flower_ui/models/template.category.dart';
import 'package:flower_ui/models/template.dart';
import 'package:flower_ui/models/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderBouquetContent extends StatefulWidget {
  Order _order;

  OrderBouquetContent(this._order);

  OrderBouquetContentState createState() => OrderBouquetContentState(_order);
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

class OrderBouquetContentState extends State<OrderBouquetContent> {
  Order _order;
  List<Product> _products = [];
  List<Template> _templates = [];
  List<ProductCategory> _productCategories = [];
  Map<int, List<Product>> _groupedProducts;

  OrderBouquetContentState(this._order) {
    _getProducts();
    _getProductCategories();
    _getTemplateCategories();
  }

  _getProducts() async {
    List<BouquetProduct> middleProducts;
    await WebApiServices.fetchBouquetProduct().then((response) {
      var bouquetProductsData = bouquetProductFromJson(response.data);
      middleProducts = bouquetProductsData
          .where((element) => element.bouquetId == _order.bouquetId)
          .toList();
    });

    await WebApiServices.fetchProduct().then((response) {
      var productsData = productFromJson(response.data);
      setState(() {
        for (var middle in middleProducts) {
          for (var item in productsData) {
            if (item.id == middle.productId) {
              _products.add(item);
            }
          }
        }
        _groupedProducts = _products.groupBy((m) => m.id);
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

  _getTemplateCategories() async {
    await WebApiServices.fetchTemplate().then((response) {
      var templatesData = templateFromJson(response.data);
      setState(() {
        _templates = templatesData;
      });
    });
  }

  ProductCategory _getCategoryById(int index) {
    return _productCategories.firstWhere((element) => element.id == index);
  }

  Template _getTemplateById(int index) {
    return _templates.firstWhere((element) => element.id == index);
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Состав букета",
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Colors.black54, fontSize: 15),
          ),
          _order.bouquetId != null
              ? Expanded(child: _bouquetList(context))
              : Container(
                  height: 0,
                  width: 0,
                ),
          _order.isRandom == true
              ? Text(
                  "Случайный букет",
                  style: Theme.of(context)
                      .textTheme
                      .body1,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          _order.templateId != null && _templates.length!=0
              ? Text(
                  "Шаблон: " + _getTemplateById(_order.templateId).name,
                  style: Theme.of(context)
                      .textTheme
                      .body1,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
    );
  }

  Widget _bouquetList(context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.only(top: 10),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color.fromRGBO(110, 53, 76, 1),
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Color.fromRGBO(110, 53, 76, 1),
                  ),
                ),
              ),
              Container(
                //padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Наименование",
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.black54, fontSize: 15),
                          ),
                          Text(
                            _products[index].name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.body1,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Категория",
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.black54, fontSize: 15),
                          ),
                          Text(
                            _getCategoryById(_products[index].productCategoryId)
                                .name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.body1,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Стоимость",
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.black54, fontSize: 15),
                          ),
                          Text(
                            roundDouble(_products[index].cost, 2).toString() +
                                " ₽",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.body1,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
