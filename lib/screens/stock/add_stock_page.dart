import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/stock_provider.dart';
import '../../models/stock.dart';

class AddStockPage extends StatefulWidget {
  final Stock? stock;

  AddStockPage({this.stock});

  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _qty;
  late String _attr;
  late int _weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stock == null ? 'Add Stock' : 'Edit Stock'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.stock?.name ?? '',
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: widget.stock?.qty.toString() ?? '',
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
                onSaved: (value) {
                  _qty = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: widget.stock?.attr ?? '',
                decoration: InputDecoration(labelText: 'Attribute'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter attribute';
                  }
                  return null;
                },
                onSaved: (value) {
                  _attr = value!;
                },
              ),
              TextFormField(
                initialValue: widget.stock?.weight.toString() ?? '',
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter weight';
                  }
                  return null;
                },
                onSaved: (value) {
                  _weight = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.stock == null ? 'Add' : 'Update'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Stock newStock = Stock(
                      id: widget.stock!.id,
                      name: _name,
                      qty: _qty,
                      attr: _attr,
                      weight: _weight,
                    );

                    if (widget.stock == null) {
                      Provider.of<StockProvider>(context, listen: false)
                          .addStock(newStock);
                    } else {
                      Provider.of<StockProvider>(context, listen: false)
                          .updateStock(newStock);
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
