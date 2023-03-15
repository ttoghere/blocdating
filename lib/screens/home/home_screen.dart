import 'dart:developer';
import 'package:blocdating/blocs/swipe/swipe_bloc.dart';
import 'package:blocdating/screens/user/user_screen.dart';
import 'package:blocdating/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasActions = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomizedAppBar(
          hasActions: hasActions,
          title: "Discover",
        ),
      ),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(UsersScreen.routeName,
                        arguments: state.users[0]);
                  },
                  child: Draggable<User>(
                    data: state.users[0],
                    feedback: UserCard(user: state.users[0]),
                    childWhenDragging: UserCard(user: state.users[1]),
                    onDragEnd: (drag) {
                      if (drag.velocity.pixelsPerSecond.dx < 0) {
                        context
                            .read<SwipeBloc>()
                            .add(SwipeLeftEvent(user: state.users[0]));
                        log('Swiped Left');
                      } else {
                        context
                            .read<SwipeBloc>()
                            .add(SwipeRightEvent(user: state.users[0]));
                        log('Swiped Right');
                      }
                    },
                    child: UserCard(user: state.users[0]),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ChoiceButton(
                        color: Colors.red,
                        icon: Icons.clear_rounded,
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeRightEvent(user: state.users[0]));
                          log('Swiped Right');
                        },
                        child: const ChoiceButton(
                          color: Colors.white,
                          icon: Icons.favorite,
                          width: 80,
                          height: 80,
                          size: 30,
                          hasGradient: true,
                        ),
                      ),
                      const ChoiceButton(
                        color: Colors.red,
                        icon: Icons.watch_later,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Text("Something Went Wrong");
          }
        },
      ),
    );
  }
}
