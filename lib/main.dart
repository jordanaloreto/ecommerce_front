import 'package:ecommerce_front/controllers/user_controller.dart';
import 'package:ecommerce_front/screens/login_screen.dart';
import 'controllers/cart_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/order_controller.dart';
import 'controllers/role_controller.dart';
import 'controllers/sub_categoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/product_controller.dart';
import 'controllers/categoria_controller.dart';

void main() {
  // Inicia o app com MultiProvider para gerenciar múltiplos controladores de estado
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                ProductController()), // Inicia o ProductController como provedor de estado
        ChangeNotifierProvider(create: (_) => CategoriaController()),
        ChangeNotifierProvider(create: (_) => SubCategoriaController()),
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => RoleController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => OrderController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define a cor padrão do tema
      ),
      home: LoginScreen(), // Define a tela inicial como ProductListScreen
    );
  }
}
