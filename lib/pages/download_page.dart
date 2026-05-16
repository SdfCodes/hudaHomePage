import 'package:flutter/material.dart';
import 'package:huda_home_page/huda_student_theme.dart';
import 'package:huda_home_page/models/course.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {

  bool showDownloadedClasses = false;


  final List<Course> downloadedCourses = List.from(Course.demoCourses);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [

          _buildDownloadsHeader(theme),

          Expanded(
            child: showDownloadedClasses
                ? _buildClassesList(theme, downloadedCourses)
                : _buildEmptyState(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: HudaStudentTheme.brand.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
              const Icon(
                Icons.description_outlined,
                size: 70,
                color: HudaStudentTheme.brand,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            "Your downloaded classes and lessons will show up here.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: HudaStudentTheme.inkMuted,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () {
              setState(() {
                showDownloadedClasses = true;
              });
            },
            style: FilledButton.styleFrom(
              backgroundColor: HudaStudentTheme.brand,
              foregroundColor: HudaStudentTheme.ink,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text("Explore Classes"),
          ),
        ],
      ),
    );
  }

  Widget _buildClassesList(ThemeData theme, List<Course> coursesList) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: coursesList.length,
      itemBuilder: (context, index) {
        final course = coursesList[index];

        return Dismissible(
          key: Key(course.title + course.instructor + index.toString()),
          direction: DismissDirection.endToStart,


          confirmDismiss: (direction) async {
            return await _showDeleteConfirmationDialog(context, course.instructor);
          },


          onDismissed: (direction) {
            setState(() {
              coursesList.removeAt(index);
            });
          },


          background: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            child: const Text(
              "Delete",
              style: TextStyle(
                color: HudaStudentTheme.danger,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 1,
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
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 85,
                        height: 85,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),


                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.instructor,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: HudaStudentTheme.ink,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          course.title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: HudaStudentTheme.inkMuted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              children: List.generate(
                                5,
                                    (idx) => Icon(
                                  idx < course.rating.round() ? Icons.star : Icons.star_border,
                                  color: HudaStudentTheme.warning,
                                  size: 16,
                                ),
                              ),
                            ),

                            Text(
                              "${index == 0 ? '20' : index == 1 ? '3' : index == 2 ? '0' : '15'}/${course.reviewCount} videos",
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: HudaStudentTheme.ink,
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
          ),
        );
      },
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context, String instructorName) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: HudaStudentTheme.ink,
                      fontFamily: 'Inter',
                    ),
                    children: [
                      const TextSpan(text: "You want to delete "),
                      TextSpan(
                        text: "$instructorName’s class ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: "?"),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F0F2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: HudaStudentTheme.ink,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(true),
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: HudaStudentTheme.danger,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

 Widget _buildDownloadsHeader(ThemeData theme) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
        color: HudaStudentTheme.brand,
      ),
      child: Stack(
        children: [
          Positioned(
            right: -80,
            top: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 32, bottom: 36),
              child: Text(
                "Downloads",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: HudaStudentTheme.ink,
                  fontSize: 34,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
