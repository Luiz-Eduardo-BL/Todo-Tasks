import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todotasks/extensions/space_exs.dart';
import 'package:todotasks/utils/app_colors.dart';
import 'package:todotasks/utils/app_str.dart';
import 'package:todotasks/views/home/widget/fab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: const Fab(),

      body: SizedBox(
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

            SizedBox(
              width: double.infinity,
              height: 850,
              child: ListView.builder(
                itemCount: 20,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                return AnimatedContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
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
                              width: .8,
                            ),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 3),
                      child: Text(
                        "Tarefa $index",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          // decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),

                    subtitle: Text(
                      "Descrição da tarefa $index",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
          ],
        ),
      ),
    );
  }
}

