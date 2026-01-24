import 'package:flutter/material.dart';

class Finddealerpage extends StatefulWidget {
  const Finddealerpage({super.key});

  @override
  State<Finddealerpage> createState() => _FinddealerpageState();
}

class _FinddealerpageState extends State<Finddealerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Find Dealer"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
    );
  }
}
