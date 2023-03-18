import 'package:blocdating/models/models.dart';
import 'package:blocdating/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'user_image',
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              UserImage.large(
                url: user.imageUrls[0],
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name}, ${user.age}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      user.jobTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: user.imageUrls.length + 1,
                          itemBuilder: (context, index) {
                            return (index < user.imageUrls.length)
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: UserImage.small(
                                      url: user.imageUrls[index],
                                    ),
                                  )
                                : Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.info_outline,
                                      size: 25,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  );
                          }),
                    )
                    // Row(
                    //   children: [
                    //     UserImageSmall(url: user.imageUrls[1]),
                    //     UserImageSmall(url: user.imageUrls[2]),
                    //     UserImageSmall(url: user.imageUrls[3]),
                    //     UserImageSmall(url: user.imageUrls[4]),
                    //     Container(
                    //       width: 35,
                    //       height: 35,
                    //       decoration: const BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.white,
                    //       ),
                    //       child: Icon(
                    //         Icons.info_outline,
                    //         size: 25,
                    //         color: Theme.of(context).primaryColor,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
