import 'package:http/http.dart' as http;
import 'package:module14_assignment/constants/constants.dart';

class DeleteProductService {
  Future<bool> deleteProduct(String id) async {
    final url = Uri.parse('${deleteUrl}$id');
    final response = await http.get(url);

    return response.statusCode == 200;
  }
}
