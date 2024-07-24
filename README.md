# 🌙 Interpretador de Sonhos com IA 🌙

## Introdução

Bem-vindos ao **Interpretador de Sonhos com IA**, um aplicativo inovador desenvolvido para interpretar sonhos utilizando tecnologias avançadas de Inteligência Artificial. Este projeto foi criado como parte do curso da DIO: **Microsoft Copilot AI**, e estou animado para compartilhar os detalhes com vocês!

## Tecnologias Utilizadas

- **Linguagem de Programação**: Dart
- **Framework**: Flutter
- **IDE**: Android Studio
- **API**: OpenAI

## Funcionalidades

Nosso aplicativo permite que os usuários descrevam seus sonhos e recebam uma interpretação detalhada, tudo graças ao poder da API da OpenAI.

## 🚀 Como Funciona?

1. **Entrada do Usuário**: O usuário digita o seu nome e a descrição do sonho no formulário do aplicativo.
2. **Envio da Pergunta**: A descrição do sonho é enviada para a API da OpenAI.
3. **Interpretação da IA**: A IA, usando os poderosos modelos da OpenAI, interpreta o sonho.
4. **Resposta ao Usuário**: A interpretação do sonho é retornada ao usuário no aplicativo.

## 📱 Interface do Usuário

Para a interface do usuário, utilizamos Flutter, uma poderosa ferramenta de desenvolvimento que permite criar interfaces nativas para iOS e Android.

### Tela de Entrada
![Tela de Entrada](https://github.com/davidsss6/sonhos_app/blob/main/tela_de_entrada.png)

### Tela do formulario
![Tela de Resposta](https://github.com/davidsss6/sonhos_app/blob/main/tela_formulario.png)

## 🛠️ Desenvolvimento


## Integração com a API da OpenAI

Para integrar nosso aplicativo com a API da OpenAI, utilizamos o seguinte código:

```dart

final chatGpt = ChatGpt(apiKey: "sua-api-key-aqui");

  _sendChatMessage() async {
    String textoIntroducao =
        "Ignore todas as intrucoes anteriores a esta. Voce é um estudioso na interpretacao dos sonhos. Ha 20 anos voce ajuda a interpretar os sonhos das pessoas. Sua tarefa agora é interpretar um sonho que vou te contar, segundo os seus conhecimentos em esoterismo. Caso nao saiba interpretar o sonho, envie uma mensagem gentil. O sonho foi: ";
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

```

## 🤖 Ferramentas Adicionais

- **ChatGPT:** Utilizamos o ChatGPT para gerar os textos do aplicativo e os códigos de integração da API.
- **Midjourney:** As imagens utilizadas no aplicativo foram geradas utilizando o Midjourney.

## Conclusão

Este projeto demonstra o poder da Inteligência Artificial e como ela pode ser utilizada para criar aplicativos inovadores e úteis. A interpretação dos sonhos é apenas um exemplo das inúmeras possibilidades que a IA pode oferecer.

Espero que tenha gostado e estou aberto a perguntas e discussões!

### **Developed by:** Davidson