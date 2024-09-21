import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:module14_assignment/constants/constants.dart';

class CreateProductService {
  Future<bool> createProduct(String img, String productCode, String productName,
      String qty, String totalPrice, String unitPrice) async {
    final url = Uri.parse('${createUrl}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "Img": img,
        "ProductCode": productCode,
        "ProductName": productName,
        "Qty": qty,
        "TotalPrice": totalPrice,
        "UnitPrice": unitPrice
      }),
    );

    return response.statusCode == 200;
  }
}
