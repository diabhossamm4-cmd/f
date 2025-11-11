import 'package:flutter/material.dart';

class AddPhonesLists extends StatelessWidget {
  final List<Widget> childern;

  AddPhonesLists({
    this.childern,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: childern,
      shrinkWrap: true,
    );
  }
}
