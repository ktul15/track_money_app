import 'package:add_transaction/add_expense.dart';
import 'package:go_router/go_router.dart';
import 'package:home/home.dart';
import 'package:login/login.dart';

import '../../core.dart';

final loggedOutRoute = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) {
        return const LoginScreen();
      },
    )
  ],
);

final loggedInRoute = GoRouter(
  routes: [
    GoRoute(
      path: AppPath.homeScreen,
      name: AppPath.homeScreen,
      builder: (context, state) {
        return HomeScreen(
            navigateToAddTransaction: (TransactionType type) =>
                context.pushNamed(AppPath.addTransactionScreen, extra: type));
      },
    ),
    GoRoute(
      path: AppPath.addTransactionScreen,
      name: AppPath.addTransactionScreen,
      builder: (context, state) {
        return AddTransactionScreen(state.extra as TransactionType);
      },
      // routes: [
      //   GoRoute(
      //     path: AppPath.categoryListScreen,
      //     name: AppPath.categoryListScreen,
      //     builder: (context, state) {
      //       return const CategoryList();
      //     },
      //   ),
      // ],
    ),
  ],
);
