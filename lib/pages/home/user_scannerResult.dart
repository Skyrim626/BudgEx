import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String text;
  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Result'),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(text, style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              maxLines: 8,
              initialValue: text.trim(),
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Confirm Expense"))
          ],
        ),
      ),
    ),
  );
}