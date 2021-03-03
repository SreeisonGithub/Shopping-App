//import 'dart:convert';

import 'package:funcart/models/productModel.dart';
import 'package:http/http.dart' show Client;

class ProductApi {
  static Client client = Client();
  final String _root = 'https://makeup-api.herokuapp.com/api/v1/products.json';

  Future<List<Products>> fetchProducts() async {
    var response = await client.get(_root);
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productsFromJson(jsonString);
    } else {
      return throw Exception('Failed to load data');
    }
  }
}
