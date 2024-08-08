import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Show an alert dialog when the cart icon is tapped
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Empty Cart'),
                  content: const Text('Your cart is empty.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: Stack(
            alignment: const Alignment(0, 0),
            children: [
              // Background circles
              Positioned(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[200],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: 90.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[300],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Cart icon on top of circles
              const Icon(
                Icons.shopping_cart,
                size: 60.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
