import 'dart:developer';

import 'package:flutter/material.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
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

          title: const Padding(
            padding: EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              "Título da tarefa",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                // decoration: TextDecoration.lineThrough,
              ),
            ),
          ),

          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
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
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          "Data: ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )
                      ),
                      Text(
                          "Hora: ",
                          style: TextStyle(
                            fontSize: 14,
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