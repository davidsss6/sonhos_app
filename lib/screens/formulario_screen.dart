import 'dart:async';

import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/question_answer.dart';
import '../resources/chatmessage.dart';
import '../resources/popups.dart';
import '../resources/threedots.dart';

const int maxFailedLoadAttempts = 3;

class Formulario extends StatefulWidget {
  final ChatGpt chatGpt;

  const Formulario({Key? key, required this.chatGpt}) : super(key: key);

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _text;
  String _texto_espera = "";

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerTexto = TextEditingController();
  final List<ChatMessage> _messages = [];
  String textoRetornado = "";

  StreamSubscription? _subscription;
  bool _isTyping = false;
  bool _respondeu = false;

  PopUpsGenericos popUp = PopUpsGenericos();

  late SharedPreferences prefs;
  final List<QuestionAnswer> questionAnswers = [];

  @override
  void initState() {
    super.initState();
    print("OXB texto init");
    // _sendMessageInicial();
    inicializaApp();
  }

  void inicializaApp() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _checaIaRespondeu() {
    Timer(Duration(seconds: 70), () {
      if (_respondeu == false) {
        setState(() {
          _isTyping = false;
          _texto_espera = "";
        });
        popUp.exibePopUpErroNaResposta(context, _controllerNome.text);
      }
    });
  }

  _sendChatMessage() async {
    String textoIntroducao =
        "Ignore todas as intrucoes anteriores a esta. Voce é um estudioso do esoterismo especializado em interpretacao dos sonhos. Ha 20 anos voce ajuda a interpretar os sonhos das pessoas. Sua tarefa agora é interpretar um sonho que vou te contar, segundo os seus conhecimentos em esoterismo. Caso nao saiba interpretar o sonho, envie uma mensagem gentil. O sonho foi: ";
    ChatMessage message =
        ChatMessage(text: _controllerTexto.text, sender: "user");
    String textopergunta = message.text;
    final question = textoIntroducao + textopergunta;

    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
      _texto_espera = "Interpretando seu sonho. Aguarde...";
      _controllerTexto.clear();
      questionAnswers.add(
        QuestionAnswer(
          question: question,
          answer: StringBuffer(),
        ),
      );
    });

    final request = ChatCompletionRequest(
      maxTokens: 4000,
      messages: [Message(role: Role.user.name, content: question)],
      model: "gpt-3.5-turbo",
      temperature: 0.0,
      // model: ChatGptModel.gpt41106Preview.modelName,
    );
    await _chatStreamResponse(request);

    setState(() => _isTyping = true);
  }

  _chatStreamResponse(ChatCompletionRequest request) async {
    try {
      final response = await widget.chatGpt.createChatCompletion(request);
      final content = response?.choices?.first.message?.content;

      setState(() {
        textoRetornado = content!;
        _respondeu = true;
        _isTyping = false;
        _texto_espera = "";
      });

      popUp.exibePopUpSonho(context, textoRetornado, _controllerNome.text);
    } catch (error) {
      print("OXB Erro:" + error.toString());
      setState(() {
        _isTyping = false;
        _texto_espera = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // title: Text("Descreva seu sonho", style: TextStyle(color: Colors.amber),),
          backgroundColor: Color(0xff191410),
        ),
        body: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/fundo2.png"), fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Text(
                        "Conte aqui seu sonho",
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.amber),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Escreva de uma forma clara e resumida em até 200 palavras, com o que voce sonhou. Se preferir, use o botão do microfone e fale o seu sonho",
                        style: TextStyle(fontSize: 19.0, color: Colors.amber),
                      ),
                      SizedBox(height: 32.0),
                      Card(
                        color: Colors.orangeAccent,
                        child: Container(
                            padding: EdgeInsets.all(1.0),
                            child: Column(
                              children: <Widget>[
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        controller: _controllerNome,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText: "Digite seu nome",
                                          fillColor: Colors.white,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Por favor, digite seu nome';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) => _name = value,
                                      ),
                                      SizedBox(height: 16.0),
                                      TextFormField(
                                        style: TextStyle(color: Colors.white),
                                        controller: _controllerTexto,
                                        decoration: InputDecoration(
                                            hintText: "Escreva aqui seu sonho",
                                            fillColor: Colors.white,
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.all(50)),
                                        maxLines: null,
                                        // pra permitir mais de uma linha
                                        keyboardType: TextInputType.multiline,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Por favor, digite seu sonho';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) => _text = value,
                                      ),
                                      SizedBox(height: 16.0),
                                    ],
                                  ),
                                ),
                                if (_isTyping) const ThreeDots(),
                                Text(
                                  _texto_espera,
                                  style: TextStyle(
                                      fontSize: 19.0, color: Colors.white),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 32.0),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.setBool("intro", true);
                            _sendChatMessage();
                            _checaIaRespondeu();
                          }
                        },
                        child: const Text(
                          'ENVIAR',
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
                    ],
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
