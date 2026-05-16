import 'package:flutter/material.dart';

import '../headerdesig.dart';
import 'account_settings.dart';
import 'app_settings.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HeaderDesign(
        title: 'Settings',
        children: [

          _buildMenuItem(
            context,
            title: 'Account Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountSettingsPage()),
              );
            },
          ),


          _buildMenuItem(
            context,
            title: 'App Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AppSettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _buildMenuItem(BuildContext context, {required String title, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A237E),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Color(0xFF1A237E),
          ),
          onTap: onTap,
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Colors.black12,
        ),
      ],
    );
  }
}




