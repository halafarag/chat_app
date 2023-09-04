
import 'package:chat_app2/firebase_options.dart';
import 'package:chat_app2/screens/chat_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      LoginScreen.id: (context) => LoginScreen(),
      RigsterScreen.id: (context) => RigsterScreen(),
      ChatScreen.id: (context) => ChatScreen()
    }, debugShowCheckedModeBanner: false, initialRoute: LoginScreen.id);
  }
}
