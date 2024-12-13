import '../models/categoria.dart';
import '../repositories/categoria_repository.dart';

class CategoriaService {
  final CategoriaRepository _repository = CategoriaRepository();

  Future<List<Categoria>> getCategorias() {
    return _repository.fetchCategorias();
  }

  Future<Categoria> addCategoria(Categoria categoria) {
    return _repository.createCategoria(categoria);
  }

  Future<void> removeCategoria(int id) {
    return _repository.deleteCategoria(id);
  }
}