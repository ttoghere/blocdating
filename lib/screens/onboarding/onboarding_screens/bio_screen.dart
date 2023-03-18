import 'package:blocdating/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../blocs/blocs.dart';

class Bio extends StatelessWidget {
  final TabController tabController;
  const Bio({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OnboardingLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextHeader(text: 'Describe Yourself'),
                    CustomTextField(
                      hint: 'ENTER YOUR BIO',
                      onChangedFunc: (p0) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(
                                  bio: p0,
                                ),
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: 100),
                    const CustomTextHeader(text: 'What Do You Like?'),
                    Row(
                      children: const [
                        CustomTextContainer(text: 'MUSIC'),
                        CustomTextContainer(text: 'ECONOMICS'),
                        CustomTextContainer(text: 'POLITICS'),
                        CustomTextContainer(text: 'ART'),
                      ],
                    ),
                    Row(
                      children: const [
                        CustomTextContainer(text: 'NATURE'),
                        CustomTextContainer(text: 'HIKING'),
                        CustomTextContainer(text: 'FOOTBALL'),
                        CustomTextContainer(text: 'MOVIES'),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 5,
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor: Theme.of(context).colorScheme.background,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        tabController: tabController, text: 'NEXT STEP'),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Text("Something Went Wrong");
        }
      },
    );
  }
}
