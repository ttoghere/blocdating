import 'package:blocdating/blocs/onboarding/onboarding_bloc.dart';
import 'package:blocdating/cubits/sign_up/sign_up_cubit.dart';
import 'package:blocdating/models/user_model.dart';
import 'package:blocdating/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  final TextEditingController? passwordController;
  final TextEditingController? emailController;

  const CustomButton({
    Key? key,
    required this.tabController,
    required this.text,
    this.emailController,
    this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (tabController.index <= 5) {
            tabController.animateTo(tabController.index + 1);
          } else {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          }
          if (tabController.index == 2) {
            await context.read<SignupCubit>().signUpWithCredentials(context);
            User user = User(
                id: context.read<SignupCubit>().state.user!.uid,
                name: "",
                age: 0,
                gender: "",
                imageUrls: const [],
                interests: const [],
                bio: "",
                jobTitle: "",
                location: "");
            context.read<OnboardingBloc>().add(
                  StartOnboarding(user: user),
                );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
