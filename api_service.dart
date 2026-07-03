import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_item.dart';

class ApiService {

  static const String baseUrl =
      'https://6a44f9f5aab3faec3f692609.mockapi.io/products';

  Future<List<ProductItem>> fetchProducts() async {

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body);

      return data
          .map((item) => ProductItem.fromJson(item))
          .toList();

    } else {

      throw Exception("Gagal mengambil data");

    }
  }
}