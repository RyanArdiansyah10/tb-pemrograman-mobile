import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/stock_provider.dart';
import '../../models/stock.dart';
import 'add_stock_page.dart';

class StockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: provider.fetchStocks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching stocks'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: provider.stocks.length,
            itemBuilder: (context, index) {
              Stock stock = provider.stocks[index];
              return Card(
                color: Colors.blue[50],
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(stock.name),
                  subtitle: Text('Quantity: ${stock.qty}, Attribute: ${stock.attr}, Weight: ${stock.weight}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddStockPage(stock: stock)),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          provider.deleteStock(stock.id);
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
            MaterialPageRoute(builder: (context) => AddStockPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
