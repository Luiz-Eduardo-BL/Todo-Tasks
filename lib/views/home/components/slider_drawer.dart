import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todotasks/extensions/space_exs.dart';

import 'package:todotasks/utils/app_colors.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.calendar,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  final List<String> texts = [
    'Home',
    'Calendário',
    'Perfil',
    'Configurações',
    'Sobre',
  ];

  String selectedAvatar = 'assets/lottie/Homem.json';

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.quaternaryGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _showAvatarSelectionDialog(context);
            },
            child: Lottie.asset(
              selectedAvatar,
              width: 150,
              height: 150,
            ),
          ),
          20.h,
          Text(
            'Nome do Usuário',
            style: textTheme.displayMedium
          ),
          Text(
            'Mobile Developer',
            style: textTheme.displaySmall
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            width: double.infinity,
            height: 600,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    log(texts[index] + ' Item Selecionado!');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                        size: 25,
                      ),
                      title: Text(
                        texts[index],
                        style: textTheme.displaySmall
                      ),
                    ),
                  ),
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
          title: Text('Escolha seu Avatar'),
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
            width: 50,
            height: 50,
          ),
          SizedBox(width: 10),
          Text(
            avatarPath,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
