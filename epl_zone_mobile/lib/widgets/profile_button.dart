import 'package:epl_zone/core/util/constant.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        child: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      onSelected: (value) {
        switch (value) {
          case 'search':
            Navigator.pushNamed(context, RoutePlayerData);
            break;
          case 'settings':
            Navigator.pushNamed(context, RouteUser);
            break;
          case 'logout':
            Navigator.pushReplacementNamed(context, RouteSignIn);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'search',
          child: ListTile(
            leading: Icon(Icons.person_outlined),
            title: Text('search'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Sign Out', style: TextStyle(color: Colors.red)),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}