import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/src/l10n/loginScreenLocalizations.dart';
import 'package:theme/theme.dart';

import 'auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginScreenLocalizations = LoginScreenLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loginScreenLocalizations.appbarLoginHeader,
          style: const TextStyle(color: Pallete.blackColor),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Pallete.blueColor),
          onPressed: () => signInWithGoogle(context, ref),
          child: Text(
            loginScreenLocalizations.googleSignInButtonLabel,
            style: const TextStyle(color: Pallete.whiteColor),
          ),
        ),
      ),
    );
  }
}
