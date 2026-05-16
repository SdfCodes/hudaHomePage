import 'package:flutter/material.dart';
import 'package:huda_home_page/pages/Payment.dart';
import 'package:huda_home_page/pages/account_settings.dart';
import 'package:huda_home_page/pages/download_page.dart';
import 'package:huda_home_page/pages/reminder.dart';
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
    const PaymentPage(),
    const SearchPage(),
    const DownloadsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: HudaStudentTheme.light(),
      home: Scaffold(

        backgroundColor: const Color(0xffF8F8F8),

        body: _pages[_selectedIndex],

        bottomNavigationBar: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: Colors.transparent,
                labelTextStyle: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const TextStyle(color: Color(0xff2E2E48), fontWeight: FontWeight.bold);
                  }
                  return const TextStyle(color: Colors.grey);
                }),
                iconTheme: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const IconThemeData(color: Color(0xff2E2E48), size: 28);
                  }
                  return const IconThemeData(color: Colors.grey, size: 26);
                }),
              ),
              child: NavigationBar(
                backgroundColor: Colors.white,
                elevation: 0,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(icon: Icon(Icons.search), selectedIcon: Icon(Icons.search), label: 'Search'),
                  NavigationDestination(icon: Icon(Icons.file_download_outlined), selectedIcon: Icon(Icons.file_download), label: 'Downloads'),
                  NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
