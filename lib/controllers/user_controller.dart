import '../models/user.dart';
import '../services/user_service.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UserService _service = UserService();
  List<User> _users = [];

  List<User> get users => _users;

  // Função para carregar os produtos
  Future<void> loadUsers() async {
    try {
      _users = await _service.getUsers();
      notifyListeners();
    } catch (e) {
      print('Error loading users: $e');
    }
  }

  // Função para adicionar um novo produto
  Future<void> addUser(User subCategory) async {
    try {
      final addedUser = await _service
          .addUser(subCategory); // Adiciona a subcategoria pelo serviço
      _users.add(addedUser); // Adiciona a nova subcategoria na lista local
      notifyListeners(); // Notifica os ouvintes sobre a mudança no estado
    } catch (e) {
      print('Error adding user: $e'); // Imprime o erro no console
    }
  }

  // Função para remover um produto

  Future<void> removeUser(int id) async {
    try {
      await _service.removeUser(id); // Remove a subcategoria pelo serviço
      _users.removeWhere(
          (subCategory) => subCategory.id == id); // Remove da lista local
      notifyListeners(); // Notifica os ouvintes sobre a mudança no estado
    } catch (e) {
      print('Error deleting user: $e'); // Imprime o erro no console
    }
  }
}