
import '../models/role.dart';
import '../repositories/role_repository.dart';

class RoleService {
  final RoleRepository _repository =
      RoleRepository(); // Instância do repositório de categorias

  // Função para obter todas as categorias
  Future<List<Role>> getRoles() async {
    return await _repository.fetchCategories();
  }

  // Função para adicionar uma nova categoria
  Future<Role> addRole(Role role) async {
    return await _repository.createRole(role);
  }

  // Função para remover uma categoria
  Future<void> removeRole(int id) async {
    return await _repository.deleteRole(id);
  }

  // Função para atualizar uma role existente
  Future<Role> updateRole(Role role) async {
    return await _repository.updateRole(role);
  }
}