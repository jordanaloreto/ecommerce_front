import 'package:flutter/material.dart';
import '../models/sub_categoria.dart';
import '../services/sub_categoria_service.dart';

class SubCategoriaController extends ChangeNotifier {
  final SubCategoriaService _service = SubCategoriaService();
  List<SubCategoria> _subCategorias = [];

  List<SubCategoria> get subCategorias => _subCategorias;

  // Função para carregar os produtos
  Future<void> loadSubCategorias() async {
    try {
      _subCategorias = await _service.getSubCategorias();
      notifyListeners();
    } catch (e) {
      print('Error loading subCategorias: $e');
    }
  }

  // Função para adicionar um novo produto
  Future<void> addSubCategoria(SubCategoria subCategoria) async {
    try {
      final addedCategoria = await _service.addSubCategoria(subCategoria);
      _subCategorias.add(addedCategoria);
      notifyListeners();
    } catch (e) {
      print('Error adding subCategoria: $e');
    }
  }

  // Função para remover um produto

  Future<void> removeSubCategoria(int id) async {
    try {
      await _service.removeSubCategoria(id);
      _subCategorias.removeWhere((subCategoria) => subCategoria.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting subCategoria: $e');
    }
  }
}