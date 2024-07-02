import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/sales_provider.dart';
import '../../models/sales.dart';
import 'add_sales_page.dart';

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: provider.fetchSales(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching sales'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: provider.sales.length,
            itemBuilder: (context, index) {
              Sales sales = provider.sales[index];
              return Card(
                color: Colors.red[50],
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(sales.buyer),
                  subtitle: Text('Phone: ${sales.phone}, Date: ${sales.date}, Status: ${sales.status}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddSalesPage(sales: sales)),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          provider.deleteSales(sales.id);
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
            MaterialPageRoute(builder: (context) => AddSalesPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
