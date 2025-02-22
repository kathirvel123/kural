import 'package:flutter/material.dart';
import 'package:myapp/Pages/Homepage.dart';
import 'package:myapp/Pages/Navbar.dart';
import 'package:myapp/Pages/Streakcalender.dart';
import 'package:myapp/Pages/progress.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int selecteditem = 0;
  var pagecontroller = PageController();
  var _pages = [Homepage(), Streakcalender(), Progress()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      backgroundColor: Color(0xFFa4fff3),
      appBar: AppBar(
        title: Text("Kural"),
        backgroundColor: Color(0xFFFFB3C1),
        // actions: [
        //   Builder(
        //     builder: (context) =>
        //         IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        //   ),
        // ],
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            selecteditem = index;
          });
        },
        children: _pages,
        controller: pagecontroller,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: "Recap of the Day"),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: "Progress")
          ],
          currentIndex: selecteditem,
          onTap: (index) {
            setState(() {
              selecteditem = index;
              pagecontroller.animateToPage(selecteditem,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            });
          }),
    );
  }
}
