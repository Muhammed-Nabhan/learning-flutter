// lib/home_screen.dart

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 5, // Number of cards to display
        itemBuilder: (context, index) {
          return Card(
            elevation: 5, // Shadow effect for the card
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  // Image on the left side of the card
                  Container(
                    width: 100, // Width of the image container
                    height: 100, // Height of the image container
                    margin: const EdgeInsets.only(right: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        'lib/images/cs.jpg', // Use your asset image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Content of the card
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name Card ${index + 1}', // Add some space between the text and button
                        ),
                        const SizedBox(height: 20),
                        const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your name',
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Action when button is pressed
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor:
                                Colors.white, // Set the background color
                          ),
                          child: const Text('Submit'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
