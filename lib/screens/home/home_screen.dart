import 'dart:developer';
import 'package:blocdating/blocs/blocs.dart';
import 'package:blocdating/screens/screens.dart';
import 'package:blocdating/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          log(BlocProvider.of<AuthBloc>(context).state.status.toString());
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? const LoginScreen()
              : const HomeScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoading) {
          return const SwipeLoadingHomeScreen();
        } else if (state is SwipeLoaded) {
          var userCount = state.users.length;
          return SwipeLoadedHomeScreen(
            userCount: userCount,
            state: state,
          );
        }
        if (state is SwipeMatched) {
          return SwipeMatchedHomeScreen(
            state: state,
          );
        }

        if (state is SwipeError) {
          return const SwipeErrorHomeScreen();
        } else {
          return const FailureScreen();
        }
      },
    );
  }
}

class SwipeLoadingHomeScreen extends StatelessWidget {
  const SwipeLoadingHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomizedAppBar(
          hasActions: true,
          title: "Discover",
        ),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class SwipeLoadedHomeScreen extends StatelessWidget {
  const SwipeLoadedHomeScreen({
    super.key,
    required this.userCount,
    required this.state,
  });
  final SwipeLoaded state;
  final int userCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomizedAppBar(
            hasActions: true,
            title: "Discover",
          ),
        ),
        body: Column(
          children: [
            InkWell(
              onDoubleTap: () {
                Navigator.pushNamed(context, '/users',
                    arguments: state.users[0]);
              },
              child: Draggable<User>(
                data: state.users[0],
                feedback: UserCard(user: state.users[0]),
                childWhenDragging: (userCount > 1)
                    ? UserCard(user: state.users[1])
                    : Container(),
                onDragEnd: (drag) {
                  if (drag.velocity.pixelsPerSecond.dx < 0) {
                    context
                        .read<SwipeBloc>()
                        .add(SwipeLeft(user: state.users[0]));
                    log('Swiped Left');
                  } else {
                    context
                        .read<SwipeBloc>()
                        .add(SwipeRight(user: state.users[0]));
                    log('Swiped Right');
                  }
                },
                child: UserCard(user: state.users[0]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 60,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      context
                          .read<SwipeBloc>()
                          .add(SwipeRight(user: state.users[0]));
                      log('Swiped Right');
                    },
                    child: ChoiceButton(
                      color: Theme.of(context).colorScheme.secondary,
                      icon: Icons.clear_rounded,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<SwipeBloc>()
                          .add(SwipeRight(user: state.users[0]));
                      log('Swiped Left');
                    },
                    child: const ChoiceButton(
                      width: 80,
                      height: 80,
                      size: 30,
                      color: Colors.white,
                      hasGradient: true,
                      icon: Icons.favorite,
                    ),
                  ),
                  ChoiceButton(
                    color: Theme.of(context).primaryColor,
                    icon: Icons.watch_later,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class FailureScreen extends StatelessWidget {
  const FailureScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomizedAppBar(
            hasActions: true,
            title: "Discover",
          ),
        ),
        body: Text('Something went wrong.'));
  }
}

class SwipeErrorHomeScreen extends StatelessWidget {
  const SwipeErrorHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomizedAppBar(
            hasActions: true,
            title: "Discover",
          ),
        ),
        body: Center(
          child: Text('There aren\'t any more users.',
              style: Theme.of(context).textTheme.headlineSmall),
        ));
  }
}

class SwipeMatchedHomeScreen extends StatelessWidget {
  const SwipeMatchedHomeScreen({
    super.key,
    required this.state,
  });

  final SwipeMatched state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Congrats, it's a match!!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "You and ${state.user} have liked each other!!",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).primaryColor
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        context.read<AuthBloc>().state.user!.imageUrls[0],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).primaryColor
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        state.user.imageUrls[0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
              text: "Send A Message",
              beginColor: Colors.white,
              endColor: Colors.white,
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              text: "Back To Swiping",
              beginColor: Theme.of(context).primaryColor,
              endColor: Theme.of(context).colorScheme.secondary,
              textColor: Colors.white,
              onPressed: () {
                context
                    .read<SwipeBloc>()
                    .add(LoadUsers(user: context.read<AuthBloc>().state.user!));
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*

 */