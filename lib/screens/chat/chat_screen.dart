import 'dart:developer';

import 'package:blocdating/models/user_match_model.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ChatScreen(
        userMatch: userMatch,
      ),
    );
  }

  final UserMatch userMatch;
  const ChatScreen({super.key, required this.userMatch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        elevation: 0,
        title: Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(userMatch.matchedUser.imageUrls[0]),
            ),
            Text(
              userMatch.matchedUser.name,
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: userMatch.chat != null
                  ? SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: userMatch.chat![0].messages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: userMatch
                                        .chat![0].messages[index].senderId ==
                                    1
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                      child: Text(
                                        userMatch
                                            .chat![0].messages[index].message,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage: NetworkImage(
                                            userMatch.matchedUser.imageUrls[0],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          child: Text(
                                            userMatch.chat![0].messages[index]
                                                .message,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: 100,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        log("Tapped");
                      },
                      icon: const Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                      )),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Type Here...",
                      contentPadding:
                          EdgeInsets.only(left: 20, bottom: 5, top: 5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
