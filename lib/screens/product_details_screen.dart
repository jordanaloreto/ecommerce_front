import 'package:ecommerce_front/screens/ask_question_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ecommerce_front/controllers/cart_controller.dart';
import 'package:ecommerce_front/utils/app_storage.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double _rating = 3.0; // Valor inicial da nota
  bool _isSubmitting = false; // Estado do envio da avaliação
Future<Map<String, String>> _getHeaders() async {
    final token = AppStorage.instance.token;
    if (token != null) {
      return {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
    }
    return {"Content-Type": "application/json"};
  }
  Future<void> _submitReview() async {
    setState(() {
      _isSubmitting = true;
    });

    final userId = AppStorage().getUserId(); // Pegue o ID do usuário logado
    final url = Uri.parse('http://localhost:8000/review/save'); // Altere para a URL do seu backend

    final response = await http.post(
      url,
      headers: await _getHeaders(),
      body: jsonEncode({
        "product_id": widget.product.id,
        "user_id": userId,
        "rating": _rating,
      }),
    );

    setState(() {
      _isSubmitting = false;
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Avaliação enviada com sucesso!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao enviar a avaliação.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth = constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
            return SingleChildScrollView(
              child: Container(
                width: cardWidth,
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          "assets/images/10771017.png",
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "R\$${widget.product.price.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                            
                            
                            SizedBox(height: 16),
                            // Componente de Avaliação
                            Text("Avalie este produto:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            RatingBar.builder(
                              initialRating: _rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  _rating = rating;
                                });
                              },
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: ElevatedButton(
                                onPressed: _isSubmitting ? null : _submitReview,
                                child: _isSubmitting
                                    ? CircularProgressIndicator(color: Colors.white)
                                    : Text("Enviar Avaliação"),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Provider.of<CartController>(context, listen: false)
                                      .addProductToCart(AppStorage().getUserId(), widget.product.id, 1);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Produto adicionado ao carrinho!")),
                                  );
                                },
                                icon: Icon(Icons.shopping_cart),
                                label: Text("Adicionar ao Carrinho"),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AskQuestionScreen(productId: widget.product.id),
                                  ),
                                );
                              },
                              child: Text("Ver Perguntas e Respostas"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
