import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_money_app/core/router/AppPath.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.navigateToAddExpense});

  final Function navigateToAddExpense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.green.shade300,
                    width: double.infinity * 0.2,
                    height: 48,
                    child: const Text(
                      "+",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(AppPath.addExpenseScreen);
                    },
                    child: Container(
                      color: Colors.red.shade300,
                      alignment: Alignment.center,
                      width: double.infinity * 0.2,
                      height: 48,
                      child: const Text(
                        "-",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.yellow.shade300,
                    alignment: Alignment.center,
                    width: double.infinity * 0.2,
                    height: 48,
                    child: const Text(
                      "Tr",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
