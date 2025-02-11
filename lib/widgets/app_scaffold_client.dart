import 'package:ecommerce_front/controllers/sub_categoria_controller.dart';
import 'package:ecommerce_front/models/sub_categoria.dart';
import 'package:ecommerce_front/screens/cart_screen.dart';
import 'package:ecommerce_front/screens/login_screen.dart';
import 'package:ecommerce_front/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_front/screens/product_list_screen_client.dart';
import 'package:ecommerce_front/screens/ask_question_screen.dart';

import '../screens/product_question_screen.dart'; // Nova tela

class AppScaffoldClient extends StatelessWidget {
  final Widget bodyContent;

  AppScaffoldClient({required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Commerce"),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
              ),
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/10771017.png"),
              ),
              SizedBox(width: 8),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  } else if (value == 'pedidos') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderListScreen()),
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'pedidos',
                      child: Text('Pedidos'),
                    ),
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Text('Logout'),
                    ),
                  ];
                },
                child: Text("Nome do Usuário"),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder<List<SubCategoria>>(
          future: SubCategoriaController().fetchSubCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar subcategorias'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhuma subcategoria encontrada'));
            } else {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Text(
                      'Menu',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                  ...snapshot.data!.map((subcategory) {
                    return ListTile(
                      title: Text(subcategory.name),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppScaffoldClient(
                              bodyContent: ProductListScreenClient(
                                subcategoryId: subcategory.id,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ],
              );
            }
          },
        ),
      ),
      body: bodyContent,
      // Botão flutuante para fazer uma pergunta
      floatingActionButton: bodyContent is ProductQuestionsScreen
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AskQuestionScreen(
                      productId: (bodyContent as ProductQuestionsScreen).productId,
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}