import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductService {
  final ProductRepository _repository = ProductRepository();

  Future<List<Product>> getProducts() {
    return _repository.fetchProducts();
  }

  Future<List<Product>> getProductsBySubcategory(int? subcategory) async {
    return await _repository.fetchProductsBySubcategory(subcategory);
  }
  
  Future<Product> addProduct(Product product) {
    return _repository.createProduct(product);
  }

  Future<void> removeProduct(int id) {
    return _repository.deleteProduct(id);
  }

  Future<Product> editProduct(Product product) {
    return _repository.updateProduct(product);
  }

}