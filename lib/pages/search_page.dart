import 'package:flutter/material.dart';
import 'package:huda_home_page/headerdesig.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isSearching = false;
  bool isFocused = false;


  final List<String> allSuggestions = [
    "Cooking lessons",
    "Cooking Art",
    "Cooking at home",
    "Cooking a good meal",
    "Business Management",
    "Creative Writing",
    "Health and Psychology",
    "History of Art",
    "Tech and Coding",
  ];


  List<String> filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }


  void _filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        filteredSuggestions = [];
      });
    } else {
      setState(() {
        isSearching = true;

        filteredSuggestions = allSuggestions
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          HeaderDesign(
            title: "",
            children: [
              const SizedBox(height: 20),
              if (isFocused && !isSearching) ...[
                const SizedBox(height: 50),
                Center(
                  child: Column(
                    children: [
                      Icon(Icons.search, size: 120, color: Colors.yellow.withOpacity(0.3)),
                      const SizedBox(height: 20),
                      const Text(
                        "Search what you want to learn.",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ] else if (!isFocused) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Popular Tags",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xff2E2E48)),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTag("Business & Management"),
                _buildTag("Creative Art & Media"),
                _buildTag("Health & Psychology"),
                _buildTag("History"),
                _buildTag("Languages and Cultures "),
                _buildTag("Science, Engineering & Maths"),
                _buildTag("Study Skills"),
                _buildTag("Tech & Cooding"),
              ],
            ],
          ),

          Positioned(
            top: 130,
            left: 40,
            right: 40,
            child: Material(
              elevation: 8,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(45),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(55),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      onChanged: _filterSearch,
                      decoration: InputDecoration(
                        hintText: 'Try "Easy ways write a novel"',
                        hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
                        prefixIcon: const Icon(Icons.search, color: Colors.black87, size: 28),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    if (isSearching && filteredSuggestions.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          children: filteredSuggestions
                              .map((text) => ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                            title: Text(text, style: const TextStyle(color: Colors.black54)),
                            onTap: () {
                              _controller.text = text;
                              _focusNode.unfocus();
                              setState(() { isSearching = false; });
                            },
                          ))
                              .toList(),
                        ),
                      ),
                  ],
                ),
              ),
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
            child: Text(title, style: const TextStyle(fontSize: 18, color: Color(0xff44446A))),
          ),
          const Divider(thickness: 0.8, color: Color(0xffE6E6F2)),
        ],
      ),
    );
  }
}
