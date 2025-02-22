import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFa4fff3),
      appBar: AppBar(
        title: Text("Kural"),
        backgroundColor: Color(0xFFcefff9),
        actions: [
          Builder(builder: (context)=>IconButton(onPressed: (){}, icon: Icon(Icons.person)))
        ],
      ),

    );
  }
}