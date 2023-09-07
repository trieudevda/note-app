import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:note_app/model/user.dart';

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
        name=json['name'],
        slug=json['slug']??'',
        description=json['description']??'',
        img_url=json['img_url']??'',
        created_at=json['created_at']??'',
        updated_at=json['updated_at']??'',
        deleted_at=json['deleted_at']??'';

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug??'',
    'description': description??'',
    'img_url': img_url??'',
    'created_at': created_at??'',
    'updated_at': updated_at??'',
    'deleted_at': deleted_at??'',
  };
  static Future<List<Categories>> getAll()async{
    List<Categories> cate=[];
    var url = Uri.http(urlAPI,'/api/v1/category/list');
    Response response = await http.get(url,headers: await User.getHeaders());
    var dataRes=jsonDecode(response.body);
    var temp=dataRes['category'] ;
    temp.forEach((element) {
      cate.add(Categories.fromJson(element));
    });
    return cate;
  }
  static Future<Categories> find(int id)async{
    late Categories data;
    var url = Uri.http(urlAPI,'/api/v1/category/search/$id');
    Response response = await http.get(url,headers: await User.getHeaders());
    var dataRes=jsonDecode(response.body);
    if(response.statusCode==200){
      data=Categories.fromJson(dataRes);
    }
    else{
      print('loi $dataRes');
    }
    return data;
  }
}