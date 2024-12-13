import 'package:ecommerce_front/controllers/sub_categoria_controller.dart';
import 'package:ecommerce_front/screens/add_sub_categoria_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/sub_categoria_card.dart';

class SubCategoriaListScreen extends StatelessWidget {
  // final int categoryId; // ID da categoria para carregar as subcategorias

  @override
  Widget build(BuildContext context) {
     final controller = Provider.of<SubCategoriaController>(context, listen: false);
    controller.loadSubCategorias(); 
    return Stack(
      children: [
        Consumer<SubCategoriaController>(
          builder: (context, controller, child) {
            if (controller.subCategorias.isEmpty) {
              return const Center(
                  child: Text("Nenhuma subcategoria cadastrada"));
            }
            return ListView.builder(
              itemCount: controller.subCategorias.length,
              itemBuilder: (context, index) {
                return SubCategoriaCard(
                    subCategoria: controller.subCategorias[
                        index]); // Exibe cada subcategoria usando SubCategoriaCard
              },
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddSubCategoriaPopup(); // Widget responsável por adicionar novas subcategorias
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor:
                Colors.orange, // Define a cor de fundo do botão como laranja
          ),
        ),
      ],
    );
  }
}