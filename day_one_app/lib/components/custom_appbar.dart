import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData rightIcon;
  final DateTime? selectedDate;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.rightIcon,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center content horizontally
        children: [
          Flexible(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis, // Prevent overflow
            ),
          ),
          if (selectedDate != null)
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0), // Reduced padding for better fit
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                ),
              ),
            ),
        ],
      ),
      centerTitle: true, // Center title within AppBar
      backgroundColor: Colors.deepPurple,
      actions: <Widget>[
        IconButton(
          icon: Icon(rightIcon, color: Colors.white),
          onPressed: () {
            // Define the action for the icon button here
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
