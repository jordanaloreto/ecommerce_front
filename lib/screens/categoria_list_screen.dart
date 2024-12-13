import 'package:ecommerce_front/controllers/categoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/categoria_card.dart'; // Importa o widget CategoriaCard
import 'add_categoria_popup.dart'; // Importa a tela de pop-up para adicionar novos categorias

class CategoriaListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CategoriaController>(context, listen: false);
    controller.loadCategorias(); // Carrega a lista de categorias ao construir a tela

    return Stack(
      children: [
        Consumer<CategoriaController>(
          builder: (context, controller, child) {
            // Exibe uma mensagem centralizada se a lista de categorias estiver vazia
            if (controller.categorias.isEmpty) {
              return const Center(child: Text("Nenhum categoria cadastrado"));
            }
            // Caso contrário, exibe uma ListView dos categorias
            return ListView.builder(
              itemCount: controller.categorias.length, // Número de categorias na lista
              itemBuilder: (context, index) {
                return CategoriaCard(categoria: controller.categorias[index]); // Exibe cada categoria usando CategoriaCard
              },
            );
          },
        ),
        // Botão flutuante adicionado ao Stack
        Positioned(
          bottom: 16, // Distância da parte inferior da tela
          right: 16, // Distância do lado direito da tela
          child: FloatingActionButton(
            onPressed: () {
              // Exibe o pop-up de adicionar categoria ao pressionar o botão
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddCategoriaPopup(); // Widget responsável por adicionar novos categorias
                },
              );
            },
            child: Icon(Icons.add), // Ícone '+' para adicionar categorias
            backgroundColor: Colors.green, // Define a cor de fundo do botão como verde
          ),
        ),
      ],
    );
  }
}