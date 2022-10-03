import 'package:flutter/material.dart';
class TrainerHome extends StatefulWidget {
  const TrainerHome({Key? key}) : super(key: key);

  @override
  State<TrainerHome> createState() => _TrainerHomeState();
}

class _TrainerHomeState extends State<TrainerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text('Trainer Home'),),
    );
  }
}
