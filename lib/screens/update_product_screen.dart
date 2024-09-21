import 'package:flutter/material.dart';
import '../services/update_product_service.dart';

class UpdateProductScreen extends StatefulWidget {
  final String productId;
  final String initialProductName;
  final String initialProductCode;
  final String initialQty;
  final String initialTotalPrice;
  final String initialUnitPrice;
  final String initialImg;

  const UpdateProductScreen({
    Key? key,
    required this.productId,
    required this.initialProductName,
    required this.initialProductCode,
    required this.initialQty,
    required this.initialTotalPrice,
    required this.initialUnitPrice,
    required this.initialImg,
  }) : super(key: key);

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _productNameController;
  late TextEditingController _productCodeController;
  late TextEditingController _qtyController;
  late TextEditingController _totalPriceController;
  late TextEditingController _unitPriceController;
  late TextEditingController _imgController;

  final UpdateProductService _updateProductService = UpdateProductService();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _productNameController =
        TextEditingController(text: widget.initialProductName);
    _productCodeController =
        TextEditingController(text: widget.initialProductCode);
    _qtyController = TextEditingController(text: widget.initialQty);
    _totalPriceController =
        TextEditingController(text: widget.initialTotalPrice);
    _unitPriceController = TextEditingController(text: widget.initialUnitPrice);
    _imgController = TextEditingController(text: widget.initialImg);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      bool success = await _updateProductService.updateProduct(
        widget.productId,
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
          SnackBar(content: Text('Product updated successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update product')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
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
                      child: Text('Update Product'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
