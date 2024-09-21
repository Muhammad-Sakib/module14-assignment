import 'package:flutter/material.dart';
import 'package:module14_assignment/screens/create_product_screen.dart';
import 'package:module14_assignment/screens/update_product_screen.dart';
import 'package:module14_assignment/services/create_product_service.dart';
import 'package:module14_assignment/services/delete_product_service.dart';
import 'package:module14_assignment/services/get_product_list_service.dart';
import 'package:module14_assignment/services/update_product_service.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GetProductListService _getProductListService = GetProductListService();
  final CreateProductService _createProductService = CreateProductService();
  final UpdateProductService _updateProductService = UpdateProductService();
  final DeleteProductService _deleteProductService = DeleteProductService();

  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    try {
      List<dynamic> products = await _getProductListService.fetchProducts();
      setState(() {
        _products = products;
      });
    } catch (e) {
      print(e);
    }
  }

  void _createProduct() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateProductScreen()));
  }

  void _updateProduct(
      String id,
      String initialProductName,
      String initialProductCode,
      String initialQty,
      String initialTotalPrice,
      String initialUnitPrice,
      String initialImg) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProductScreen(
          productId: id,
          initialProductName: initialProductName,
          initialProductCode: initialProductCode,
          initialQty: initialQty,
          initialTotalPrice: initialTotalPrice,
          initialUnitPrice: initialUnitPrice,
          initialImg: initialImg,
        ),
      ),
    ).then((value) => _fetchProducts());
  }

  void _deleteProduct(String id) async {
    bool success = await _deleteProductService.deleteProduct(id);
    if (success) {
      _fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Product List')),
      ),
      backgroundColor: const Color.fromARGB(255, 237, 236, 236),
      body: ListView.builder(
        itemCount: _products.length,
        padding: EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ListTile(
              tileColor: Colors.white,
              minVerticalPadding: 10,
              title: Text(product['ProductName'] ?? 'No Name'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Code: ${product['ProductCode']}'),
                  Text('Price: ${product['UnitPrice']}'),
                  Text('Quantity: ${product['Qty']}'),
                  Text('Total Price: ${product['TotalPrice']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _updateProduct(
                        product['_id'],
                        product['ProductName'],
                        product['ProductCode'],
                        product['Qty'],
                        product['TotalPrice'],
                        product['UnitPrice'],
                        product['Img']),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => _deleteProduct(product['_id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: _createProduct,
      ),
    );
  }
}
