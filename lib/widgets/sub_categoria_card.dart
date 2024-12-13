import 'package:ecommerce_front/models/sub_categoria.dart';
import 'package:flutter/material.dart';
import '../controllers/sub_categoria_controller.dart';
import 'package:provider/provider.dart';

// Widget que exibe os detalhes de uma subcategoria em um cartão (Card)
class SubCategoriaCard extends StatelessWidget {
  final SubCategoria subCategoria; // Subcategoria a ser exibida

  // Construtor que recebe uma subcategoria e usa o id como chave única
  SubCategoriaCard({required this.subCategoria})
      : super(key: ValueKey(subCategoria.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card que envolve o ListTile, criando um visual com bordas elevadas
      child: ListTile(
        title: Text(subCategoria.name), // Título exibindo o nome da subcategoria
        subtitle: Text(
          'Categoria: ${subCategoria.categoria.name}', // Nome da categoria associada
          style: TextStyle(color: Colors.grey[600]), // Cor cinza para o texto
        ),
        // Botão de deletar subcategoria no canto direito do cartão
        trailing: IconButton(
          icon: Icon(Icons.delete), // Ícone de lixeira
          onPressed: () {
            // Ao pressionar, chama o método de remoção do SubCategoriaController
            Provider.of<SubCategoriaController>(context, listen: false)
                .removeSubCategoria(subCategoria.id);
          },
        ),
      ),
    );
  }
}