import 'package:blocdating/models/models.dart';
import 'package:blocdating/screens/screens.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  const MatchesScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const MatchesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<UserMatch> inactiveMatches = UserMatch.matches
        .where((element) => element.userId == 1 && element.chat!.isEmpty)
        .toList();
    List<UserMatch> activeMatches = UserMatch.matches
        .where((element) => element.userId == 1 && element.chat!.isNotEmpty)
        .toList();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomizedAppBar(hasActions: false, title: "Matches"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Likes",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: inactiveMatches.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          UserImageSmall(
                            height: 70,
                            width: 70,
                            url:
                                inactiveMatches[index].matchedUser.imageUrls[0],
                          ),
                          Text(
                            inactiveMatches[index].matchedUser.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        ],
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Your Chats",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: activeMatches.length,
                itemBuilder: (context, index) {
                  var access = activeMatches[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(ChatScreen.routeName, arguments: access),
                    child: Row(
                      children: [
                        UserImageSmall(
                          url: access.matchedUser.imageUrls[0],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              access.matchedUser.name,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              access.chat![0].messages[0].message,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              access.chat![0].messages[0].timeString,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
