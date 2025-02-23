import 'package:flutter/material.dart';

class Ownmessagecard extends StatelessWidget {
   final String message;

  const Ownmessagecard({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.greenAccent,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Padding(
            padding:
                EdgeInsets.only(left: 10, right: 60, top: 5, bottom: 20),
            child: Text(
              message,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
