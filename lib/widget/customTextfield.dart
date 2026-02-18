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
          height: 50,
          width: 370,
          decoration: BoxDecoration(
            color: Colors.grey.shade400.withAlpha(40),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(icon, color: Colors.purple.shade600),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboard,
                  obscureText: obscure,
                  cursorColor: Colors.purple,
                  maxLength: maxLength,
                  onChanged: onChanged,
                  validator: validator,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
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
      SizedBox(height: 18),
    ],
  );
}
