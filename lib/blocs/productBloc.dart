import 'package:funcart/models/productModel.dart';
//import 'package:funcart/services/db_service.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/products_api_provider.dart';

class ProductBloc {
  ProductBloc() {
    fetchProducts();
  }

  final _product = PublishSubject<List<Products>>();

  //getters to stream.
  Stream<List<Products>> get products => _product.stream;

  fetchProducts() async {
    final products = await ProductApi().fetchProducts();
    _product.sink.add(products);
  }

  dispose() {
    _product.close();
  }
}
