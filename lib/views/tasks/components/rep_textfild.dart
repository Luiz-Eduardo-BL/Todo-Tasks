import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todotasks/utils/app_str.dart';

class RepTextField extends StatelessWidget {
  const RepTextField({
    super.key,
    required this.controller,
    required this.textTheme,
    this.isForDescription = false, 
    required this.onFieldSubmitted, 
    required this.onChanged, 
    required FocusNode focusNode
  });

  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  final bool _hasFocus = true;

  final bool isForDescription;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: !isForDescription ? 6 : null,
          cursorHeight: isForDescription ? 25 : null,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(16),
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            counter: Container(),
            prefixIcon: isForDescription
                ? Icon(Icons.bookmark_border,
                    color: Colors.grey, size: ScreenUtil().setWidth(24))
                : null,
            hintText: isForDescription
                ? AppStr.addNote
                : AppStr.titleOfTitleTextField,
            hintStyle: textTheme.titleMedium
                ?.copyWith(fontSize: ScreenUtil().setSp(16)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
