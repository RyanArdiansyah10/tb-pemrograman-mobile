import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../models/product.dart';
import 'add_product_page.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: provider.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching products'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              Product product = provider.products[index];
              return Card(
                color: Colors.green[50],
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: ${product.price}, Quantity: ${product.qty}, Attribute: ${product.attr}, Weight: ${product.weight}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddProductPage(product: product)),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          provider.deleteProduct(product.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
