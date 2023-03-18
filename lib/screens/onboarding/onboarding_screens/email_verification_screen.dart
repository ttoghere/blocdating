import 'package:blocdating/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EmailVerification extends StatefulWidget {
  final TabController tabController;

   const EmailVerification({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children:  [
           const   CustomTextHeader(text: 'Did You Get the Verification Code?'),
              CustomTextField(hint: 'ENTER YOUR CODE',controller: controller,),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 2,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(height: 10),
              CustomButton(tabController: widget.tabController, text: 'NEXT STEP'),
            ],
          ),
        ],
      ),
    );
  }
}
