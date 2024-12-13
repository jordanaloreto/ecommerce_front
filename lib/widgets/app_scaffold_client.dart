// Importa as telas necessárias para navegação no aplicativo
import 'package:ecommerce_front/screens/cart_screen.dart';
import 'package:ecommerce_front/screens/login_screen.dart';
import 'package:ecommerce_front/screens/orders_screen.dart';
import 'package:flutter/material.dart';

// Classe AppScaffold, que define a estrutura básica do aplicativo
class AppScaffoldClient extends StatelessWidget {
  // Define o conteúdo principal da tela que será exibido no corpo
  final Widget bodyContent;

  // Construtor da classe AppScaffold que recebe o conteúdo principal como parâmetro
  AppScaffoldClient({required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    // Retorna a estrutura Scaffold, que é a base da tela
    return Scaffold(
      // Configuração da AppBar na parte superior da tela
      appBar: AppBar(
        title: Text("E-Commerce"), // Define o título do app bar
        actions: [
          // Exibe o avatar do usuário e um menu suspenso (PopupMenuButton) no app bar
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
              // CircleAvatar para mostrar a imagem do usuário
              CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/images/10771017.png"), // Imagem do usuário no avatar
              ),
              SizedBox(width: 8), // Espaçamento entre o avatar e o menu
              // PopupMenuButton que exibe um menu ao clicar
              PopupMenuButton<String>(
                // Função chamada quando uma opção é selecionada
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
                // Define os itens do menu suspenso
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'pedidos', // Valor associado à opção
                      child: Text('Pedidos'), // Texto exibido para o item
                    ),
                    // Item do menu para Logout
                    PopupMenuItem<String>(
                      value: 'logout', // Valor associado à opção
                      child: Text('Logout'), // Texto exibido para o item
                    ),
                  ];
                },
                // Texto exibido no botão do menu suspenso
                child: Text("Nome do Usuário"), // Nome do usuário na AppBar
              ),
            ],
          ),
        ],
      ),
      // Configuração do Drawer, que é um menu lateral
      drawer: Drawer(
        // Define a lista de itens que aparecerão no drawer
        child: ListView(
          padding: EdgeInsets.zero, // Remove o padding padrão
          children: [
            // Cabeçalho do drawer
            DrawerHeader(
              child: Text(
                'Menu', // Título do drawer
                style: TextStyle(
                    color: Colors.white, fontSize: 24), // Estilo do texto
              ),
              decoration: BoxDecoration(
                  color: Colors.blue), // Cor de fundo do cabeçalho do drawer
            ),
            // Item de lista para navegação até a tela de produtos
            ListTile(
              title: Text('Informática'), // Título do item "Produtos"
              onTap: () {
                // // Navega para a tela de lista de produtos ao selecionar o item
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AppScaffoldClient(
                //         bodyContent: ProductListScreenClient()),
                //   ),
                // );
              },
            ),
            // Item de lista para navegação até a tela de categorias
            ListTile(
              title: Text('Eletrônicos'), // Título do item "Categorias"
              onTap: () {
                // Navega para a tela de lista de categorias ao selecionar o item
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         AppScaffoldClient(bodyContent: CategoryListScreen()),
                //   ),
                // );
              },
            ),
            ListTile(
              title: Text('Alimentação'), // Título do item "Categorias"
              onTap: () {
                // Navega para a tela de lista de categorias ao selecionar o item
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         AppScaffoldClient(bodyContent: SubCategoryListScreen()),
                //   ),
                // );
              },
            ),

            // Outros itens do menu podem ser adicionados aqui
          ],
        ),
      ),
      // Define o conteúdo principal da tela
      body: bodyContent,
    );
  }
}
