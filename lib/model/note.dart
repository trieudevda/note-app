import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:note_app/model/user.dart';
import 'package:note_app/model/category.dart';

import 'config.dart';
import 'package:http/http.dart' as http;
class Note{
  int id;
  int category_id;
  String title;
  String? description;
  String? created_at;
  String? updated_at;
  String? deleted_at;
  Categories? categories;
  Note({required this.id,required this.category_id,required this.title,this.description,this.created_at,this.updated_at,this.deleted_at,this.categories});
  Note.fromJson(Map<String, dynamic> json)
      : id=json['id'],
        category_id=json['category_id'],
        title=json['title'],
        description=json['description']??'',
        created_at=json['created_at']??'',
        updated_at=json['updated_at']??'',
        deleted_at=json['deleted_at']??'',
        categories=Categories.fromJson(json['category']);
  Map<String, dynamic> toJson() => {
    if(id==0)'id':id,
    'category_id':category_id,
    'title':title,
    'description':description??'',
    'created_at':created_at??'',
    'updated_at':updated_at??'',
    'deleted_at':deleted_at??'',
    'categories':categories
  };
  static Future<List<Map<String, dynamic>>> getFull() async {
    List<Map<String, dynamic>> result=[];
    var url = Uri.http(urlAPI,'/api/v1/note/list');
    Response response = await http.get(url,headers:  await User.getHeaders());
    var data=jsonDecode(response.body);
    var temp=data['note'] as List<dynamic>;
    temp.forEach((element) {
       result.add(element);
    });
    return result;
  }
  static Future<Note> find(int id)async{
    late Note data;
    var url = Uri.http(urlAPI,'/api/v1/note/search/$id');
    Response response = await http.get(url,headers: await User.getHeaders());
    var dataRes=jsonDecode(response.body);
    if(response.statusCode==200){
      data=Note.fromJson(dataRes['note']);
    }
    else{
      print('loi $dataRes');
    }
    return data;
  }
  static Future<void> create(BuildContext context,Note note)async{
    var url = Uri.http(urlAPI,'/api/v1/note/create');
    Response response = await http.post(url,body: jsonEncode(note.toJson()),headers: await User.getHeaders());
    var dataRes=jsonDecode(response.body);
    if(response.statusCode==200){
      Navigator.pushNamed(context, '/home');
    }
    else{
      print('loi $dataRes');
    }
  }
  static Future<void> update(BuildContext context,Note note)async{
    var url = Uri.http(urlAPI,'/api/v1/note/update/${note.id}');
    Response response = await http.post(url,body: jsonEncode(note.toJson()),headers: await User.getHeaders());
    var dataRes=jsonDecode(response.body);
    if(response.statusCode==200 && dataRes['status']=='success'){
      Navigator.pushNamed(context, '/home');
    }
    else{
      print('loi $dataRes');
    }
  }
  static Future<bool> delete(BuildContext context,int id)async{
    var url = Uri.http(urlAPI,'/api/v1/note/delete/$id');
    Response response = await http.get(url,headers:  await User.getHeaders());
    var data=jsonDecode(response.body);
    if(response.statusCode==200 && data['status']=='success')
      return true;
    return false;
  }
}