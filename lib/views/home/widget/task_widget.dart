import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todotasks/model/task.dart';
import 'package:todotasks/views/tasks/task_view.dart';

import '../../../utils/app_colors.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  // ignore: library_private_types_in_public_api
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController textEditingControllerForTitle = TextEditingController();
  TextEditingController textEditingControllerForDescription =
      TextEditingController();

  @override
  void initState() {
    textEditingControllerForTitle.text = widget.task.title;
    textEditingControllerForDescription.text = widget.task.description;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerForTitle.dispose();
    textEditingControllerForDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (ctx) => TaskView(
                      titleTaskController: textEditingControllerForTitle,
                      descriptionTaskControlle:
                          textEditingControllerForDescription,
                      task: widget.task,
                      isUpdate: true,
                    )));
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(18),
            vertical: ScreenUtil().setHeight(8)),
        decoration: BoxDecoration(
          color: widget.task.isCompleted
              ? AppColors.primaryColor.withOpacity(0.2)
              : Colors.white,
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
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: widget.task.isCompleted
                    ? AppColors.primaryColor
                    : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
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
            padding: EdgeInsets.only(
                bottom: ScreenUtil().setHeight(7),
                top: ScreenUtil().setHeight(7)),
            child: Text(
              textEditingControllerForTitle.text,
              style: TextStyle(
                color: widget.task.isCompleted
                    ? AppColors.primaryColor
                    : Colors.black,
                fontWeight: FontWeight.w700,
                decoration: widget.task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textEditingControllerForDescription.text,
                style: TextStyle(
                  color: widget.task.isCompleted
                      ? AppColors.primaryColor
                      : Colors.black,
                  fontWeight: FontWeight.w300,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(10),
                      top: ScreenUtil().setHeight(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          DateFormat('dd/MM/yyyy')
                              .format(widget.task.createdAtDate),
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            color: widget.task.isCompleted
                                ? Colors.white
                                : Colors.grey,
                          )),
                      Text(
                          DateFormat('HH:mm').format(widget.task.createdAtTime),
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            color: widget.task.isCompleted
                                ? Colors.white
                                : Colors.grey,
                          )),
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
