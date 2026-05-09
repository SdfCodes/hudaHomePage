import 'package:flutter/material.dart';
import 'package:huda_home_page/headerdesig.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          HeaderDesign(
            title: "",
            children: [
              const SizedBox(height: 60),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Popular Tags",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2E2E48),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTag("Business & Management"),
              _buildTag("Creative Art & Media"),
              _buildTag("Health & Psychology"),
              _buildTag("History"),
              _buildTag("Languages and Cultures"),
              _buildTag("Science, Engineering & Maths"),
              _buildTag("Study Skills"),
              _buildTag("Tech & Coding"),
            ],
          ),

          Positioned(
            top: 140,
            left: 20,
            right: 20,
            child: Material(
              elevation: 8,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(35),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Try "Easy ways write a novel"',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                  prefixIcon: const Icon(Icons.search, color: Color(0xff2E2E48), size: 28),

                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xff2E2E48), size: 28),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildTag(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xff44446A),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Divider(thickness: 0.8, color: Color(0xffE6E6F2), height: 1),
        ],
      ),
    );
  }
}
