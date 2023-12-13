import 'package:disappear/models/product/product_model.dart';
import 'package:disappear/models/product_model.dart';
import 'package:disappear/services/product_service.dart';
import 'package:flutter/foundation.dart';

class SearchProductViewModel extends ChangeNotifier {
  bool _isOnSearch = false;

  set isOnSearch(bool isOnSearch) {
    _isOnSearch = isOnSearch;
    notifyListeners();
  }

  bool get isOnSearch => _isOnSearch;

  bool _isSearching = false;

  set isSearching(bool isSearching) {
    _isSearching = isSearching;
    notifyListeners();
  }

  bool get isSearching => _isSearching;

  List<Product> _products = [];

  set products(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  List<Product> get products => _products;

  int _page = 1;

  set page(int page) {
    _page = page;
    notifyListeners();
  }

  int get page => _page;

  Future<void> getProducts({
    required String keyword,
    int filterType = 0,
  }) async {
    page = 1;

    products = [];

    isOnSearch = true;
    isSearching = true;

    final productService = ProductService();
    products = await productService.getProducts(
      keyword: keyword,
      page: page,
      filterType: filterType,
    );

    isSearching = false;
  }

  Future<void> getMoreProducts({
    required String keyword,
    int filterType = 0,
  }) async {
    page++;

    isOnSearch = true;
    isSearching = true;

    final productService = ProductService();
    final newProducts = await productService.getProducts(
      keyword: keyword,
      page: page,
      filterType: filterType,
    );
    
    products = [...products, ...newProducts];

    isSearching = false;
  }
}