import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interpretador_de_sonhos/resources/key.dart';
import 'package:interpretador_de_sonhos/screens/formulario_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final chatGpt = OpenAiKey().retornaChatGpt();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  Widget _buildImage(String assetName, [double width = 200]) {
    return Image.asset('assets/onboarding/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.amber);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.amber),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );

    return Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fundo.png"), fit: BoxFit.cover),
        ),
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.transparent,
          pages: [
            PageViewModel(
              title: "Bem vindo",
              body:
                  "Bem-vindo ao nosso app de interpretação de sonhos! Aqui, você poderá descobrir o significado dos seus sonhos.",
              // image: _buildImage('onboarding-screen-image-1.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: '',
              body:
                  "Com nossa tecnologia avançada, nós o ajudaremos a explorar o mundo surpreendente e enigmático dos sonhos.",
              // image: _buildImage('onboarding-screen-image-2.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "",
              body:
                  "Comece a desvendar os seus sonhos agora mesmo e descubra uma nova perspectiva sobre si mesmo.",
              // image: _buildImage('onboarding-screen-image-3.png'),
              footer: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Formulario(chatGpt: chatGpt)));
                  },
                  child: const Text(
                    'CONTAR MEU SONHO',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    minimumSize: const Size.fromHeight(55), // NEW
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              decoration: pageDecoration,
            ),
          ],
          showSkipButton: false,
          showDoneButton: false,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: true,
          back: const Text('Voltar',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.amber)),
          next: const Text('Próximo',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.amber)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(8.0, 8.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(15.0, 5.0),
            activeColor: Colors.amber,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ));
  }
}
