import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../huda_student_theme.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: HudaStudentTheme.ink),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGetAllAccessButton(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildGetAllAccessButton(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {

            showDialog(
              context: context,
              builder: (context) => const DynamicPaymentDialog(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: HudaStudentTheme.brand,
            foregroundColor: HudaStudentTheme.ink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Get All-Access",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}


class DynamicPaymentDialog extends StatefulWidget {
  const DynamicPaymentDialog({super.key});

  @override
  State<DynamicPaymentDialog> createState() => _DynamicPaymentDialogState();
}

class _DynamicPaymentDialogState extends State<DynamicPaymentDialog> {
  int step = 1;
  final TextEditingController _nameController = TextEditingController(text: "DANIEL KELLER");
  final TextEditingController _numberController = TextEditingController(text: "2045 67");
  final TextEditingController _dateController = TextEditingController(text: "08/20");
  final TextEditingController _cvcController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _dateController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _buildCurrentStep(theme),
            ),
          ),

          Positioned(
            top: 12,
            left: 12,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey.shade400, size: 18),
              onPressed: () {
                if (step > 1) {
                  setState(() => step--);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep(ThemeData theme) {
    switch (step) {
      case 1:
        return _stepNoPaymentMethod(theme);
      case 2:
        return _stepChoosePaymentMethod(theme);
      case 3:
        return _stepAddNewCard(theme);
      default:
        return _stepNoPaymentMethod(theme);
    }
  }

  Widget _stepNoPaymentMethod(ThemeData theme) {
    return Column(
      key: const ValueKey(1),
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Text(
          "You don’t have any payment method",
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E1B4B),
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 28),
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: -0.1,
              child: Container(
                width: 95,
                height: 62,
                decoration: BoxDecoration(
                  border: Border.all(color: HudaStudentTheme.brand.withValues(alpha: 0.6), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Container(
              width: 100,
              height: 65,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: HudaStudentTheme.brand, width: 2.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 25, height: 3, color: HudaStudentTheme.brand),
                  const SizedBox(height: 6),
                  Container(width: 50, height: 2, color: HudaStudentTheme.brand.withValues(alpha: 0.5)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Text(
          "There is no payment method added to\nyour account.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 32),
        _buildActionButton("Add New Payment Method", () {
          setState(() => step = 2);
        }),
      ],
    );
  }

  Widget _stepChoosePaymentMethod(ThemeData theme) {
    return Column(
      key: const ValueKey(2),
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        const Text(
          "Choose payment method",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B)),
        ),
        const SizedBox(height: 24),
        _buildPaymentOptionTile(
          icon: const Icon(Icons.apple, color: Colors.black, size: 22),
          title: "Apple Pay",
          subtitle: "****ller234@gmail.com",
          onTap: () {},
        ),
        _buildPaymentOptionTile(
          icon: const Icon(Icons.paypal, color: Colors.blue, size: 22),
          title: "PayPal",
          subtitle: "****ller234@gmail.com",
          onTap: () {},
        ),

        _buildPaymentOptionTile(
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 14, height: 14, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red)),
              Transform.translate(
                offset: const Offset(-6, 0),
                child: Container(width: 14, height: 14, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange.shade600.withValues(alpha: 0.85))),
              ),
            ],
          ),
          title: "Mastercard",
          subtitle: "****  6758",
          onTap: () {
            setState(() => step = 3);
          },
        ),
        _buildPaymentOptionTile(
          icon: const Text("VISA", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13)),
          title: "Visa",
          subtitle: "****  8765",
          onTap: () {},
        ),
        const SizedBox(height: 16),
        _buildActionButton("Add New Payment Method", () {
          setState(() => step = 3);
        }),
      ],
    );
  }


  Widget _stepAddNewCard(ThemeData theme) {
    return SingleChildScrollView(
      key: const ValueKey(3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          ListenableBuilder(
            listenable: ListValues([_nameController, _numberController, _dateController]),
            builder: (context, child) => Container(
              width: double.infinity,
              height: 165,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF222222),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(width: 18, height: 18, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red)),
                          Transform.translate(
                            offset: const Offset(-8, 0),
                            child: Container(width: 18, height: 18, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFBCD6A))),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFFBCD6A), width: 1.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _numberController.text.isEmpty ? "•••• •••• •••• ••••" : _numberController.text,
                      style: const TextStyle(color: Color(0xFFFBCD6A), fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1.5),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _nameController.text.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("VALID THRU", style: TextStyle(color: Colors.grey, fontSize: 6, fontWeight: FontWeight.bold)),
                          Text(
                            _dateController.text.isEmpty ? "00/00" : _dateController.text,
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          _buildTextField("Name on card", _nameController),
          _buildTextField("Card number", _numberController),
          Row(
            children: [
              Expanded(child: _buildTextField("Valid until (MM/YY)", _dateController)),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField("CVC", _cvcController, isObscure: true)),
            ],
          ),
          const SizedBox(height: 20),
          _buildActionButton("Add New Card", () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Card Added Successfully!")),
            );
          }),
        ],
      ),
    );
  }


  Widget _buildPaymentOptionTile({required Widget icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 45,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(4),
          ),
          child: icon,
        ),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
        trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade500)),
          TextField(
            controller: controller,
            obscureText: isObscure,
            onChanged: (val) => setState(() {}),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B)),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HudaStudentTheme.brand, width: 2)),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: HudaStudentTheme.brand,
          foregroundColor: HudaStudentTheme.ink,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class ListValues extends ChangeNotifier {
  ListValues(List<ChangeNotifier> listenables) {
    for (final listenable in listenables) {
      listenable.addListener(notifyListeners);
    }
  }
}
