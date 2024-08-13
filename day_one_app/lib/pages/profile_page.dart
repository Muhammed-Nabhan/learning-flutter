import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool _isExpanded = false;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _loadImagePath();
  }

  Future<void> _loadImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      imagePath = prefs.getString('imagePath');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the midpoints
    final double midWidth = MediaQuery.of(context).size.width / 2;
    final double midHeight = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: const Text('Profile'),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  centerTitle: true,
                  floating: true,
                  pinned: true,
                  snap: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Colors.red,
                    ),
                  ),
                ),
                const SliverFillRemaining(
                  child: Center(
                      //child: const Text('Profile Page Content'),
                      ),
                ),
              ],
            ),
            // Positioned animated container with image
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              top: _isExpanded
                  ? midHeight -
                      150 // Center vertically considering circle's height when expanded
                  : midHeight -
                      25, // Center vertically considering circle's height when not expanded
              left: _isExpanded
                  ? midWidth -
                      150 // Center horizontally considering circle's width when expanded
                  : midWidth -
                      25, // Center horizontally considering circle's width when not expanded
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 50),
                width: _isExpanded ? 300 : 1,
                height: _isExpanded ? 300 : 1,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(300),
                  image: imagePath != null
                      ? DecorationImage(
                          image: FileImage(File(imagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: imagePath == null
                    ? Center(
                        child: Text(
                          'No Image',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
