
import 'package:chat_app2/constant.dart';
import 'package:chat_app2/screens/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_button.dart';
import '../widgets/text_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  height: 150,
                  child: Image.asset('assets/images/photo.png.webp'),
                ),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFFB022561),
                      fontFamily: 'pacifico'),
                ),
                const Spacer(
                  flex: 1,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFFB022561),
                          fontFamily: 'pacifico'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFeild(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFeild(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await SignInUser();
                        Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'Login',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'dont forget? ',
                      style: TextStyle(color: Color(0xFFB022561), fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RigsterScreen.id);
                      },
                      child: const Text(
                        ' Register',
                        style:
                            TextStyle(color: Color(0xFFB022561), fontSize: 17),
                      ),
                    )
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> SignInUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
