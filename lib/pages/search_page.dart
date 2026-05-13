import 'package:flutter/material.dart';
import 'package:huda_home_page/headerdesig.dart';

class Course {
  final String title, instructor, price, videoCount;
  final List<String> tags;
  Course({required this.title, required this.instructor, required this.price, required this.videoCount, required this.tags});
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isSearching = false;
  List<Course> filteredResults = [];


  final List<Course> allCourses = [
    Course(instructor: "Gordon Ramsay", title: "Teaches cooking I: Cooking is not easy", price: "\$49.99", videoCount: "12 videos", tags: ["Art", "Culinary", "Science", "Cooking"]),
    Course(instructor: "Gordon Ramsay", title: "Teaches cooking II: Restaurant recipes", price: "\$89.99", videoCount: "12 videos", tags: ["Art", "Culinary", "Cooking"]),
    Course(instructor: "Alice Waters", title: "Art of Home cooking", price: "\$29.99", videoCount: "10 videos", tags: ["Art", "Culinary", "Cooking"]),
    Course(instructor: "John Doe", title: "Business & Management Basics", price: "\$39.99", videoCount: "15 videos", tags: ["Business & Management"]),
    Course(instructor: "Sarah Art", title: "Creative Art & Media Guide", price: "\$45.00", videoCount: "18 videos", tags: ["Creative Art & Media"]),
    Course(instructor: "Tech Expert", title: "Tech & Coding Masterclass", price: "\$59.99", videoCount: "20 videos", tags: ["Tech & Coding"]),
    Course(instructor: "Dr. Smith", title: "Health & Psychology 101", price: "\$35.00", videoCount: "14 videos", tags: ["Health & Psychology"]),
  ];

  void _runSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        isSearching = false;
        filteredResults = [];
      } else {
        isSearching = true;

        filteredResults = allCourses.where((c) =>
        c.title.toLowerCase().contains(query.toLowerCase()) ||
            c.instructor.toLowerCase().contains(query.toLowerCase()) ||
            c.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()))
        ).toList();
      }
    });
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
              if (!isSearching) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Popular Tags", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xff2E2E48))),
                ),
                const SizedBox(height: 20),
                _buildTag("Cooking"),
                _buildTag("Business & Management"),
                _buildTag("Creative Art & Media"),
                _buildTag("Health & Psychology"),
                _buildTag("Tech & Coding"),
                _buildTag("Languages and Cultures"),
                _buildTag("Science, Engineering & Maths"),
              ] else ...[

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("There are ${filteredResults.length} classes founded",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff2E2E48))),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          _controller.clear();
                          _runSearch("");
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                ...filteredResults.map((course) => _buildCourseCard(course)).toList(),
                const SizedBox(height: 100),
              ],
            ],
          ),


          Positioned(
            top: 130, left: 40, right: 40,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(45),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                onChanged: _runSearch,
                onSubmitted: _runSearch,
                decoration: InputDecoration(
                  hintText: 'Try "Easy ways write a novel"',
                  prefixIcon: const Icon(Icons.search, color: Colors.black87, size: 28),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(35), borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 85, height: 85,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(course.instructor, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(course.price, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(course.title, style: const TextStyle(color: Colors.grey, fontSize: 12), maxLines: 2),
                const SizedBox(height: 8),
                Text("• ${course.tags.join(' • ')}", style: const TextStyle(fontSize: 10, color: Colors.blueGrey)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(children: [Icon(Icons.star, color: Colors.orange, size: 14), Icon(Icons.star, color: Colors.orange, size: 14), Icon(Icons.star, color: Colors.orange, size: 14)]),
                    Text(course.videoCount, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String title) {
    return InkWell(
      onTap: () {
        _controller.text = title;
        _runSearch(title);
        _focusNode.unfocus();
      },
      child: Padding(
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
      ),
    );
  }
}
