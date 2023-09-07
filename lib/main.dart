import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:note_app/model/user.dart';
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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const LoginPage(),
        home: FutureBuilder(
          future: User.loginFromToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              EasyLoading.show(status: 'Đang tải...');
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Lỗi đăng nhập'),
              );
            }
            if (snapshot.hasData) {
              EasyLoading.dismiss();
              return snapshot.data ? const HomePage() : const LoginPage();
            }
            return Container();
          },
        ),
        builder: EasyLoading.init(),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/login':(context)=>const LoginPage(),
          '/home': (context) => const HomePage(),
          '/create-note': (context) => const CreateNotePage(),
          // '/update-note': (context) => UpdateNotePage(note: ModalRoute.of(context).settings.arguments),
        },
      ),
    );
  }
}
