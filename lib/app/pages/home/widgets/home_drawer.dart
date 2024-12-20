import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/model/user_model.dart';

class HomeDrawer extends StatelessWidget {
  final UserModel userLogged;
  const HomeDrawer({super.key, required this.userLogged});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.indigo,
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: userLogged.pathImage == ''
                    ? const Icon(Icons.person, size: 60)
                    : ClipOval(
                        child: Image.file(
                          File(userLogged.pathImage),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(
                 height: 10,
              ),
              Text(
                userLogged.name,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          )),
          ListTile(
            onTap: () {},
            title: const Text(
              "Meu Perfil",
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(
              Icons.person_sharp,
              color: Colors.white,
            ),
          ),
          ListTile(
            onTap: () {},
            title: const Text(
              "Sair da conta",
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
