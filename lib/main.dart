import 'package:add_transaction/add_expense.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/home.dart';
import 'package:login/login.dart';
import 'package:theme/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  AppUser? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) {
            if (data != null) {
              getData(ref, data);
              if (userModel != null) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'Track It!',
                  localizationsDelegates: const [
                    HomeScreenLocalizations.delegate,
                    LoginScreenLocalizations.delegate,
                    AddExpenseScreenLocalizations.delegate,
                  ],
                  theme: ref.read(themeNotifierProvider),
                  routerConfig: loggedInRoute,
                );
              }
            }
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Track It!',
              localizationsDelegates: const [
                HomeScreenLocalizations.delegate,
                LoginScreenLocalizations.delegate,
                AddExpenseScreenLocalizations.delegate,
              ],
              theme: ref.read(themeNotifierProvider),
              routerConfig: loggedOutRoute,
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
