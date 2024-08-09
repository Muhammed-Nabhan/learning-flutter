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
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine crossAxisCount based on screen width
    final crossAxisCount = screenWidth < 600 ? 2 : 4;

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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, // Dynamic crossAxisCount
            crossAxisSpacing: 16.0, // Space between columns
            mainAxisSpacing: 16.0, // Space between rows
            childAspectRatio: 0.8, // Adjust the aspect ratio for better fit
          ),
          itemCount: 10, // Number of cards to display
          itemBuilder: (context, index) {
            return Card(
              elevation: 5, // Shadow effect for the card
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          'lib/images/R.jpg',
                          fit: BoxFit
                              .contain, // Scale the image to fit within the bounds
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Card ${index + 1}',
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis, // Prevent text overflow
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
