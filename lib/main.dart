
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'auth.dart';
import 'encours.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
     WidgetsFlutterBinding.ensureInitialized();
  

WidgetsFlutterBinding.ensureInitialized();
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
 FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  runApp( const MyApp());
}



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Container(
        width:100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/falousi.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: 
       AnimatedSplashScreen(
        splash: Container(
          height: 700,
          width: 430,
          child: Lottie.asset(
            'assets/animations/22091-little-chicken.json',
            fit: BoxFit.cover,
          ),
        ),
        nextScreen: Auth(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 4000, //  4 seconds
        backgroundColor: Color(0xb2dea35f),

      ),
    ),
    );
  }
}



