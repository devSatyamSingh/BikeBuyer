import 'package:flutter/material.dart';

class DealerNearPage extends StatefulWidget {
  const DealerNearPage({super.key});

  @override
  State<DealerNearPage> createState() => _DealerNearPageState();
}

class _DealerNearPageState extends State<DealerNearPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Near Me Dealer"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
    );
  }
}
