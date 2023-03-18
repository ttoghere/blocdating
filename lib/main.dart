import 'package:blocdating/blocs/blocs.dart';
import 'package:blocdating/config/config.dart';
import 'package:blocdating/cubits/login/login_cubit.dart';
import 'package:blocdating/cubits/sign_up/sign_up_cubit.dart';

import 'package:blocdating/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'repositories/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => StorageRepository(),
        ),
        RepositoryProvider(
          create: (context) => DatabaseRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SwipeBloc(
              authBloc: context.read<AuthBloc>(),
              databaseRepository: context.read<DatabaseRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => OnboardingBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              storageRepository: context.read<StorageRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              authBloc: context.read<AuthBloc>(),
              databaseRepository: context.read<DatabaseRepository>(),
            )..add(
                LoadProfile(
                  userId: context.read<AuthBloc>().state.user!.uid,
                ),
              ),
          ),
        ],
        child: MaterialApp(
          title: 'Dating App',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
