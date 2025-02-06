import '../models/role.dart';
import '../services/role_service.dart';
import 'package:flutter/material.dart';

class RoleController extends ChangeNotifier {
  final RoleService _service = RoleService();
  List<Role> _roles = [];

  List<Role> get roles => _roles;

  // Função para carregar os produtos
  Future<void> loadRoles() async {
    try {
      _roles = await _service.getRoles();
      notifyListeners();
    } catch (e) {
      print('Error loading roles: $e');
    }
  }

  // Função para adicionar um novo produto
  Future<void> addRole(Role role) async {
    try {
      final addedRole = await _service.addRole(role);
      _roles.add(addedRole);
      notifyListeners();
    } catch (e) {
      print('Error adding role: $e');
    }
  }

  // Função para remover um produto

  Future<void> removeRole(int id) async {
    try {
      await _service.removeRole(id);
      _roles.removeWhere((role) => role.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting role: $e');
    }
  }

  // Função para atualizar uma role existente
  Future<void> updateRole(Role role) async {
    try {
      final updatedRole = await _service.updateRole(role);
      final index = _roles.indexWhere((r) => r.id == role.id);
      if (index != -1) {
        _roles[index] = updatedRole;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating role: $e');
    }
  }
}