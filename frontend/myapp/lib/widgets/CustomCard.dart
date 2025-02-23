import 'package:flutter/material.dart';
import 'package:myapp/Pages/voicechatpage.dart';

class Customcard extends StatefulWidget {
  const Customcard({Key? key, required this.cardmodel}) : super(key: key);

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
        child: Container(
          width: double.infinity,
          height: 165,
          child: Card(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Ink.image(
                  image: AssetImage(widget.cardmodel.image),
                  height: 165,
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => widget.cardmodel.page));
                    },
                  ),
                ),
                Text(
                  widget.cardmodel.name,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
