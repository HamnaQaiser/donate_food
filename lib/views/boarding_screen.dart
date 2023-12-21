import 'package:flutter/material.dart';
import 'package:food_donation_app/components/onboard_content.dart';
import 'package:food_donation_app/models/onboard_model.dart';
import 'package:food_donation_app/routes/route_name.dart';

import 'package:food_donation_app/views/welcome_screen.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  late PageController _controller;

  void nextPage() {
    _controller.page == data.length - 1
        ? Navigator.pushNamed(context, RouteName.welcomScreen)
        : _controller.nextPage(
            duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

  void previousPage() {
    _controller.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final List<OnBoard> data = [
    OnBoard(
        text: 'No Food Waste!',
        paragraph:
            "One third of all food produced is lost or wasted, around 1.3 billion tonnes of food.",
        image: "asset/banner 1.jpg"),
    OnBoard(
        text: 'We are in it together.',
        paragraph: "We can be the generation that ends hunger",
        image: "asset/banner 2.jpg"),
    OnBoard(
        text: 'Just one tap.',
        paragraph: "Makes a difference in people's lives with just one tap.",
        image: "asset/banner 3.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            itemCount: data.length,
            controller: _controller,
            itemBuilder: (context, index) => OnBoardContent(
                  text: data[index].text,
                  paragraph: data[index].paragraph,
                  image: data[index].image,
                  indicator: _controller,
                  onPressNext: () => nextPage(),
                  onPressPrevious: () {
                    previousPage();
                  },
                )));
  }
}
