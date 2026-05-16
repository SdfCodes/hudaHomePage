import 'package:flutter/material.dart';
import 'package:huda_home_page/huda_student_theme.dart';
import 'package:huda_home_page/models/course.dart';

import '../headerdesig.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {

  bool _cellularDataForDownloads = true;
  String _selectedVideoQuality = "Standard";
  bool _deleteCompletedLessons = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: HeaderDesign(
        title: "App Settings",

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: HudaStudentTheme.ink, size: 24),
          onPressed: () => Navigator.pop(context),
        ),

        children: [

          _buildSectionHeader(theme, "Cellular Data"),
          _buildSwitchTile(
            title: "Cellular Data for Downloads",
            value: _cellularDataForDownloads,
            onChanged: (val) {
              setState(() => _cellularDataForDownloads = val);
            },
          ),
          const Divider(height: 1, indent: 5, endIndent: 5),


          _buildSectionHeader(theme, "Video Quality For Downloads"),
          _buildRadioTile(
            title: "Standard (recommended)",
            subtitle: "Downloads faster and uses less storage",
            isSelected: _selectedVideoQuality == "Standard",
            onTap: () => setState(() => _selectedVideoQuality = "Standard"),
            theme: theme,
          ),
          const Divider(height: 1, indent: 5, endIndent: 5),
          _buildRadioTile(
            title: "High Definition",
            subtitle: "Use more storage",
            isSelected: _selectedVideoQuality == "High",
            onTap: () => setState(() => _selectedVideoQuality = "High"),
            theme: theme,
          ),
          const Divider(height: 1, indent: 5, endIndent: 5),


          _buildSectionHeader(theme, "Offline Downloads"),
          _buildRadioTile(
            title: "Delete Completed Lessons",
            subtitle: "Lessons can automatically delete 24 hours after they are watched in full.",
            isSelected: _deleteCompletedLessons,
            onTap: () => setState(() => _deleteCompletedLessons = !_deleteCompletedLessons),
            theme: theme,
          ),
          const Divider(height: 1, indent: 5, endIndent: 5),


          _buildDeleteAllTile(theme),
        ],
      ),
    );
  }


  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }


  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: HudaStudentTheme.ink),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: HudaStudentTheme.brand,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }


  Widget _buildRadioTile({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: HudaStudentTheme.ink),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: HudaStudentTheme.ink,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }


  Widget _buildDeleteAllTile(ThemeData theme) {

    bool hasDownloads = Course.demoCourses.isNotEmpty;

    return InkWell(
      onTap: () {
        if (hasDownloads) {

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Delete All Downloads?"),
              content: Text("Are you sure you want to remove all ${Course.demoCourses.length} downloaded videos from your phone?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);

                    setState(() {
                      Course.demoCourses.clear();
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("All downloads removed successfully."),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text("Delete", style: TextStyle(color: HudaStudentTheme.danger)),
                ),
              ],
            ),
          );
        } else {

          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const Text(
                      "Nothing to delete",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:HudaStudentTheme.danger,
                      ),
                    ),
                    const SizedBox(height: 20),


                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 95,
                          height: 65,
                          decoration: BoxDecoration(
                            border: Border.all(color: HudaStudentTheme.brand.withValues(alpha: 0.7), width: 2.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            width: 45,
                            height: 5,
                            decoration: BoxDecoration(
                              color: HudaStudentTheme.brand,
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(4)),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.cloud_off_outlined,
                          size: 28,
                          color: HudaStudentTheme.brand.withValues(alpha: 0.6),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Text(
                      "There are no downloaded lessons on\nyour device.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),


                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HudaStudentTheme.brand,
                          foregroundColor: HudaStudentTheme.ink,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Okay",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Delete All Downloads",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "This will remove all downloaded Lesson videos from your phone.",
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.delete_forever, color: HudaStudentTheme.danger, size: 20),
            )
          ],
        ),
      ),
    );
  }


}
