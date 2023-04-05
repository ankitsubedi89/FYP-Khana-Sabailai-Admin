import 'package:flutter/material.dart';

class CircularBtn extends StatelessWidget {
  const CircularBtn(
      {Key? key,
      required this.onTap,
      required this.icon,
      this.color = Colors.white})
      : super(key: key);
  final Function onTap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Icon(icon,
                color: color == Colors.black ? Colors.white : Colors.black)));
  }
}
