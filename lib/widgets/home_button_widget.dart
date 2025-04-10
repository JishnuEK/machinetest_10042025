// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomIconWidget(icon: Icons.search),
        SizedBox(width: 10),
        CustomIconWidget(icon: Icons.mail),
        SizedBox(width: 10),
        CustomIconWidget(icon: Icons.notifications_none_outlined),
        SizedBox(width: 10),
        CustomIconWidget(icon: Icons.menu),
      ],
    );
  }
}

class CustomIconWidget extends StatelessWidget {
  final IconData icon;
  const CustomIconWidget({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(0xff131929),
      radius: 18,
      child: Icon(
        icon,
        color: Theme.of(context).primaryColor,
        size: 18,
      ),
    );
  }
}
