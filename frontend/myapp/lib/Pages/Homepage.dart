import 'package:flutter/material.dart';
import 'package:myapp/Models/cardmodel.dart';
import 'package:myapp/widgets/CustomCard.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Cardmodel> Cards = [
    Cardmodel(name: "", icon: "person", col: "ff7096"),
    Cardmodel(name: "AI VOICE CHAT", icon: "person", col: "ff7096"),
    Cardmodel(name: "ROLE PLAY", icon: "person", col: "ff7096"),
    Cardmodel(name: "STORY NARRATION", icon: "person", col: "ff7096"),
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
