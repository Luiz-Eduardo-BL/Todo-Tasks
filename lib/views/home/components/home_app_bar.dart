import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key, required this.drawerKey});

  final GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animatecontroller;
  bool isDrawerOpen = false;

  @override
  void initState() {
    animatecontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    animatecontroller.dispose();
    super.dispose();
  }

  void onDrawerToggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        animatecontroller.forward();
        widget.drawerKey.currentState!.openSlider();
      } else {
        animatecontroller.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtil().setHeight(80), // Use ScreenUtil to set the height
      child: Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil()
                .setHeight(20)), // Use ScreenUtil to set the padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth(20)), // Use ScreenUtil to set the padding
              child: IconButton(
                onPressed: onDrawerToggle,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: animatecontroller,
                  size: ScreenUtil()
                      .setWidth(30), // Use ScreenUtil to set the icon size
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: ScreenUtil()
                      .setWidth(20)), // Use ScreenUtil to set the padding
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.trash_fill,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
