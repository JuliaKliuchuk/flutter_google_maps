import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final String text;
  final String date;

  const CommentWidget({super.key, required this.text, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: const Color.fromARGB(33, 3, 168, 244),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(text),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(date),
          ),
        ],
      ),
    );
  }
}
