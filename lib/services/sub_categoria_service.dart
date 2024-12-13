
import '../models/sub_categoria.dart';
import '../repositories/sub_categoria_repository.dart';


class SubCategoriaService {
  final SubCategoriaRepository _repository = SubCategoriaRepository();

  Future<List<SubCategoria>> getSubCategorias() {
    return _repository.fetchSubCategorias();
  }

  Future<SubCategoria> addSubCategoria(SubCategoria subCategoria) {
    return _repository.createSubCategoria(subCategoria);
  }

  Future<void> removeSubCategoria(int id) {
    return _repository.deleteSubCategoria(id);
  }  
}