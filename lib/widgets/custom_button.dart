import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.small = false});

  final String label;
  final Function()? onPressed;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: small ? 10 : 30, vertical: small ? 3 : 7),
        decoration: BoxDecoration(
          color: const Color(0xff020578),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(width: 1.0, color: const Color(0xffeaeaea)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: small ? 16 : 21,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w500,
          ),
          softWrap: false,
        ),
      ),
    );
  }
}
