import 'package:flower_ui/entities/bouquet.product.dart';
import 'package:flower_ui/entities/order.dart';
import 'package:flower_ui/entities/product.category.dart';
import 'package:flower_ui/entities/product.dart';
import 'package:flower_ui/entities/template.dart';
import 'package:flower_ui/states/linq.extend.dart';
import 'package:flower_ui/states/calc.dart';
import 'package:flower_ui/states/nullContainer.dart';
import 'package:flower_ui/states/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderBouquetContent extends StatefulWidget {
  Order _order;

  OrderBouquetContent(this._order);

  OrderBouquetContentState createState() => OrderBouquetContentState(_order);
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

  //#region GetData
  _getProducts() async {
    List<BouquetProduct> middleProducts;
    await WebApiServices.fetchBouquetProducts().then((response) {
      var bouquetProductsData = bouquetProductFromJson(response.data);
      middleProducts = bouquetProductsData
          .where((element) => element.bouquetId == _order.bouquetId)
          .toList();
    });

    await WebApiServices.fetchProducts().then((response) {
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
    await WebApiServices.fetchProductCategories().then((response) {
      var productCategoriesData = productCategoryFromJson(response.data);
      setState(() {
        _productCategories = productCategoriesData;
      });
    });
  }

  _getTemplateCategories() async {
    await WebApiServices.fetchTemplates().then((response) {
      var templatesData = templateFromJson(response.data);
      setState(() {
        _templates = templatesData;
      });
    });
  }
  //#endregion

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getListTitle(context),
          _order.bouquetId != null
              ? Expanded(child: _bouquetList(context))
              : nullContainer(),
          _order.isRandom == true ? getRandomTitle(context) : nullContainer(),
          _order.templateId != null && _templates.length != 0
              ? getTemplateTitle(context)
              : nullContainer(),
        ],
      ),
    );
  }

  //#region Titles
  Template _getTemplateById(int index) {
    return _templates.firstWhere((element) => element.id == index);
  }

  Text getTemplateTitle(BuildContext context) {
    return Text(
      "Шаблон: " + _getTemplateById(_order.templateId).name,
      style: Theme.of(context).textTheme.body1,
    );
  }

  Text getRandomTitle(BuildContext context) {
    return Text(
      "Случайный букет",
      style: Theme.of(context).textTheme.body1,
    );
  }

  Text getListTitle(BuildContext context) {
    return Text(
      "Состав букета",
      style: Theme.of(context)
          .textTheme
          .body1
          .copyWith(color: Colors.black54, fontSize: 15),
    );
  }
  //endregion

  Widget _bouquetList(context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          decoration: getRoundedBorder(),
          child: getProductValue(context, index),
        );
      },
    );
  }

  //#region ProductValue
  ProductCategory _getCategoryById(int index) {
    return _productCategories.firstWhere((element) => element.id == index);
  }

  Row getProductValue(BuildContext context, int index) {
    return Row(
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
              getProductName(context, index),
              getProductCategory(context, index),
              getCost(context, index),
            ],
          ),
        ),
      ],
    );
  }

  Container getCost(BuildContext context, int index) {
    return Container(
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
            Calc.roundDouble(_products[index].cost, 2).toString() + " ₽",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.body1,
          )
        ],
      ),
    );
  }

  Container getProductCategory(BuildContext context, int index) {
    return Container(
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
            _getCategoryById(_products[index].productCategoryId).name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.body1,
          )
        ],
      ),
    );
  }

  Container getProductName(BuildContext context, int index) {
    return Container(
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
    );
  }

  BoxDecoration getRoundedBorder() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Color.fromRGBO(110, 53, 76, 1),
      ),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    );
  }
  //#endregion
}
