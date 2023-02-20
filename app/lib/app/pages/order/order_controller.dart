import 'package:app/app/dto/order_product_dto.dart';
import 'package:app/app/pages/order/order_state.dart';
import 'package:app/app/repositories/order/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderController(this._orderRepository) : super(const OrderState.initial());

  void load(List<OrderProductDto> products) async {
    try {
      emit(
        state.copyWith(
          status: OrderStatus.loading,
        ),
      );
      final paymentTypes = await _orderRepository.getAllPaymentTypes();
      emit(
        state.copyWith(
          status: OrderStatus.loaded,
          orderProducts: products,
          paymentTypes: paymentTypes,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
            status: OrderStatus.error,
            errorMessage: 'Erro ao carregar página.'),
      );
    }
  }
}
