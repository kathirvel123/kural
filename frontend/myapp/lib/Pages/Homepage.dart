import 'package:flutter/material.dart';
import 'package:myapp/Models/cardmodel.dart';
import 'package:myapp/Pages/roleplaypage.dart';
import 'package:myapp/Pages/storynarationpage.dart';
import 'package:myapp/Pages/voicechatpage.dart';
import 'package:myapp/widgets/CustomCard.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Cardmodel> Cards = [
    Cardmodel(
        name: "AI VOICE CHAT",
        icon: "person",
        col: "0xFFFFFFFF",
        image: "assets/images/img_code.jpg",
        page: Voicechatpage()),
    Cardmodel(
        name: "ROLE PLAY",
        icon: "person",
        col: "0xFFFFFFFF",
        page: Roleplaypage(),
        image: "assets/images/Honors.jpg"),
    Cardmodel(
        name: "STORY NARRATION",
        icon: "person",
        col: "0xFFFFFFFF",
        image: "assets/images/img_reachout.jpg",
        page: Storynarationpage()),
    Cardmodel(
        name: "CONNECT WITH MY FRIEND",
        icon: "person",
        col: "0xFFFFFFFF",
        image: "assets/images/img_backtoschool.jpg",
        page: Roleplaypage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: Cards.length,
        itemBuilder: (context, index) => Customcard(
          cardmodel: Cards[index],
          key: null,
        ),
      ),
    );
  }
}
