import 'package:blocdating/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Start extends StatelessWidget {
  final TabController tabController;

  const Start({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: SvgPicture.asset(
                  'images/couple.svg',
                ),
              ),
              const SizedBox(height: 50),
              Text('Welcome to Arrow',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 20),
              Text(
                'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(height: 1.8),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          CustomButton(tabController: tabController, text: 'START')
        ],
      ),
    );
  }
}
