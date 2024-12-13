import '../models/categoria.dart';

class SubCategoria {
  int id;
  String name;
  int categoriaId; // ID da categoria à qual a subcategoria pertence
  Categoria categoria; // Objeto Categoria para acessar informações da categoria

  // Construtor da classe SubCategory
  SubCategoria({
    required this.id,
    required this.name,
    required this.categoriaId,
    required this.categoria,
  });

  // Fábrica que cria uma instância de SubCategory a partir de um JSON
  factory SubCategoria.fromJson(Map<String, dynamic> json) {
    return SubCategoria(
      id: json['id'],
      name: json['name'],
      categoriaId: json['categoria_id'],
      categoria: Categoria.fromJson(json['categoria']),
    );
  }

  // Método que converte uma instância de SubCategoria para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoria_id': categoriaId,
    };
  }
}