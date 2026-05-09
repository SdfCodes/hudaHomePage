import 'package:flutter/material.dart';
import 'package:huda_home_page/pages/download_page.dart';
import 'package:huda_home_page/pages/search_page.dart';
import 'package:huda_home_page/pages/settings_page.dart';
import 'huda_student_theme.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const DownloadPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: HudaStudentTheme.light(),
      darkTheme: HudaStudentTheme.dark(),
      themeMode: ThemeMode.system,
      home: Builder(
        builder: (context) => Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex == 0 ? 0 : _selectedIndex + 1,
            onDestinationSelected: (int index) {
              if (index == 1) {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              } else {
                setState(() {

                  _selectedIndex = index > 1 ? index - 1 : index;
                });
              }
            },
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
              NavigationDestination(icon: Icon(Icons.download), label: 'Downloads'),
              NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}
