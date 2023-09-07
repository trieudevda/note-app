import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:note_app/model/user.dart';
import 'package:note_app/view/widget/container.dart';

import '../variable.dart';

class DrawerCustom extends StatelessWidget {
  DrawerCustom({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: FutureBuilder<User>(
                future: User.getUser(),
                builder: (BuildContext context,AsyncSnapshot snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    EasyLoading.show(status: 'Đang tải');
                  }
                  if(snapshot.hasError){
                    EasyLoading.dismiss();
                    return Center(child: Text('có lỗi ${snapshot.error}'),);
                  }
                  if(!snapshot.hasData){
                    EasyLoading.dismiss();
                    return Center(child: Text('Không có dữ liệu'),);
                  }
                  EasyLoading.dismiss();
                  return Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap:(){
                            print('cje');
                          },
                          child: ClipRRect(
                            borderRadius:BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/avarta.jpg',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100
                            ),
                          ),
                        ),
                        sizedBox(height: .3),
                        Text('Nguyễn Thanh Triều',style: title2,)
                        // Text(snapshot.data.name,style: title2,)
                      ],
                    ),
                  );
                }
            ),
          ),
          ListTile(
            title: const Text('Danh mục'),
            onTap: () {

            },
          ),
          ListTile(
            title: const Text('Ghi chú'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
