import 'package:flutter/material.dart';
import 'package:note_app/model/category.dart';
import 'package:note_app/model/user.dart';
import 'package:note_app/view/widget/drawer/drawer.dart';

import '../../model/note.dart';
import '../widget/container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {  return false; },
      child: Scaffold(
          appBar: AppBar(
              // automaticallyImplyLeading: false,
              title: Text('Trang chủ'),
          ),
          body: FutureBuilder(
            future: Note.getFull(),
            builder: (context,snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return Center(child: Text('loi $snapshot.hasError'),);
              }
              if(!snapshot.hasData){
                return Center(child: Text('khong co du lieu'));
              }
              List<Widget> data=[];
              List<Map<String,dynamic>> dataRes=snapshot.data as List<Map<String,dynamic>>;
              Categories cate;
              Note note;
              for (var element in dataRes) {
                cate=Categories.fromJson(element['category']);
                note=Note(id: element['id'],category_id: element['category_id'],title: element['title'],description: element['description'],created_at: element['created_at'],updated_at: element['updated_at'],categories:cate);
                data.add(itemList(context,note));
              }
              return SingleChildScrollView(
                child: Column(
                  children: data,
                ),
              );
            },
          ),
        drawer: DrawerCustom(),
        floatingActionButton: FloatingActionButton(
          child:const  Icon(Icons.add),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () => {
            Navigator.pushNamed(context, '/create-note')
          },
        ),
      ),
    );
  }
}
