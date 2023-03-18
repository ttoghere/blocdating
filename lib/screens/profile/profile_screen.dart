// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:blocdating/blocs/blocs.dart';
import 'package:blocdating/repositories/auth/auth_repository.dart';
import 'package:blocdating/screens/onboarding/widgets/widgets.dart';
import 'package:blocdating/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:blocdating/models/models.dart';
import 'package:blocdating/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profile";
  const ProfileScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          log("${BlocProvider.of<AuthBloc>(context).state.status}");
          return (BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated)
              ? const OnboardingScreen()
              : const ProfileScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomizedAppBar(
          title: "Profile",
          hasActions: true,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoaded) {
              return Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  UserImage.medium(
                    url: state.user.imageUrls[0],
                    child: Container(
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
                          state.user.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
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
                          state.user.bio,
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
                              itemCount: state.user.imageUrls.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                /*
                                 Container(
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
                                          state.user.imageUrls[index],
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                );
                                 */
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: UserImage.small(
                                    url: state.user.imageUrls[index],
                                    width: 100,
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const TitleWithIcons(
                          title: "Location",
                          iconData: Icons.gps_fixed,
                        ),
                        Text(
                          state.user.location,
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
                          children: state.user.interests
                              .map((e) => CustomTextContainer(text: e))
                              .toList(),
                        ),
                        TextButton(
                          onPressed: () {
                            RepositoryProvider.of<AuthRepository>(context)
                                .signOut();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                OnboardingScreen.routeName, (route) => false);
                          },
                          child: Text("Sign Out"),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text("Something Went Wrong"),
              );
            }
          },
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
