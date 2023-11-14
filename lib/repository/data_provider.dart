// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sprout/model/product_details.dart';

import '../model/product_list_model.dart';

class ProductService {
  final String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts(int skip, int limit) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?limit=$limit&skip=$skip&select=title,price,thumbnail,stock,discountPercentage'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)["products"];
      List<Product> products =
          jsonData.map((data) => Product.fromJson(data)).toList();

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductDetails> fetchProductsDetails(int productID) async {
    final response = await http.get(Uri.parse('$baseUrl/$productID'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return ProductDetails.fromJson(jsonData);
    } else {
      throw Exception('Failed to load product details');
    }
  }
}

  // Future<ProductList> fetchProductDetails(int productId) async {
  //   final response = await http.get(Uri.parse('$baseUrl/$productId'));
  //   if (response.statusCode == 200) {
  //     final dynamic data = json.decode(response.body);
  //     return ProductList.fromJson(data);
  //   } else {
  //     throw Exception('Failed to load product details');
  //   }
  // }

