import 'package:flutter/material.dart';
import 'package:myapp/Pages/voicechatpage.dart';

class Customcard extends StatefulWidget {
  const Customcard({super.key, required this.cardmodel});

  final cardmodel;

  @override
  State<Customcard> createState() => _CustomcardState();
}
// ignore: prefer_interpolation_to_compose_strings

class _CustomcardState extends State<Customcard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => widget.cardmodel.page));
        },
        child: SizedBox(
          width: double.infinity,
          height: 165,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 10),
                child: Text(
                  widget.cardmodel.name,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ));
  }
}
