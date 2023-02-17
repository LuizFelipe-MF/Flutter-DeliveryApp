import 'package:app/app/models/product_model.dart';

class OrderProductDto {
  final ProductModel product;
  int amount;

  OrderProductDto({
    required this.product,
    required this.amount,
  });

  double get totalPrice => amount * product.price;
}
