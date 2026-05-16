import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../headerdesig.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {

  bool _appReminders = true;
  bool _emailReminders = false;
  int _selectedFrequency = 1;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);


  void _showTimePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        Duration tempDuration = Duration(hours: _selectedTime.hour, minutes: _selectedTime.minute);
        final theme = Theme.of(context);

        return Center(
          child: Container(
            width: 320,
            height: 260,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                Expanded(
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      brightness: theme.brightness,
                      textTheme: CupertinoTextThemeData(
                        pickerTextStyle: theme.textTheme.titleMedium?.copyWith(
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hm,
                      initialTimerDuration: tempDuration,
                      onTimerDurationChanged: (Duration newDuration) {
                        tempDuration = newDuration;
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedTime = TimeOfDay(
                          hour: tempDuration.inHours,
                          minute: tempDuration.inMinutes % 60,
                        );
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Confirm',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: HeaderDesign(
        title: 'Reminders',
        children: [

          _buildSectionTitle(context, 'Reminders'),
          _buildSwitchTile(
            context,
            title: 'App Reminders',
            value: _appReminders,
            onChanged: (val) => setState(() => _appReminders = val),
          ),
          _buildSwitchTile(
            context,
            title: 'Email Reminders',
            value: _emailReminders,
            onChanged: (val) => setState(() => _emailReminders = val),
          ),

          const SizedBox(height: 24),


          _buildSectionTitle(context, 'Frequency'),
          _buildCheckTile(
            context,
            title: 'Weekdays',
            isSelected: _selectedFrequency == 0,
            onTap: () => setState(() => _selectedFrequency = 0),
          ),
          _buildCheckTile(
            context,
            title: 'Weekends',
            isSelected: _selectedFrequency == 1,
            onTap: () => setState(() => _selectedFrequency = 1),
          ),

          const SizedBox(height: 24),


          _buildSectionTitle(context, 'Time of day'),
          _buildTimeTile(
            context,
            timeText: _formatTimeOfDay(_selectedTime),
            onTap: () => _showTimePicker(context),
          ),
        ],
      ),
    );
  }


  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, top: 4.0, left: 4.0),
      child: Text(
        title,
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildSwitchTile(BuildContext context, {required String title, required bool value, required ValueChanged<bool> onChanged}) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.12), width: 1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        trailing: CupertinoSwitch(
          activeColor: theme.colorScheme.primary,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }


  Widget _buildCheckTile(BuildContext context, {required String title, required bool isSelected, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.12), width: 1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        onTap: onTap,
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check, color: theme.colorScheme.onSurface, size: 22)
            : const SizedBox.shrink(),
      ),
    );
  }


  Widget _buildTimeTile(BuildContext context, {required String timeText, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.12), width: 1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        onTap: onTap,
        title: Text(
          timeText,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        trailing: Icon(
          Icons.edit_outlined,
          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
          size: 20,
        ),
      ),
    );
  }
}
