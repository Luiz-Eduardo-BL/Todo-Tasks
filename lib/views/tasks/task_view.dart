import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  const TaskView({
    super.key,
    required this.task,
    required this.titleTaskController,
    required this.descriptionTaskControlle,
    required this.isUpdate,
  });

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskControlle;
  final Task? task;
  final bool isUpdate;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  DateTime? selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  var title;
  var description;

  late TextEditingController titleTaskController;
  late TextEditingController descriptionTaskControlle;

  @override
  void initState() {
    super.initState();
    titleTaskController = widget.titleTaskController ?? TextEditingController();
    descriptionTaskControlle =
        widget.descriptionTaskControlle ?? TextEditingController();

    if (widget.isUpdate && widget.task != null) {
      title = widget.task?.title;
      description = widget.task?.description;
      selectedDate = widget.task?.createdAtDate;
      selectedTime =
          TimeOfDay.fromDateTime(widget.task?.createdAtTime ?? DateTime.now());

      titleTaskController.text = title ?? '';
      descriptionTaskControlle.text = description ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isTaskValid() {
    return titleTaskController.text.isNotEmpty &&
        descriptionTaskControlle.text.isNotEmpty;
  }

  dynamic isTaskAlreadyExistUpdateOtherWiseCreate() {
    if (isTaskValid()) {
      if (widget.isUpdate) {
        try {
          widget.task?.title = titleTaskController.text;
          widget.task?.description = descriptionTaskControlle.text;
          widget.task?.createdAtDate = selectedDate!;
          widget.task?.createdAtTime = DateTime(
              selectedDate!.year,
              selectedDate!.month,
              selectedDate!.day,
              selectedTime.hour,
              selectedTime.minute);

          widget.task?.save();

          Navigator.pop(context);
        } catch (e) {
          updateTaskWarning(context);
        }
      } else {
        var task = Task.create(
          title: titleTaskController.text,
          description: descriptionTaskControlle.text,
          createdAtDate: selectedDate,
          createdAtTime: DateTime(selectedDate!.year, selectedDate!.month,
              selectedDate!.day, selectedTime.hour, selectedTime.minute),
        );
        BaseWidget.of(context).dataStore.addTask(task: task);

        Navigator.pop(context);
      }
    } else {
      emptyWarning(context);
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

    return Scaffold(
      appBar: const TaskViewAppBar(),
      body: Column(
        children: [
          Expanded(
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
        ],
      ),
    );
  }

  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: widget.isUpdate
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: [
          if (widget.isUpdate)
            MaterialButton(
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
              isTaskAlreadyExistUpdateOtherWiseCreate();
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
                widget.isUpdate
                    ? AppStr.updateTaskString
                    : AppStr.addTaskString,
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

    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RepTextField(
            controller: titleTaskController,
            textTheme: textTheme,
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),
          10.h,
          RepTextField(
            controller: descriptionTaskControlle,
            isForDescription: true,
            textTheme: textTheme,
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
    );
  }

  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtil().setHeight(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(62),
            child: const Divider(
              thickness: 2,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(200),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: widget.isUpdate
                      ? AppStr.updateCurrentTask
                      : AppStr.addNewTask,
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
            width: ScreenUtil().setWidth(62),
            child: const Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
