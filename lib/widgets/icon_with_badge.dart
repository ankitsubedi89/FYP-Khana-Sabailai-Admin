import 'package:flutter/material.dart';

class IconWithBadge extends StatelessWidget {
  const IconWithBadge({Key? key, required this.icon, this.label = 0})
      : super(key: key);

  final Widget icon;
  final int label;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      icon,
      if (label > 0)
        Positioned(
            top: -10,
            right: -10,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                label.toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ))
    ]);
  }
}
