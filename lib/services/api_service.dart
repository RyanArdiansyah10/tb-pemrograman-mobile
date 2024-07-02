import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/stock.dart';
import '../models/product.dart';
import '../models/sales.dart';

class ApiService {
  static const String baseUrl = 'https://api.kartel.dev';

  // Fetch stocks from API
  static Future<List<Stock>> fetchStocks() async {
    final response = await http.get(Uri.parse('$baseUrl/stocks'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Stock.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stocks');
    }
  }

  // Fetch products from API
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch sales from API
  static Future<List<Sales>> fetchSales() async {
    final response = await http.get(Uri.parse('$baseUrl/sales'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Sales.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sales');
    }
  }

  // Add stock to API
  static Future<void> addStock(Stock stock) async {
    final response = await http.post(
      Uri.parse('$baseUrl/stocks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(stock.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add stock');
    }
  }

  // Update stock in API
  static Future<void> updateStock(Stock stock) async {
    final response = await http.put(
      Uri.parse('$baseUrl/stocks/${stock.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(stock.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update stock');
    }
  }

  // Delete stock from API
  static Future<void> deleteStock(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/stocks/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete stock');
    }
  }

  // Add product to API
  static Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add product');
    }
  }

  // Update product in API
  static Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/${product.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  // Delete product from API
  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/products/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }

  // Add sales to API
  static Future<void> addSales(Sales sales) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sales'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(sales.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add sales');
    }
  }

  // Update sales in API
  static Future<void> updateSales(Sales sales) async {
    final response = await http.put(
      Uri.parse('$baseUrl/sales/${sales.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(sales.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update sales');
    }
  }

  // Delete sales from API
  static Future<void> deleteSales(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/sales/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete sales');
    }
  }
}
