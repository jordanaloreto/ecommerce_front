import 'package:flutter/material.dart';
import '../models/categoria.dart';
import '../services/categoria_service.dart';

class CategoriaController extends ChangeNotifier {
  final CategoriaService _service = CategoriaService();
  List<Categoria> _categorias = [];

  List<Categoria> get categorias => _categorias;

  // Função para carregar os produtos
  Future<void> loadCategorias() async {
    try {
      _categorias = await _service.getCategorias();
      notifyListeners();
    } catch (e) {
      print('Error loading categorias: $e');
    }
  }

  // Função para adicionar um novo produto
  Future<void> addCategoria(Categoria categoria) async {
    try {
      final addedCategoria = await _service.addCategoria(categoria);
      _categorias.add(addedCategoria);
      notifyListeners();
    } catch (e) {
      print('Error adding categoria: $e');
    }
  }

  // Função para remover um produto

  Future<void> removeCategoria(int id) async {
    try {
      await _service.removeCategoria(id);
      _categorias.removeWhere((categoria) => categoria.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting categoria: $e');
    }
  }

  Future<void> updateCategoria(Categoria categoria) async {
  try {
    await _service.updateCategoria(categoria);
    final index = _categorias.indexWhere((c) => c.id == categoria.id);
    if (index != -1) {
      _categorias[index] = categoria;
      notifyListeners();
    }
  } catch (e) {
    print('Error updating categoria: $e');
  }
}

}