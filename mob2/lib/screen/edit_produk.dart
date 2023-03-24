import 'package:flutter/material.dart';
import 'package:mob2/model/produk.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  const EditProductPage({required this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;

  Future<void> updateProduct(Product updatedProduct) async {
    final url = 'http://10.0.2.2:8000/api/produk/${updatedProduct.id}';
    final response = await http.put(Uri.parse(url), body: {
      'name': updatedProduct.name,
      'deskripsi': updatedProduct.description,
      'harga': updatedProduct.price.toString(),
      'image_url': updatedProduct.imageUrl,
    });

    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to update product.');
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final updatedProduct = Product(
                  id: widget.product.id,
                  name: _nameController.text,
                  description: _descriptionController.text,
                  price: double.parse(_priceController.text),
                  imageUrl:
                      'https://fastly.picsum.photos/id/280/200/300.jpg?hmac=M5LGtIQZPTGPTTmFXFcgUUV0zXG6sy-bGJ6zDZHedA0',
                );
                await updateProduct(updatedProduct);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ));
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
