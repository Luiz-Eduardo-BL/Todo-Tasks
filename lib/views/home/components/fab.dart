import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todotasks/views/tasks/task_view.dart';
import '../../../utils/app_colors.dart';

class Fab extends StatelessWidget {
  const Fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => const TaskView()));
      },
      child: Container(
        width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setWidth(70),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20)),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30, // Fixed: Use a constant value instead of ScreenUtil().setSp(30)
        ),
      ),
    );
  }
}