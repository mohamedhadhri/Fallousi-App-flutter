import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './encours.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
bool _obscureText = true;
class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());

  }
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold( 
    backgroundColor: Color(0xFFFFF1CE),
     body:SafeArea(
      child:Center(
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('https://cdn3.iconfinder.com/data/icons/spring-2-1/30/Newborn_Chicken-512.png',
              height: 150,
              ),
              SizedBox(height: 20,),
              Container(
                child: Text(
                  'BIENVENUE',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
               Text(
                'Veuillez entrer vos identifiants pour se connecter',
                style: GoogleFonts.robotoCondensed(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding( 
                    padding: const EdgeInsets.symmetric(horizontal :20),
                    child: TextField(
                      controller: _emailController,
                      decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Adresse Email'
                      ) ,
                     ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding( 
                    padding: const EdgeInsets.symmetric(horizontal :20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Mot de passe',
                     suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ) ,
                     ),
                  ),
                ),
              ),
              SizedBox(height: 15),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal:25),
               child: GestureDetector(
                child: TextButton(
                onPressed: signIn,
                 child: Container(
                 padding: EdgeInsets.all(16),
                       
                  decoration: BoxDecoration(
                    color:Color(0xFFDEA45F),
                              borderRadius:BorderRadius.circular(12),
                 ),
                  child: Center(
                    child: Text(
                      'Connexion',
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.white,
                      fontWeight:FontWeight.bold,
                      fontSize: 18, 
                    ),
                    )),
                  
                 ),
               ),
             )
        
          )],
          ),
        )
      )
      ),
    );
  }
}
