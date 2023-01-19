// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stories_app/detail_screen.dart';
import 'package:stories_app/story_data.dart';

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class CustomIcons {
  static const IconData menu = IconData(
    0xe900,
    fontFamily: "CustomIcons",
  );
  static const IconData option = IconData(
    0xe902,
    fontFamily: "CustomIcons",
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final images = StoryData.stories.map((e) => e.image).toList();
  late double? currentPage = images.length - 1;
  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: images.length - 1);
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page;
      });
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF2d3447),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              size: 24,
            ),
            onPressed: () {},
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF2d3447),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.more_horiz_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
          title: const Text(
            'Stories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Trending",
                      style: TextStyle(
                          fontFamily: "Calibre-Semibold",
                          color: Colors.white,
                          fontSize: 46.0,
                          letterSpacing: 1.0),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.more,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 22.0,
                          vertical: 6.0,
                        ),
                        child: Center(
                          child: Text(
                            "Animated",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "25+ Stories",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  _CardScrollWidget(
                    currentPage: currentPage ?? 1,
                    padding: 20,
                    verticalInset: 20,
                  ),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: images.length,
                      controller: pageController,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return const SizedBox.shrink();
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Favourite",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontFamily: "Calibre-Semibold"),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.more_horiz_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        // color: Color(0xFFff6e6e)
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 6.0),
                        child: Center(
                          child: Text(
                            "Latest",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "9+ Stories",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: StoryData.stories
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                DetailScreen.routeName,
                                arguments: e,
                              );
                            },
                            child: _Favourites(
                              title: e.title,
                              imageUrl: e.image,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Favourites extends StatelessWidget {
  final String title;
  final String imageUrl;

  const _Favourites({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          height: 300,
          width: 300,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: 10,
                top: 170,
                bottom: 15,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardScrollWidget extends StatelessWidget {
  final double currentPage;
  final double padding;
  final double verticalInset;

  const _CardScrollWidget({
    Key? key,
    required this.currentPage,
    required this.padding,
    required this.verticalInset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final images = StoryData.stories.map((e) => e.image).toList();
    final titles = StoryData.stories.map((e) => e.title).toList();
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = [];

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(images[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                titles[i],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "SF-Pro-Text-Regular",
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22.0,
                                  vertical: 6.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Text(
                                  "Read Later",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
