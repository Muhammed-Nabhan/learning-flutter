import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool _isExpanded = false;

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
            // Positioned animated container
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
