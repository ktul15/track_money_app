import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:home/src/l10n/homeScreenLocalizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.navigateToAddTransaction});

  final Function(TransactionType type) navigateToAddTransaction;

  @override
  Widget build(BuildContext context) {
    var homeLocalizations = HomeScreenLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(homeLocalizations.appbarLabelHome),
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
                  child: GestureDetector(
                    onTap: () {
                      navigateToAddTransaction(TransactionType.INCOME);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.green.shade300,
                      width: double.infinity * 0.2,
                      height: 48,
                      child: Text(
                        homeLocalizations.bottomAppbarLabelIncome,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      navigateToAddTransaction(TransactionType.EXPENSE);
                    },
                    child: Container(
                      color: Colors.red.shade300,
                      alignment: Alignment.center,
                      width: double.infinity * 0.2,
                      height: 48,
                      child: Text(
                        homeLocalizations.bottomAppbarLabelExpense,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      navigateToAddTransaction(TransactionType.TRANSFER);
                    },
                    child: Container(
                      color: Colors.yellow.shade300,
                      alignment: Alignment.center,
                      width: double.infinity * 0.2,
                      height: 48,
                      child: Text(
                        homeLocalizations.bottomAppbarLabelTransfer,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
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
