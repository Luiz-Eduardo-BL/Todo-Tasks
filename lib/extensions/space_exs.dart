import 'package:flutter/cupertino.dart';

extension IntExtension on int{
  int validate({int value = 0}) {
    return this;
  }

  Widget get h => SizedBox(
      height: toDouble(),
  );

  Widget get w => SizedBox(
      width: toDouble(),
  );
}