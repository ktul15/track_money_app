import 'package:go_router/go_router.dart';
import 'package:track_money_app/core/router/AppPath.dart';
import 'package:track_money_app/features/add_expense/screen/add_expense.dart';
import 'package:track_money_app/features/list_category/screen/category_list.dart';

import '../../features/auth/screen/login.dart';
import '../../features/home/screen/home_screen.dart';

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
            navigateToAddExpense: (context) =>
                context.pushNamed(AppPath.addExpenseScreen));
      },
    ),
    GoRoute(
        path: AppPath.addExpenseScreen,
        name: AppPath.addExpenseScreen,
        builder: (context, state) {
          return const AddExpense();
        },
        routes: [
          GoRoute(
            path: AppPath.categoryListScreen,
            name: AppPath.categoryListScreen,
            builder: (context, state) {
              return const CategoryList();
            },
          ),
        ]),
  ],
);
