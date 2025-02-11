import 'package:ecommerce_front/screens/categoria_list_screen.dart';
import 'package:ecommerce_front/screens/login_screen.dart';
import 'package:ecommerce_front/screens/product_list_screen_adm.dart';
import 'package:ecommerce_front/screens/role_list_screen.dart';
import 'package:ecommerce_front/screens/sub_categoria_list_screen.dart';
import 'package:ecommerce_front/screens/user_list_screen.dart';
import 'package:flutter/material.dart';

import '../screens/admin_question_list_screen.dart';

class AppScaffoldAdm extends StatelessWidget {
  final Widget bodyContent;

  AppScaffoldAdm({required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product App"),
        actions: [
          Row(
            children: [
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
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Produtos'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: ProductListScreenAdm()),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Categorias'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: CategoriaListScreen()),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Subcategorias'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: SubCategoriaListScreen()),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Perfil'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: RoleListScreen()),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Usuário'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: UserListScreen()),
                  ),
                );
              },
            ),
            // Nova opção para acessar perguntas
            ListTile(
              title: Text('Perguntas'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: AdminQuestionsListScreen()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: bodyContent,
    );
  }
}