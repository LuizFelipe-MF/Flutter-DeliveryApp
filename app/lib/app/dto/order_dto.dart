// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/app/dto/order_product_dto.dart';

class OrderDto {
  List<OrderProductDto> products;
  String address;
  String document;
  int paymentMethodId;
  
  OrderDto({
    required this.products,
    required this.address,
    required this.document,
    required this.paymentMethodId,
  });
}
