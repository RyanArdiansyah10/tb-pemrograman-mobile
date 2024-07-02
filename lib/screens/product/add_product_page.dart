import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../models/product.dart';

class AddProductPage extends StatefulWidget {
  final Product? product;

  AddProductPage({this.product});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _price;
  late int _qty;
  late String _attr;
  late double _weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.product?.name ?? '',
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
                initialValue: widget.product?.price.toString() ?? '',
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
               
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: widget.product?.qty.toString() ?? '',
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
                initialValue: widget.product?.attr ?? '',
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
                initialValue: widget.product?.weight.toString() ?? '',
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter weight';
                  }
                  return null;
                },
                onSaved: (value) {
                  _weight = double.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.product == null ? 'Add' : 'Update'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Product newProduct = Product(
                      id: widget.product?.id ?? 0,
                      name: _name,
                      price: _price,
                      qty: _qty,
                      attr: _attr,
                      weight: _weight,
                    );

                    if (widget.product == null) {
                      Provider.of<ProductProvider>(context, listen: false).addProduct(newProduct);
                    } else {
                      Provider.of<ProductProvider>(context, listen: false).updateProduct(newProduct);
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
