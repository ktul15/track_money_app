import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:track_money_app/core/router/AppPath.dart';
import 'package:track_money_app/features/add_expense/screen/add_expense.dart';

import '../../features/auth/screen/login.dart';
import '../../features/home/screen/home_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(
  routes: {
    AppPath.homeScreen: (_) => MaterialPage(
            child: HomeScreen(
          navigateToAddExpense: (context) =>
              Routemaster.of(context).push(AppPath.addExpenseScreen),
        )),
    AppPath.addExpenseScreen: (_) => const MaterialPage(child: AddExpense()),
  },
);
