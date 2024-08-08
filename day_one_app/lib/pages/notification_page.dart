// lib/gesture_detector_page.dart
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key, required this.title});

  final String title;

  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  final List<bool> _expanded = List<bool>.generate(10, (_) => false);

  void _toggleExpansion(int index) {
    setState(() {
      _expanded[index] = !_expanded[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 10, // Number of cards to display
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _toggleExpansion(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Notification ${index + 1}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (_expanded[index])
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'This is the detailed view of Notification ${index + 1}. Tap again to collapse.',
                        style: const TextStyle(fontSize: 16),
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
