import 'package:flutter/material.dart';
Future<void> messagePopup(BuildContext context,String title,String content,String path) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'Không đồng ý'),
          //   child: const Text('Không đồng ý'),
          // ),
          TextButton(
            onPressed: () {
              if(path.isEmpty) {
                Navigator.pop(context, 'Đồng ý');
              }else{
                Navigator.pushNamed(context, '/$path');
              }
            },
            child: const Text('Đồng ý'),
          ),
        ],
      );
    },
  );
}