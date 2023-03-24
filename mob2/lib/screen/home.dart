import 'package:flutter/material.dart';
import 'package:mob2/screen/produk_detail.dart';

import '../model/produk.dart';
import '../service/produk_service.dart';
import 'add_produk.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Product>> _productsFuture;

  Future<void> _refreshProducts() async {
    setState(() {
      _productsFuture = ProductApi.getProducts();
    });
  }

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductApi.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => createProduk()),
                );
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Center(
          child: RefreshIndicator(
            onRefresh: _refreshProducts,
            child: FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                product: product,
                                onDelete: () {
                                  _refreshProducts();
                                },
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text(product.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('\$${product.price}'),
                            ],
                          ),
                          leading: Image.network(product.imageUrl ?? ''),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
