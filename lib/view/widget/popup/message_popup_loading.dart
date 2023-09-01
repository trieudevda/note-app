import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
Future<void> messagePopupLoading(BuildContext context,String title,String content,String path,var data,int param) async {
  EasyLoading.dismiss();
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Không đồng ý');
            },
            child: const Text('Không đồng ý'),
          ),
          TextButton(
            onPressed: (){
              data?.delete(context,param);
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