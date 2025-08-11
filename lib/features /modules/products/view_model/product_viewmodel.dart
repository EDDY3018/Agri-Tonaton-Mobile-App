import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  final List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance.collection('products').get();
      _products.clear();

      for (var doc in snapshot.docs) {
        _products.add(ProductModel.fromFirestore(doc.data(), doc.id));
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void toggleSelection(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      final p = _products[index];
      _products[index] = ProductModel(
        id: p.id,
        name: p.name,
        imageUrl: p.imageUrl,
        price: p.price,
        location: p.location,
        description: p.description,
        date: p.date,
        sellerName: p.sellerName,
        sellerLocation: p.sellerLocation,
        selected: !p.selected,
      );
      notifyListeners();
    }
  }

  ProductModel getProductById(String id) {
    return _products.firstWhere((p) => p.id == id);
  }
}
