import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_money_app/core/router/router.dart';
import 'package:track_money_app/features/auth/models/user.dart';
import 'package:track_money_app/theme/palette.dart';

import 'core/common/error_text.dart';
import 'core/common/loader.dart';
import 'features/auth/controller/auth_controller.dart';
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
                  theme: ref.read(themeNotifierProvider),
                  routerConfig: loggedInRoute,
                );
              }
            }
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Track It!',
              theme: ref.read(themeNotifierProvider),
              routerConfig: loggedOutRoute,
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
