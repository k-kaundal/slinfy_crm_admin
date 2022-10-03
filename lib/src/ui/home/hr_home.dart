import 'package:flutter/material.dart';
class HRHome extends StatefulWidget {
  const HRHome({Key? key}) : super(key: key);

  @override
  State<HRHome> createState() => _HRHomeState();
}

class _HRHomeState extends State<HRHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('HR Home'),),
    );
  }
}
