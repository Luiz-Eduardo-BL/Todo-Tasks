import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todotasks/extensions/space_exs.dart';
import 'package:todotasks/utils/app_colors.dart';
import 'package:todotasks/utils/app_str.dart';
import 'package:todotasks/views/tasks/components/date_time_selection.dart';
import 'package:todotasks/views/tasks/components/rep_textfild.dart';
import 'package:todotasks/views/tasks/widget/task_view_app_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController descriptionTaskController =
      TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
    );

    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            onPressed: () {},
            minWidth: 150,
            height: 55,
            color: const Color.fromARGB(255, 243, 114, 105),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                5.w,
                const Text(
                  AppStr.deleteTask,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {},
            minWidth: 150,
            height: 55,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              AppStr.addTaskString,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RepTextField(controller: controller, textTheme: textTheme),
          10.h,
          RepTextField(
              controller: descriptionTaskController,
              isForDescription: true,
              textTheme: textTheme),
          DateTimeSelectionWidget(
            selectedTime: selectedTime,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: CupertinoTimerPicker(
                      onTimerDurationChanged: (value) {
                        setState(() {
                          selectedTime = TimeOfDay(
                              hour: value.inHours,
                              minute: value.inMinutes.remainder(60));
                        });
                      },
                      initialTimerDuration: Duration(
                          hours: selectedTime.hour,
                          minutes: selectedTime.minute)),
                ),
              );
            },
            title: AppStr.timeString,
          ),
          DateTimeSelectionWidget(
            selectedTime: selectedTime,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (value) {
                      setState(() {
                        const Locale('pt', 'BR');
                        selectedTime = TimeOfDay.fromDateTime(value);
                      });
                      //FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                ),
              );
            },
            title: AppStr.dateString,
          ),
        ],
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
              text: AppStr.addNewTask,
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
