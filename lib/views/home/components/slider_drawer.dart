import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lottie/lottie.dart';
import 'package:todotasks/extensions/space_exs.dart';

import 'package:todotasks/utils/app_colors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isEditing = false;
  bool _showOptions = true;

  String _userName = 'Usuario';
  String _userRole = 'Função';

  final List<IconData> icons = [
    CupertinoIcons.timer_fill,
    CupertinoIcons.info_circle_fill,
  ];

  final List<String> texts = [
    'Pomodoro',
    'Sobre',
  ];

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> savePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _userName);
    await prefs.setString('userRole', _userRole);
    await prefs.setBool('isEditing', _isEditing);
    await prefs.setBool('showOptions', _showOptions);
    await prefs.setString('selectedAvatar', selectedAvatar);
  }

  Future<void> loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('username') ?? 'Usuario';
      _userRole = prefs.getString('userRole') ?? 'Função';
      _isEditing = prefs.getBool('isEditing') ?? false;
      _showOptions = prefs.getBool('showOptions') ?? true;
      selectedAvatar =
          prefs.getString('selectedAvatar') ?? 'assets/lottie/Homem.json';
    });
  }

  String selectedAvatar = 'assets/lottie/Homem.json';

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(80)),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.quaternaryGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _showAvatarSelectionDialog(context);
            },
            child: Lottie.asset(
              selectedAvatar,
              width: ScreenUtil().setWidth(100),
              height: ScreenUtil().setHeight(100),
            ),
          ),
          20.h,
          GestureDetector(
            onTap: () {
              setState(() {
                _isEditing = true;
                _showOptions = false;
                loadPreferences();
              });
            },
            child: _isEditing
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: _userName,
                        hintStyle:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _userName = value;
                        });
                        savePreferences();
                      },
                    ),
                  )
                : Text(
                    _userName,
                    style: textTheme.displayMedium,
                  ),
          ),
          5.h,
          GestureDetector(
            onTap: () {
              setState(() {
                _isEditing = true;
                _showOptions = false;
              });
            },
            child: _isEditing
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: _userRole,
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize:
                                16), // textTheme.displaySmall.copyWith(fontSize: 16
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _userRole = value;
                        });
                        savePreferences();
                      },
                    ),
                  )
                : Text(
                    _userRole,
                    style: textTheme.displaySmall,
                  ),
          ),
          20.h,
          if (_isEditing)
            ElevatedButton(
              onPressed: () {
                savePreferences();
                setState(() {
                  _isEditing = false;
                  _showOptions = true;
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Salvar',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          if (_showOptions)
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setHeight(20),
              ),
              width: double.infinity,
              height: ScreenUtil().setHeight(400),
              child: ListView.builder(
                itemCount: icons.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          if (index == 0 || index == 1) {
                            // Handle "Em Breve" functionality (e.g., show a dialog)
                            return;
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                          child: ListTile(
                            leading: Icon(
                              icons[index],
                              color: Colors.white,
                              size: ScreenUtil().setWidth(25),
                            ),
                            title: Text(texts[index],
                                style: textTheme.displaySmall),
                          ),
                        ),
                      ),
                      if (index == 0 || index == 1)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Em Breve",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _showAvatarSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Escolha seu Avatar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAvatarOption('Homem.json'),
              _buildAvatarOption('Mulher.json'),
              _buildAvatarOption('Garoto.json'),
              _buildAvatarOption('Garota.json'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatarOption(String avatarPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAvatar = 'assets/lottie/$avatarPath';
        });
        Navigator.of(context).pop();
      },
      child: Row(
        children: [
          Lottie.asset(
            'assets/lottie/$avatarPath',
            width: ScreenUtil().setWidth(80),
            height: ScreenUtil().setWidth(80),
          ),
          10.w,
          Text(
            avatarPath,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
