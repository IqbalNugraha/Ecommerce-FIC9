import 'package:fic9_ecommerce_template_app/common/extensions/string_ext.dart';

import '../../../data/models/response/products_response.dart';

class CartModel {
  final ProductsResponseModelDatum product;
  int quantity;

  CartModel({
    required this.product,
    this.quantity = 0,
  });

  String get priceFormat => product.attributes!.price!.currencyFormatRp;
}