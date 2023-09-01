import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/model/user.dart';
import 'package:note_app/view/widget/container.dart';
import 'package:note_app/view/widget/variable.dart';

import '../widget/image/circle.dart';
import '../widget/popup/message_popup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isEye = false;
  _login(context) async {
    await User.login(context,_email.text, _password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          padding: EdgeInsets.only(left: 30, right: 30),
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageCircleWidget(path: 'assets/images/logo.png',),
              sizedBox(height: 2),
              const Text(
                'Đăng Nhập',
                style: title1,
              ),
              sizedBox(height: 1),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _password,
                obscureText: isEye,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: FaIcon(isEye?FontAwesomeIcons.lockOpen:FontAwesomeIcons.lock,size: 16,),
                    onPressed: (){
                      setState(() {
                        isEye=!isEye;
                      });
                    },
                  ),
                ),
              ),
              sizedBox(height: 1),
              ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                child: const Text("Đăng Nhập"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
