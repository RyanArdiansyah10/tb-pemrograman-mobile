import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../services/api_service.dart';

class StockProvider with ChangeNotifier {
  List<Stock> _stocks = [];

  List<Stock> get stocks => _stocks;

  Future<void> fetchStocks() async {
    try {
      _stocks = await ApiService.fetchStocks();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addStock(Stock stock) async {
    try {
      await ApiService.addStock(stock);
      _stocks.add(stock);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateStock(Stock stock) async {
    try {
      await ApiService.updateStock(stock);
      final index = _stocks.indexWhere((item) => item.id == stock.id);
      if (index != -1) {
        _stocks[index] = stock;
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteStock(int id) async {
    try {
      await ApiService.deleteStock(id);
      _stocks.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
