import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_colors.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar para task view com as informaçoes da tarefa
        log("Tarefa View");
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(18), vertical: ScreenUtil().setHeight(8)),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: ScreenUtil().setWidth(10),
              offset: Offset(0, ScreenUtil().setWidth(4)),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/addTask');
              log("Tarefa View");
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border:
                Border.all(
                  color: Colors.grey,
                  width: ScreenUtil().setWidth(.8),
                ),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),

          title: Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(5), top: ScreenUtil().setHeight(3)),
            child: const Text(
              "Título da tarefa",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                // decoration: TextDecoration.lineThrough,
              ),
            ),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Descrição da tarefa",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  // decoration: TextDecoration.lineThrough,
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          "Data: ",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            color: Colors.black,
                          )
                      ),
                      Text(
                          "Hora: ",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            color: Colors.black,
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}