import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle? {
  TextStyle? get boldAndBlack => this?.copyWith(
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );
}
