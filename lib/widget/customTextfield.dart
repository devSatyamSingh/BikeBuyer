import 'package:flutter/material.dart';

Widget satyamField({
  required String label,
  required String hint,
  required IconData icon,
  required TextEditingController controller,
  TextInputType keyboard = TextInputType.text,
  bool obscure = false,
  int? maxLength,
  Widget? suffix,
  bool requiredField = true,

  Function(String)? onChanged,
  String? Function(String?)? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 28),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(height: 6),
      Center(
        child: Container(
          height: 52,
          width: 375,
          decoration: BoxDecoration(
            color: Colors.grey.shade400.withAlpha(40),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(icon, color: Colors.cyanAccent.shade700),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboard,
                  obscureText: obscure,
                  cursorColor: Colors.cyan,
                  maxLength: maxLength,
                  onChanged: onChanged,
                  validator: validator,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    counterText: "",
                    suffixIcon: suffix,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 22),
    ],
  );
}
