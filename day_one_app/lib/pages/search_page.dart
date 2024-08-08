// lib/search_screen.dart
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.title});

  final String title;

  void _showFilterSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 16.0),
              // Filter options
              ListTile(
                title: const Text('Filter by Category'),
                trailing: const Icon(Icons.filter_list),
                onTap: () {
                  // Handle filter option
                },
              ),
              ListTile(
                title: const Text('Sort by Price'),
                trailing: const Icon(Icons.sort),
                onTap: () {
                  // Handle sort option
                },
              ),

              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSortBottomSheet(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Number of columns in the grid
            crossAxisSpacing: 32.0, // Space between columns
            mainAxisSpacing: 40.0, // Space between rows
          ),
          itemCount: 10, // Number of cards to display
          itemBuilder: (context, index) {
            return Card(
              elevation: 5, // Shadow effect for the card
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset('lib/images/R.jpg'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Card ${index + 1}',
                        style: const TextStyle(fontSize: 16),
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
