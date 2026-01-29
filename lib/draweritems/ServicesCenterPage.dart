import 'package:flutter/material.dart';

class ServicesCenterPage extends StatefulWidget {
  const ServicesCenterPage({super.key});

  @override
  State<ServicesCenterPage> createState() => _ServicesCenterPageState();
}

class _ServicesCenterPageState extends State<ServicesCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Service Center", style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
    );
  }
}
