import 'dart:async';
import 'dart:developer';

import 'package:blocdating/blocs/blocs.dart';
import 'package:blocdating/repositories/auth/auth_repository.dart';
import 'package:blocdating/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/";
  const SplashScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SplashScreen(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AuthRepository().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.authUser != current.authUser,
        listener: (context, state) {
          log("Listener...");
          if (state.status == AuthStatus.unauthenticated) {
            Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushReplacementNamed(
                LoginScreen.routeName,
              ),
            );
          } else if (state.status == AuthStatus.authenticated) {
            Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushReplacementNamed(
                HomeScreen.routeName,
              ),
            );
          }
        },
        child: Scaffold(
          body: SizedBox(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'images/logo.svg',
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'ARROW',
                    style: Theme.of(context).textTheme.headlineLarge,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
