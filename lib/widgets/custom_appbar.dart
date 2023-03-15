import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomizedAppBar extends StatelessWidget {
  const CustomizedAppBar({
    super.key,
    required this.hasActions,
    required this.title,
  });

  final bool hasActions;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SvgPicture.asset(
              "images/logo.svg",
              height: 50,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GoogleFonts.allan(
                textStyle: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
        ],
      ),
      actions: hasActions
          ? [
              IconButton(
                  icon: Icon(Icons.message,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, '/matches');
                  }),
              IconButton(
                  icon:
                      Icon(Icons.person, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  })
            ]
          : null,
    );
  }
}
