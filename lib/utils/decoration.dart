import 'package:flutter/cupertino.dart';

BoxDecoration boxDecoration() => BoxDecoration(
      color: const Color(0xffffffff),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x29000000),
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    );
