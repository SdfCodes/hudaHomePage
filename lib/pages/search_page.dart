import 'package:flutter/material.dart';
import 'package:huda_home_page/headerdesig.dart';
import 'package:huda_home_page/models/course.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool isSearching = false;
  String selectedCategory = "";

  List<Course> filteredResults = [];

  final List<String> categories = Course.categories;
  final List<Course> allCourses = Course.demoCourses;

  void _runSearch(String query) {
    setState(() {
      if (query.isEmpty && selectedCategory.isEmpty) {
        isSearching = false;
        filteredResults = [];
      } else {
        isSearching = true;

        filteredResults = allCourses.where((course) {
          final matchesQuery =
              query.isEmpty ||
                  course.title.toLowerCase().contains(query.toLowerCase()) ||
                  course.instructor.toLowerCase().contains(query.toLowerCase()) ||
                  course.tags.any(
                        (tag) => tag.toLowerCase().contains(query.toLowerCase()),
                  );

          final matchesCategory =
              selectedCategory.isEmpty ||
                  course.tags.any(
                        (tag) =>
                    tag.toLowerCase() ==
                        selectedCategory.toLowerCase(),
                  );

          return matchesQuery && matchesCategory;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          HeaderDesign(
            title: "",
            children: [
              const SizedBox(height: 10),

              if (isSearching) _buildCategoryRow(theme),

              if (!isSearching) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Popular Tags",
                    style: theme.textTheme.headlineSmall,
                  ),
                ),

                const SizedBox(height: 12),

                _buildTag("Cooking", theme),
                _buildTag("Business & Management", theme),
                _buildTag("Creative Art & Media", theme),
                _buildTag("Health & Psychology", theme),
                _buildTag("Tech & Coding", theme),
                _buildTag("Languages and Cultures", theme),
                _buildTag("Science, Engineering & Maths", theme),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "There are ${filteredResults.length} classes found",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                        ),
                        onPressed: () {
                          _controller.clear();
                          selectedCategory = "";
                          _runSearch("");
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                ...filteredResults
                    .map(
                      (course) =>
                      _buildCourseCard(course, theme),
                )
                    .toList(),

                const SizedBox(height: 100),
              ],
            ],
          ),

          Positioned(
            top: 130,
            left: 30,
            right: 30,
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(18),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                onChanged: _runSearch,
                onSubmitted: _runSearch,
                decoration: const InputDecoration(
                  hintText: 'Search courses',
                  prefixIcon: Icon(Icons.search, size: 26),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(ThemeData theme) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];

          final isSelected =
              selectedCategory.toLowerCase() ==
                  cat.toLowerCase();

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory =
                isSelected ? "" : cat;

                _runSearch(_controller.text);
              });
            },

            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 8,
              ),

              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 2,
              ),

              decoration: BoxDecoration(
                color:
                isSelected
                    ? theme.colorScheme.primary
                    : Colors.transparent,

                borderRadius: BorderRadius.circular(20),

                border: Border.all(
                  color:
                  isSelected
                      ? Colors.transparent
                      : theme.colorScheme.onSurface
                      .withValues(alpha: 0.15),
                ),
              ),

              alignment: Alignment.center,

              child: Text(
                cat,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                  isSelected
                      ? theme.colorScheme.onPrimary
                      : theme
                      .textTheme
                      .bodyMedium
                      ?.color,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseCard(
      Course course,
      ThemeData theme,
      ) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),

              child: Image.network(
                course.imageURL,
                width: 85,
                height: 85,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          course.instructor,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontSize: 15),
                        ),
                      ),

                      Text(
                        "\$${course.price}",
                        style: theme.textTheme.titleMedium
                            ?.copyWith(
                          color:
                          theme.colorScheme.error,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    course.title,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    course.description,
                    style: theme.textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "• ${course.tags.join(' • ')}",
                    style: theme.textTheme.bodySmall
                        ?.copyWith(
                      color: theme
                          .colorScheme
                          .secondary
                          .withValues(alpha: 0.8),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(
                            index < course.rating.round()
                                ? Icons.star
                                : Icons.star_border,
                            color: const Color(0xFFF79009),
                            size: 14,
                          ),
                        ),
                      ),

                      Text(
                        "${course.reviewCount} reviews",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(
      String title,
      ThemeData theme,
      ) {
    return InkWell(
      onTap: () {
        _controller.text = title;

        _runSearch(title);

        _focusNode.unfocus();
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),

              child: Text(
                title,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(
                  color: theme
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.8),
                ),
              ),
            ),

            const Divider(),
          ],
        ),
      ),
    );
  }
}