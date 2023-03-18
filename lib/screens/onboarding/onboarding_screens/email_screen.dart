import 'dart:developer';
import 'package:blocdating/cubits/sign_up/sign_up_cubit.dart';
import 'package:blocdating/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Email extends StatelessWidget {
  final TabController tabController;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Email({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextHeader(text: 'What\'s Your Email Address?'),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hint: 'ENTER YOUR EMAIL',
                    onChangedFunc: (p0) {
                      context.read<SignupCubit>().emailChanged(p0);
                      log(state.email);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomTextHeader(text: 'Choose a password'),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hint: 'Enter YOUR PASSWORD',
                    onChangedFunc: (p0) {
                      context.read<SignupCubit>().passwordChanged(p0);
                      log(state.password);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 1,
                    selectedColor: Theme.of(context).primaryColor,
                    unselectedColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    tabController: tabController,
                    text: 'NEXT STEP',
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
