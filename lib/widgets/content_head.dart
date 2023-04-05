import 'package:flutter/cupertino.dart';

class ContentHead extends StatelessWidget {
  const ContentHead({super.key, required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing ?? const SizedBox(),
      ],
    );
  }
}
