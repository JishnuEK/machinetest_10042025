import 'package:flutter/material.dart';

class CustomLoading {
  static Widget defaultLoading(context) {
    return Container(
      color: const Color.fromARGB(9, 0, 0, 0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          width: 65,
          height: 65,
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }
}
