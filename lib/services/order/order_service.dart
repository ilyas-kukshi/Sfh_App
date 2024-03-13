import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sfh_app/models/products/product_model.dart';

part 'order_service.g.dart';

class OrderService {}

@Riverpod(keepAlive: true)
class OrderListNotifier extends _$OrderListNotifier {
  @override
  List<ProductModel> build() {
    return [];
  }

  void add(ProductModel product) {
    final copiedState = [...state, product];
    state = copiedState;
  }

  void clear() {
    state = [];
  }
}
