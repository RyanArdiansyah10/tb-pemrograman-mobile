import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/sales_provider.dart';
import '../../models/sales.dart';

class AddSalesPage extends StatefulWidget {
  final Sales? sales;

  AddSalesPage({this.sales});

  @override
  _AddSalesPageState createState() => _AddSalesPageState();
}

class _AddSalesPageState extends State<AddSalesPage> {
  final _formKey = GlobalKey<FormState>();
  late String _buyer;
  late String _phone;
  late String _date;
  late String _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sales == null ? 'Add Sales' : 'Edit Sales'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.sales?.buyer ?? '',
                decoration: InputDecoration(labelText: 'Buyer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter buyer name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _buyer = value!;
                },
              ),
              TextFormField(
                initialValue: widget.sales?.phone ?? '',
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              TextFormField(
                initialValue: widget.sales?.date ?? '',
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _date = value!;
                },
              ),
              TextFormField(
                initialValue: widget.sales?.status ?? '',
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter status';
                  }
                  return null;
                },
                onSaved: (value) {
                  _status = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.sales == null ? 'Add' : 'Update'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Sales newSales = Sales(
                      id: widget.sales?.id ?? 0,
                      buyer: _buyer,
                      phone: _phone,
                      date: _date,
                      status: _status,
                    );

                    if (widget.sales == null) {
                      Provider.of<SalesProvider>(context, listen: false).addSales(newSales);
                    } else {
                      Provider.of<SalesProvider>(context, listen: false).updateSales(newSales);
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
