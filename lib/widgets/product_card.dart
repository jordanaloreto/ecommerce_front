import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../screens/add_product_popup.dart'; // Importa o pop-up de adicionar/editar produtos

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product}) : super(key: ValueKey(product.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue), // Ícone de lápis para edição
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddProductPopup(
                      product: product, // Passa o produto para edição
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red), // Ícone de lixeira para exclusão
              onPressed: () {
                Provider.of<ProductController>(context, listen: false)
                    .removeProduct(product.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
