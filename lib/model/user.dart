import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:note_app/model/config.dart';

class User {
  int id;
  String name;
  String email;
  String? phone;
  String? address;
  String password;
  String status;
  String? api_token;
  String? created_at;
  String? updated_at;
  String? deleted_at;
  User(
      {required this.id,
      required this.name,
      required this.email,
      this.phone,
      this.address,
      required this.password,
      required this.status,
      this.api_token,
      this.created_at,
      this.updated_at,
      this.deleted_at});
  // factory User.fromJson(Map<String, dynamic> json) {}
  // Map<String, dynamic> toJson() {}
  static Future<void> setToken(String token, String option)async{
    final storage= const FlutterSecureStorage();
    switch(option){
      case 'create': case 'update':
        await storage.write(key: 'api_token', value: token);
        break;
      case 'delete':
        await storage.delete(key: 'api_token');
        break;
    }
  }
  static Future<String> getToken()async{
    const storage= FlutterSecureStorage();
    String? data= await storage.read(key: 'api_token');
    return data??'';
  }
  static Future<Map<String, String>> getHeaders()async{
    String token=await User.getToken();
    Map<String, String> headers= {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    return headers;
  }
  static Future<void> login(BuildContext context,String email, String password)async{
    var url = Uri.http(urlAPI,'/api/v1/user/login');
    var response = await http.post(url,headers: headers, body: jsonEncode({
      'email': email,
      'password': password
    }),);
    var data= json.decode(response.body);
    if(response.statusCode == 200){
      await setToken(data['api_token'], 'create');
      print('thanh cong');
      Navigator.pushNamed(context, '/home');
    }
  }
}
