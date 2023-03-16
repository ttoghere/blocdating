import 'package:blocdating/blocs/auth/auth_bloc.dart';
import 'package:blocdating/blocs/images/images_bloc.dart';
import 'package:blocdating/blocs/swipe/swipe_bloc.dart';
import 'package:blocdating/config/config.dart';
import 'package:blocdating/models/user_model.dart';
import 'package:blocdating/repositories/auth/auth_repository.dart';
import 'package:blocdating/repositories/database/database_repository.dart';
import 'package:blocdating/repositories/storage/storage_repository.dart';
import 'package:blocdating/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

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
          create: (_) => AuthRepository(),
        ),
  
        RepositoryProvider(
          create: (_) => StorageRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              authRepository: AuthRepository(),
            ),
          ),
          BlocProvider(
            create: (_) => SwipeBloc()
              ..add(
                LoadUsersEvent(users: User.users),
              ),
          ),
          BlocProvider(
            create: (_) => ImagesBloc(
              databaseRepository: DatabaseRepository(),
            )..add(
                LoadImages(),
              ),
          ),
        ],
        child: MaterialApp(
          title: 'Dating App',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: OnboardingScreen.routeName,
        ),
      ),
    );
  }
}
