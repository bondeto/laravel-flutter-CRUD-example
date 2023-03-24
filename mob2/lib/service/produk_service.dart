import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mob2/model/produk.dart';

class ProductApi {
  static const baseUrl = 'http://10.0.2.2:8000/api/produk';
  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List<dynamic>;
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
