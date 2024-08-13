// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/camera_page.dart';
import 'pages/explore_page.dart';
import 'pages/file_page.dart';
import 'pages/home_page.dart';
import 'pages/reminder_page.dart';
import 'pages/search_page.dart';
import 'components/custom_appbar.dart';
import 'pages/notification_page.dart';
import 'pages/profile_page.dart';
import 'pages/cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'state/counter.dart'; // Import the Counter class

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 26, 14, 47),
        ),
        useMaterial3: true,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;
  DateTime? _selectedDate; // Store the selected date

  static const List<String> _titles = <String>[
    'Home Page',
    'Search',
    'Notifications',
  ];
  @override
  void initState() {
    super.initState();
    _loadSelectedDate();
  }

  Future<void> _loadSelectedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dateString = prefs.getString('selectedDate');
    if (dateString != null) {
      setState(() {
        _selectedDate = DateTime.parse(dateString);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _navigateToPage(String page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (page) {
            case 'Profile':
              return const ProfilePage();
            case 'Cart':
              return const CartPage();
            case 'Reminder':
              return const ReminderPage();
            case 'Explore':
              return const ExplorePage();
            case 'Camera':
              return const CameraPage();
            case 'File':
              return const FilePage();
            default:
              return const Home();
          }
        },
      ),
    );
    // Reload the selected date after returning from the ReminderPage
    _loadSelectedDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _titles[_selectedIndex],

        rightIcon: Icons.settings,
        selectedDate: _selectedDate, // Pass the selected date here
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 119, 95, 161),
              ),
              child: Center(
                child: Text(
                  'L O G O',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPage('Profile');
              },
            ),
            ListTile(
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPage('Cart');
              },
            ),
            ListTile(
              title: const Text('Reminder'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPage('Reminder');
              },
            ),
            ListTile(
              title: const Text('Explore'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPage('Explore');
              },
            ),
            ListTile(
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPage('Camera');
              },
            ),
            ListTile(
              title: const Text('Files'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPage('File');
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(title: _titles[0]),
          SearchScreen(title: _titles[1]),
          NotificationPage(title: _titles[2]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.deepPurple),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.deepPurple),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.deepPurple),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
