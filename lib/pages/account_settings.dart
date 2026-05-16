import 'package:flutter/material.dart';
import 'package:huda_home_page/headerdesig.dart';
import 'package:huda_home_page/huda_student_theme.dart';
import 'package:huda_home_page/models/course.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {

  final List<Map<String, dynamic>> localProfileData = Course.profileData;

  void _updateValue(String key, String newValue) {
    setState(() {
      final index = localProfileData.indexWhere((element) => element["key"] == key);
      if (index != -1 && newValue.trim().isNotEmpty) {
        localProfileData[index]["value"] = newValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: HeaderDesign(
        title: "Account Settings",
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 22, color: HudaStudentTheme.ink),
          onPressed: () => Navigator.of(context).pop(),
        ),
        children: [
          const SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Capidesign",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: HudaStudentTheme.ink,
                    fontSize: 26,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Edit Profile",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: HudaStudentTheme.inkMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),


          _buildSettingItem(
            theme: theme,
            title: localProfileData[0]["title"],
            value: localProfileData[0]["value"],
            onEditTap: () => _showPhoneEditDialog(context, localProfileData[0]["value"]),
          ),

          _buildSettingItem(
            theme: theme,
            title: localProfileData[1]["title"],
            value: localProfileData[1]["value"],
            onEditTap: () => _showEmailEditDialog(context, localProfileData[1]["value"]),
          ),

          _buildSettingItem(
            theme: theme,
            title: localProfileData[2]["title"],
            value: localProfileData[2]["value"],
            isPassword: true,
            onEditTap: () => _showPasswordEditDialog(context),
          ),

          const SizedBox(height: 32),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: HudaStudentTheme.danger,
                ),
                child: Text(
                  "Log out",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HudaStudentTheme.danger,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(
                color: HudaStudentTheme.danger,
                thickness: 1.2,
                indent: 8,
                endIndent: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required ThemeData theme,
    required String title,
    required String value,
    required VoidCallback onEditTap,
    bool isPassword = false,
  }) {
    final displayValue = isPassword ? "••••••" : value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: HudaStudentTheme.ink, fontSize: 18)),
                    const SizedBox(height: 6),
                    Text(displayValue, style: theme.textTheme.bodyMedium?.copyWith(color: HudaStudentTheme.inkMuted, fontSize: 15, letterSpacing: isPassword ? 4 : 0)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Color(0xFFD0D4EC), size: 24),
                onPressed: onEditTap,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFE6E8F6), thickness: 1),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  void _showPhoneEditDialog(BuildContext context, String currentPhone) {
    final theme = Theme.of(context);
    final controller = TextEditingController(text: currentPhone.replaceAll('+', '').trim());
    String? phoneError;
    final phoneRegex = RegExp(r'^[0-9]+$');

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            backgroundColor: theme.cardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Change phone number", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: HudaStudentTheme.ink, fontSize: 18)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: HudaStudentTheme.ink),
                    onChanged: (text) {
                      setDialogState(() {
                        if (text.isEmpty) {
                          phoneError = "Field cannot be empty";
                        } else if (!phoneRegex.hasMatch(text)) {
                          phoneError = "Only digits are allowed";
                        } else {
                          phoneError = null;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      errorText: phoneError,
                      errorStyle: const TextStyle(color: HudaStudentTheme.danger, fontWeight: FontWeight.w600),
                      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE2E4F0), width: 1.2)),
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: HudaStudentTheme.accent, width: 1.5)),
                      errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: HudaStudentTheme.danger, width: 1.5)),
                      focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: HudaStudentTheme.danger, width: 1.8)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildDialogButtons(
                    context,
                    phoneError == null && controller.text.isNotEmpty
                        ? () {
                      _updateValue("phone", "+${controller.text.trim()}");
                      Navigator.of(context).pop();
                    }
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEmailEditDialog(BuildContext context, String currentEmail) {
    final theme = Theme.of(context);
    final controller = TextEditingController(text: currentEmail);
    String? emailError;

    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            backgroundColor: theme.cardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Change email address", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: HudaStudentTheme.ink, fontSize: 18)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: HudaStudentTheme.ink),
                    onChanged: (text) {
                      setDialogState(() {
                        if (text.isEmpty) {
                          emailError = "Field cannot be empty";
                        } else if (!emailRegex.hasMatch(text.trim())) {
                          emailError = "Invalid email structure";
                        } else {
                          emailError = null;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      errorText: emailError,
                      errorStyle: const TextStyle(color: HudaStudentTheme.danger, fontWeight: FontWeight.w600),
                      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE2E4F0), width: 1.2)),
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: HudaStudentTheme.accent, width: 1.5)),
                      errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: HudaStudentTheme.danger, width: 1.5)),
                      focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: HudaStudentTheme.danger, width: 1.8)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildDialogButtons(
                    context,
                    emailError == null && controller.text.isNotEmpty
                        ? () {
                      _updateValue("email", controller.text.trim());
                      Navigator.of(context).pop();
                    }
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPasswordEditDialog(BuildContext context) {
    final theme = Theme.of(context);
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    bool isOldObscured = true;
    bool isNewObscured = true;
    bool isConfirmObscured = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: theme.cardColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Change your password", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: HudaStudentTheme.ink, fontSize: 18)),
                    const SizedBox(height: 24),
                    _buildPasswordField("Old password", oldPasswordController, isOldObscured, () {
                      setDialogState(() => isOldObscured = !isOldObscured);
                    }),
                    const SizedBox(height: 16),
                    _buildPasswordField("New password", newPasswordController, isNewObscured, () {
                      setDialogState(() => isNewObscured = !isNewObscured);
                    }),
                    const SizedBox(height: 16),
                    _buildPasswordField("Confirm new password", confirmPasswordController, isConfirmObscured, () {
                      setDialogState(() => isConfirmObscured = !isConfirmObscured);
                    }),
                    const SizedBox(height: 32),
                    _buildDialogButtons(
                      context,
                      newPasswordController.text == confirmPasswordController.text && newPasswordController.text.isNotEmpty
                          ? () {
                        _updateValue("password", newPasswordController.text);
                        Navigator.of(context).pop();
                      }
                          : null,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPasswordField(String hint, TextEditingController controller, bool isObscured, VoidCallback onEyeTap) {
    return TextField(
      controller: controller,
      obscureText: isObscured,
      style: const TextStyle(color: HudaStudentTheme.ink),
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE2E4F0), width: 1.2)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: HudaStudentTheme.accent, width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        suffixIcon: IconButton(
          icon: Icon(isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFFD0D4EC), size: 22),
          onPressed: onEyeTap,
        ),
      ),
    );
  }

  Widget _buildDialogButtons(BuildContext context, VoidCallback? onOkayTap) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: const Color(0xFFF0F0F2), borderRadius: BorderRadius.circular(10)),
              child: const Text("Cancel", style: TextStyle(color: HudaStudentTheme.ink, fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: onOkayTap,
            child: Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: onOkayTap == null ? HudaStudentTheme.brand.withValues(alpha: 0.4) : HudaStudentTheme.brand,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Okay",
                style: TextStyle(
                  color: onOkayTap == null ? HudaStudentTheme.ink.withValues(alpha: 0.4) : HudaStudentTheme.ink,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );

  }
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Text(
                  "Are you sure you want to log out?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: HudaStudentTheme.ink,
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F0F2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HudaStudentTheme.ink,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();

                        /*
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()),
                        );
                        */
                        },
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: HudaStudentTheme.brand,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Log out",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
}
