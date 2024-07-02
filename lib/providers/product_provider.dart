import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    try {
      _products = await ApiService.fetchProducts();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await ApiService.addProduct(product);
      _products.add(product);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await ApiService.updateProduct(product);
      final index = _products.indexWhere((item) => item.id == product.id);
      if (index != -1) {
        _products[index] = product;
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await ApiService.deleteProduct(id);
      _products.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
