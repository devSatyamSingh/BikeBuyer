import 'package:flutter/material.dart';

class TermsCondPage extends StatefulWidget {
  const TermsCondPage({super.key});

  @override
  State<TermsCondPage> createState() => _TermsCondPageState();
}

class _TermsCondPageState extends State<TermsCondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Terms & Condition')),
    );
  }
}
