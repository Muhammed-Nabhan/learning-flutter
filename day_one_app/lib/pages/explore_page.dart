// lib/pages/explore_page.dart
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Welcome to the Explore Page!',
            //style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}
