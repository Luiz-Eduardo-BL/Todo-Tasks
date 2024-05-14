import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'package:todotasks/extensions/space_exs.dart';
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

  final List<int> teste = [1, 2];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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
        child: _buildHomeBody(textTheme),
      )
    );
  }

  Widget _buildHomeBody(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(

        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 35,
                  height: 35,
                  child: CircularProgressIndicator(
                    value: 1 / 3,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(
                        AppColors.primaryColor
                    ),
                  ),
                ),

                25.w,

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStr.mainTitle,
                      style: textTheme.displayLarge,
                    ),
                    3.h,
                    Text(
                      "1 de 3 Tarefas",
                      style: textTheme.titleMedium,
                    ),
                  ]
                ),
              ],
            )
          ),

          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          Expanded(
            child:teste.isNotEmpty? ListView.builder(
              itemCount: teste.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {
                  setState(() {
                    teste.removeAt(index);
                  });
                },
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    5.w,
                    const Text(
                      AppStr.deletedTask,
                      style: TextStyle(color: Colors.red)
                    ),
                  ],
                ),
                key: Key(index.toString(),
                ),
                  child: const TaskWidget()
              );
            }
          ): Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeIn(
                  child: SizedBox(
                    width: 250,
                    height: 250,
                    child: Lottie.asset(
                      lottieURL,
                      animate: teste.isNotEmpty ? false : true,
                    ),
                  ),
                ),
                FadeInUp(
                  from: 30,
                  child: const Text(
                    AppStr.doneAllTask,
                  ),
                ),
              ],
            )
        ),
        ],
      ),
    );
  }
}