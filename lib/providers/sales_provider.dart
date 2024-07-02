import 'package:flutter/material.dart';
import '../models/sales.dart';
import '../services/api_service.dart';

class SalesProvider with ChangeNotifier {
  List<Sales> _sales = [];

  List<Sales> get sales => _sales;

  Future<void> fetchSales() async {
    try {
      _sales = await ApiService.fetchSales();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addSales(Sales sales) async {
    try {
      await ApiService.addSales(sales);
      _sales.add(sales);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateSales(Sales sales) async {
    try {
      await ApiService.updateSales(sales);
      final index = _sales.indexWhere((item) => item.id == sales.id);
      if (index != -1) {
        _sales[index] = sales;
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteSales(int id) async {
    try {
      await ApiService.deleteSales(id);
      _sales.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
