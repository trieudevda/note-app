import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:note_app/view/auth/login.dart';
import 'package:note_app/view/home/home.dart';
import 'package:note_app/view/note/create.dart';
import 'package:note_app/view/note/update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      builder: EasyLoading.init(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/home': (context) => const HomePage(),
        '/create-note': (context) => const CreateNotePage(),
      },
    );
  }
}
