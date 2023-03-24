import 'package:flutter/material.dart';
import 'package:mob2/model/produk.dart';
import 'package:http/http.dart' as http;

import 'edit_produk.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final Function onDelete;

  const ProductDetailPage({required this.product, required this.onDelete});

  //const ProductDetailPage({required this.product});
  Future<void> deleteProduct(int productId) async {
    final url = 'http://10.0.2.2:8000/api/produk/$productId';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Product deleted successfully');
      onDelete();
    } else {
      throw Exception('Failed to delete product');
    }
  }

  void _navigateToEditProductPage(BuildContext context) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductPage(product: product),
      ),
    );

    onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToEditProductPage(context);
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              bool result = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Product'),
                  content:
                      Text('Are you sure you want to delete this product?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('DELETE'),
                    ),
                  ],
                ),
              );
              if (result == true) {
                await deleteProduct(product.id);
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                product.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Price: ${product.price}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
