// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blocdating/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:blocdating/models/models.dart';
import 'package:blocdating/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profile";
  const ProfileScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = User.users[0];
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomizedAppBar(
          title: "Profile",
          hasActions: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 3,
                        spreadRadius: 3,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        user.imageUrls[0],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.1),
                        Theme.of(context).primaryColor.withOpacity(0.9),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      user.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleWithIcons(
                    title: "Biography",
                    iconData: Icons.edit,
                  ),
                  Text(
                    user.bio,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(height: 1.5),
                  ),
                  const TitleWithIcons(
                    title: "Pictures",
                    iconData: Icons.photo_album_outlined,
                  ),
                  SizedBox(
                    height: 125,
                    child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 5),
                            height: 125,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    user.imageUrls[index],
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          );
                        }),
                  ),
                  const TitleWithIcons(
                    title: "Location",
                    iconData: Icons.gps_fixed,
                  ),
                  Text(
                    "Singapore, 1 Suntec City",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(height: 1.5),
                  ),
                  const TitleWithIcons(
                    title: "Interests",
                    iconData: Icons.favorite,
                  ),
                  Row(
                    children: user.interests
                        .map((e) => CustomTextContainer(text: e))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TitleWithIcons extends StatelessWidget {
  final String title;
  final IconData iconData;
  const TitleWithIcons({
    Key? key,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(iconData),
            ),
          ],
        ),
      ],
    );
  }
}
