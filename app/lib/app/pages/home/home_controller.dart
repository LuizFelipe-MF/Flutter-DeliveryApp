import 'package:app/app/dto/order_product_dto.dart';
import 'package:app/app/models/product_model.dart';
import 'package:app/app/pages/home/home_state.dart';
import 'package:app/app/repositories/products/products_repository.dart';
import 'package:bloc/bloc.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepository _productsRepository;

  HomeController(
    this._productsRepository,
  ) : super(const HomeState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStateStatus.loading));

    try {
      final products = await _productsRepository.findAllProducts();
      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: 'Erro ao buscar produtos!',
        ),
      );
    }
  }

  void addOrUpdateBag(OrderProductDto orderProduct) {
    final shoppingBag = [...state.shoppingBag];
    final orderIndex =
        shoppingBag.indexWhere((e) => e.product == orderProduct.product);

    if (orderIndex > -1) {
      shoppingBag[orderIndex].amount += orderProduct.amount;
    } else {
      shoppingBag.add(orderProduct);
    }

    emit(state.copyWith(shoppingBag: shoppingBag));
  }
}
