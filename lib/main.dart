import 'package:blocdating/blocs/swipe/swipe_bloc.dart';
import 'package:blocdating/config/config.dart';
import 'package:blocdating/models/user_model.dart';
import 'package:blocdating/screens/home/home_screen.dart';
import 'package:blocdating/screens/screens.dart';
import 'package:blocdating/screens/splash/splash_screen.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SwipeBloc()
            ..add(
              LoadUsersEvent(users: User.users),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Dating App',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: MatchesScreen.routeName,
      ),
    );
  }
}
