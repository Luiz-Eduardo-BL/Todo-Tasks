import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'package:todotasks/extensions/space_exs.dart';
import 'package:todotasks/main.dart';
import 'package:todotasks/model/task.dart';
import 'package:todotasks/utils/app_colors.dart';
import 'package:todotasks/utils/app_str.dart';
import 'package:todotasks/views/home/components/fab.dart';
import 'package:todotasks/views/home/widget/task_widget.dart';

import '../../utils/constants.dart';
import 'components/home_app_bar.dart';
import 'components/slider_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  dynamic valueOfIndicator(List<Task> tasks) {
    if (tasks.isNotEmpty) {
      return tasks.length;
    } else {
      return 3;
    }
  }

  int checkDoneTask(List<Task> tasks) {
    int i = 0;
    for (Task doneTask in tasks) {
      if (doneTask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTasks(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();

          tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));

          return Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: const Fab(),
              body: SliderDrawer(
                key: drawerKey,
                isDraggable: false,
                animationDuration: 1000,
                slider: CustomDrawer(),
                appBar: HomeAppBar(
                  drawerKey: drawerKey,
                ),
                child: _buildHomeBody(
                  textTheme,
                  base,
                  tasks,
                ),
              ));
        });
  }

  Widget _buildHomeBody(
      TextTheme textTheme, BaseWidget base, List<Task> tasks) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              width: double.infinity,
              height: ScreenUtil().setHeight(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(35),
                    height: ScreenUtil().setWidth(35),
                    child: CircularProgressIndicator(
                      value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                      backgroundColor: Colors.grey,
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.primaryColor),
                    ),
                  ),
                  10.w,
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStr.mainTitle,
                          style: textTheme.displayLarge
                              ?.copyWith(fontSize: ScreenUtil().setSp(24)),
                        ),
                        3.w,
                        Text(
                          "${checkDoneTask(tasks)} de ${tasks.length} Tarefas",
                          style: textTheme.titleMedium
                              ?.copyWith(fontSize: ScreenUtil().setSp(18)),
                        ),
                      ]),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            child: Divider(
              thickness: ScreenUtil().setHeight(2),
              indent: ScreenUtil().setWidth(100),
            ),
          ),
          Expanded(
              child: tasks.isNotEmpty
                  ? ListView.builder(
                      itemCount: tasks.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var task = tasks[index];
                        return Dismissible(
                            key: Key(task.id),
                            direction: DismissDirection.horizontal,
                            onDismissed: (_) {
                              base.dataStore.deleteTask(task: task);
                            },
                            background: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: ScreenUtil().setWidth(24),
                                ),
                                5.w,
                                Text(AppStr.deletedTask,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: ScreenUtil().setSp(16))),
                              ],
                            ),
                            child: TaskWidget(
                              task: task,
                            ));
                      })
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeIn(
                          child: SizedBox(
                            width: ScreenUtil().setWidth(200),
                            height: ScreenUtil().setWidth(200),
                            child: Lottie.asset(
                              lottieURL,
                              animate: tasks.isNotEmpty ? false : true,
                            ),
                          ),
                        ),
                        FadeInUp(
                          from: ScreenUtil().setHeight(30),
                          child: Text(
                            AppStr.doneAllTask,
                            style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                          ),
                        ),
                      ],
                    )),
        ],
      ),
    );
  }
}
