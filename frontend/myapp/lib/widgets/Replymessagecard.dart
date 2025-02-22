import 'package:flutter/material.dart';

class Replymessagecard extends StatelessWidget {
  const Replymessagecard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.blueAccent,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 60, top: 5, bottom: 20),
                  child: Text(
                    "Hey",
                    style: TextStyle(fontSize: 16),
                  )),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  "09.20",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
