import 'package:blocdating/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Bio extends StatelessWidget {
  final TabController tabController;
  TextEditingController controller = TextEditingController();

  Bio({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                controller: controller,
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
              CustomButton(tabController: tabController, text: 'NEXT STEP'),
            ],
          ),
        ],
      ),
    );
  }
}
