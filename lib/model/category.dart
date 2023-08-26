import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:note_app/model/user.dart';
import 'package:note_app/widget/exist.dart';

import 'config.dart';

class Categories{
  int id;
  String name;
  String? slug;
  String? description;
  String? img_url;
  String? created_at;
  String? updated_at;
  String? deleted_at;
  Categories(
      {required this.id,required this.name,this.slug, this.description, this.img_url, this.created_at, this.updated_at, this.deleted_at});
  Categories.fromJson(Map<String, dynamic> json)
      : id=json['id'],
        name=existString(json['name']),
        slug=existString(json['slug']),
        description=existString(json['description']),
        img_url=existString(json['img_url']),
        created_at=existString(json['created_at']),
        updated_at=existString(json['updated_at']),
        deleted_at=existString(json['deleted_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'description': description,
    'img_url': img_url,
    'created_at': created_at,
    'updated_at': updated_at,
    'deleted_at': deleted_at,
  };
  static Future<List<Map<String,dynamic>>> getAll()async{
    List<Map<String,dynamic>> data=[];
    var url = Uri.http(urlAPI,'/api/v1/category/list');
    Response response = await http.get(url,headers: await User.getHeaders());
    var dataRes=jsonDecode(response.body);
    var temp=dataRes['category'] ;
    temp.forEach((element) {
      data.add(element);
    });
    return data;
  }
  static Future<Map<String,dynamic>> find(int id)async{
    Map<String,dynamic> data={};
    var url = Uri.http(urlAPI,'/api/v1/category/search/$id');
    Response response = await http.get(url,headers: await User.getHeaders());
    var dataRes=jsonDecode(response.body);
    if(response.statusCode==200){
      data=dataRes;
    }
    else{
      print('loi $dataRes');
    }
    return data;
  }
}