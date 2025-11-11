import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  deleteDialog(
      {@required BuildContext context,
      @required String content,
      @required Function onPressed}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('حذف'),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('إلغاء'),
              ),
              TextButton(
                onPressed: onPressed,
                child: Text('حذف'),
              )
            ],
          );
        });
  }
}
