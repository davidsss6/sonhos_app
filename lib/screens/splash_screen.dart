import 'dart:async';

import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter/material.dart';
import 'package:interpretador_de_sonhos/screens/formulario_screen.dart';
import 'package:interpretador_de_sonhos/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/key.dart';

class SplashScreem extends StatefulWidget {
  @override
  _SplashScreemState createState() => _SplashScreemState();
}

class _SplashScreemState extends State<SplashScreem> {
  late SharedPreferences prefs;
  final chatGpt = OpenAiKey().retornaChatGpt();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void inicializaApp() async {
    prefs = await SharedPreferences.getInstance();
    Timer(Duration(seconds: 5), () {
      if (prefs.getBool("intro") != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => Formulario(chatGpt: chatGpt)));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => OnboardingScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    inicializaApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff191410),
        padding: EdgeInsets.all(60),
        child: Center(
          child: Image.asset("assets/logo.png", width: 1000, height: 1000),
        ),
      ),
    );
  }
}
