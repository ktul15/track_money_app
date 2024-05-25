import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track it"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Add Expense"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Add Income"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Add Investment"),
            ),
          ],
        ),
      ),
    );
  }
}
