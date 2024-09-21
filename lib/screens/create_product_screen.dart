import 'package:flutter/material.dart';
import '../services/create_product_service.dart';

class CreateProductScreen extends StatefulWidget {
  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _qtyController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _imgController = TextEditingController();

  final CreateProductService _createProductService = CreateProductService();

  bool _isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      bool success = await _createProductService.createProduct(
        _imgController.text,
        _productCodeController.text,
        _productNameController.text,
        _qtyController.text,
        _totalPriceController.text,
        _unitPriceController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product')),
        );
      }
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productCodeController.dispose();
    _qtyController.dispose();
    _totalPriceController.dispose();
    _unitPriceController.dispose();
    _imgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _productNameController,
                      decoration: InputDecoration(labelText: 'Product Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _productCodeController,
                      decoration: InputDecoration(labelText: 'Product Code'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product code';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _qtyController,
                      decoration: InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter quantity';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _totalPriceController,
                      decoration: InputDecoration(labelText: 'Total Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter total price';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _unitPriceController,
                      decoration: InputDecoration(labelText: 'Unit Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter unit price';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _imgController,
                      decoration: InputDecoration(labelText: 'Image URL'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Add Product'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
