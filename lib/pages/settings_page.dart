import 'package:flutter/material.dart';
import 'package:huda_home_page/models/course.dart';
import 'package:huda_home_page/huda_student_theme.dart';
import 'package:huda_home_page/pages/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedCategory = "Culinary";


  final List<Course> yourClasses = Course.demoCourses;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayedClasses = yourClasses.where((course) {
      return course.tags.any(
            (tag) =>
        tag.toLowerCase() ==
            selectedCategory.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            _buildHeader(theme),

            const SizedBox(height: 40),

            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                "Favorites",
                style: theme
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 18),

            _buildFavorites(theme),

            const SizedBox(height: 32),

            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                "Your Classes",
                style: theme
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 14),

            _buildCategoryRow(theme),

            const SizedBox(height: 10),

            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Column(
                children:
                displayedClasses.isEmpty
                    ? [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 30,
                    ),

                    child: Text(
                      "No classes found",
                      style:
                      theme.textTheme.bodyMedium,
                    ),
                  ),
                ]
                    : displayedClasses
                    .map(
                      (course) =>
                      _buildClassCard(
                        course,
                        theme,
                      ),
                )
                    .toList(),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return GestureDetector(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 220,

            decoration: const BoxDecoration(
              color: HudaStudentTheme.brand,
            ),

            child: Stack(
              children: [
                Positioned(
                  right: -90,
                  top: -40,

                  child: Container(
                    width: 280,
                    height: 280,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(
                        alpha: 0.18,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 190,
                  top: 140,

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Capidesign",
                        style: theme
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          fontWeight:
                          FontWeight.w700,
                          color:
                          HudaStudentTheme
                              .ink,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        "All-Access",
                        style: theme
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                          color:
                          HudaStudentTheme
                              .ink,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 40,
            bottom: -30,

            child: Container(
              width: 130,
              height: 130,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
                border: Border.all(
                  color: Colors.white,
                  width: 6,
                ),

                image: const DecorationImage(
                  image: NetworkImage(
                    "https://picsum.photos/300",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavorites(ThemeData theme) {
    final favorites = [
      {
        "name": "Shonda Rhimes",
        "desc":
        "Shonda describes what fuels her passion.",
      },

      {
        "name": "Dr. Jane Goodall",
        "desc":
        "Jane Goodall shows what fuels her passion.",
      },
    ];

    return SizedBox(
      height: 250,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),

        itemCount: favorites.length,

        itemBuilder: (context, index) {
          final item = favorites[index];

          return Container(
            width: 220,

            margin: const EdgeInsets.symmetric(
              horizontal: 6,
            ),

            child: Card(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.only(
                        topLeft:
                        Radius.circular(10),
                        topRight:
                        Radius.circular(10),
                      ),

                      child: Image.network(
                        "https://picsum.photos/300/200?random=$index",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                    const EdgeInsets.all(14),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Text(
                          item["name"]!,
                          style: theme
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          item["desc"]!,
                          maxLines: 2,
                          overflow:
                          TextOverflow.ellipsis,
                          style:
                          theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryRow(ThemeData theme) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemCount: Course.categories.length,

        itemBuilder: (context, index) {
          final cat = Course.categories[index];

          final isSelected = selectedCategory == cat;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = cat;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: isSelected
                    ? HudaStudentTheme.brand
                    : theme.cardColor,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : HudaStudentTheme.stroke,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                cat,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? HudaStudentTheme.ink
                      : theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildClassCard(
      Course course,
      ThemeData theme,
      ) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            ClipRRect(
              borderRadius:
              BorderRadius.circular(12),

              child: Image.network(
                course.imageURL,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 14),

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
                          style: theme
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(
                        "\$${course.price}",
                        style: theme
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color:
                          HudaStudentTheme
                              .danger,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    course.title,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    course.description,
                    maxLines: 2,
                    overflow:
                    TextOverflow.ellipsis,
                    style:
                    theme.textTheme.bodySmall,
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(
                            index <
                                course.rating
                                    .round()
                                ? Icons.star
                                : Icons.star_border,

                            color:
                            HudaStudentTheme
                                .warning,

                            size: 16,
                          ),
                        ),
                      ),

                      Text(
                        "${course.reviewCount} reviews",

                        style: theme
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          fontWeight:
                          FontWeight.w600,
                        ),
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
}