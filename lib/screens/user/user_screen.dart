import 'package:blocdating/models/models.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/users';

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => UsersScreen(user: user),
    );
  }

  final User user;

  const UsersScreen({super.key, 
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
