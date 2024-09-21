import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:module14_assignment/constants/constants.dart';

class GetProductListService {
  Future<List<dynamic>> fetchProducts() async {
    final url = Uri.parse('${getUrl}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      dynamic products = json.decode(response.body);
      return products["data"];
    } else {
      throw Exception('Failed to load product list');
    }
  }
}
