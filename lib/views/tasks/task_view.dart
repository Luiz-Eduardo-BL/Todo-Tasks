import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:todotasks/extensions/space_exs.dart';
import 'package:todotasks/main.dart';
import 'package:todotasks/utils/app_colors.dart';
import 'package:todotasks/utils/app_str.dart';
import 'package:todotasks/utils/constants.dart';
import 'package:todotasks/views/tasks/components/date_time_selection.dart';
import 'package:todotasks/views/tasks/components/rep_textfild.dart';
import 'package:todotasks/views/tasks/widget/task_view_app_bar.dart';

import '../../model/task.dart';

class TaskView extends StatefulWidget {
  const TaskView(
      {super.key,
      required this.task,
      required this.titleTaskController,
      required this.descriptionTaskControlle});

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskControlle;

  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  DateTime? selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  var title;
  var description;
  DateTime? time;
  DateTime? date;

  bool isTaskAlreadyExist() {
    if (widget.titleTaskController?.text == null &&
        widget.descriptionTaskControlle?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  dynamic isTaskAlreadyExistUpdateOtherWiseCrete() {
    if (isTaskAlreadyExist()) {
      if (title == null && description == null) {
        emptyWarning(context);
      } else {
        var task = Task.create(
          title: title,
          description: description,
          createdAtDate: date,
          createdAtTime: time,
        );
        BaseWidget.of(context).dataStore.addTask(task: task);

        Navigator.pop(context);
      }
    } else {
      try {
        widget.titleTaskController?.text = title;
        widget.descriptionTaskControlle?.text = description;

        widget.task?.save();

        Navigator.pop(context);
      } catch (e) {
        updateTaskWarning(context);
      }
    }
  }

  dynamic deleteTask() {
    widget.task?.delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
    );

    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      child: Scaffold(
        appBar: const TaskViewAppBar(),
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopSideTexts(textTheme),
                _buildMainTaskViewActivity(textTheme, context),
                _buildBottomSideButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExist()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          isTaskAlreadyExist()
              ? Container()
              : MaterialButton(
                  onPressed: () {
                    deleteTask();
                  },
                  minWidth: 150,
                  height: 55,
                  color: const Color.fromARGB(255, 243, 114, 105),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      5.w,
                      const Text(
                        AppStr.deleteTask,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
          MaterialButton(
            onPressed: () {
              isTaskAlreadyExistUpdateOtherWiseCrete();
            },
            minWidth: 150,
            height: 55,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              const Icon(
                Icons.save,
                color: Colors.white,
              ),
              5.w,
              Text(
                isTaskAlreadyExist()
                    ? AppStr.addTaskString
                    : AppStr.updateTaskString,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    bool showDate = true;
    final titleFocusNode = FocusNode();
    final descriptionFocusNode = FocusNode();

    return GestureDetector(
      onTap: () {
        if (!titleFocusNode.hasFocus && !descriptionFocusNode.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 530,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepTextField(
              controller: widget.titleTaskController ?? TextEditingController(),
              textTheme: textTheme,
              focusNode: titleFocusNode,
              onFieldSubmitted: (String inputTitle) {
                title = inputTitle;
                FocusScope.of(context).requestFocus(descriptionFocusNode);
              },
              onChanged: (String inputTitle) {
                title = inputTitle;
              },
            ),
            10.h,
            RepTextField(
              controller:
                  widget.descriptionTaskControlle ?? TextEditingController(),
              isForDescription: true,
              textTheme: textTheme,
              focusNode: descriptionFocusNode,
              onFieldSubmitted: (String inputDescription) {
                description = inputDescription;
              },
              onChanged: (String inputDescription) {
                description = inputDescription;
              },
            ),
            DateTimeSelectionWidget(
              selectedDate: selectedDate,
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate:
                      DateTime.now().subtract(const Duration(days: 365 * 100)),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 200)),
                );
                if (pickedDate != null && pickedDate != selectedDate) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              title: AppStr.dateString,
              selectedTime: selectedTime,
              showDate: showDate,
            ),
            DateTimeSelectionWidget(
              selectedTime: selectedTime,
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (pickedTime != null && pickedTime != selectedTime) {
                  setState(() {
                    selectedTime = pickedTime;
                  });
                }
              },
              title: AppStr.timeString,
              selectedDate: null,
              showDate: !showDate,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtil()
          .setHeight(100), // Set the height to 100% of the screen height
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: ScreenUtil()
                .setWidth(52), // Set the width to 52% of the screen width
            child: const Divider(
              thickness: 2,
            ),
          ),
          SizedBox(
            width: ScreenUtil()
                .setWidth(200), // Set the width to 200% of the screen width
            child: RichText(
                text: TextSpan(
              text: isTaskAlreadyExist()
                  ? AppStr.addNewTask
                  : AppStr.updateCurrentTask,
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                    text: AppStr.taskStrnig,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    )),
              ],
            )),
          ),
          SizedBox(
            width: ScreenUtil()
                .setWidth(52), // Set the width to 52% of the screen width
            child: const Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
