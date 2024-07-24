# 🌙 Interpretador de Sonhos com IA 🌙

## Introdução

Bem-vindos ao **Interpretador de Sonhos com IA**, um aplicativo inovador desenvolvido para interpretar sonhos utilizando tecnologias avançadas de Inteligência Artificial. Este projeto foi criado como parte do curso sobre Inteligência Artificial, e estamos animados para compartilhar os detalhes com vocês!

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
![Tela de Entrada](path/to/image)

### Tela de Resposta
![Tela de Resposta](path/to/image)

## 🛠️ Desenvolvimento

### Código do Formulário

Aqui está um trecho do código Dart utilizado para criar o formulário onde o usuário insere seus dados e o sonho:

```dart
final _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  return Form(
    key: _formKey,
    child: Column(
      children: <Widget>[
        TextFormField(
          controller: _controllerNome,
          decoration: InputDecoration(
            hintText: "Digite seu nome",
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor, digite seu nome';
            }
            return null;
          },
          onSaved: (value) => _name = value,
        ),
        TextFormField(
          controller: _controllerTexto,
          decoration: InputDecoration(
            hintText: "Escreva aqui seu sonho",
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor, digite seu sonho';
            }
            return null;
          },
          onSaved: (value) => _text = value,
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              _sendChatMessage();
            }
          },
          child: const Text('ENVIAR'),
        ),
      ],
    ),
  );
}

Integração com a API da OpenAI

Para integrar nosso aplicativo com a API da OpenAI, utilizamos o seguinte código:

dart

final chatGpt = ChatGpt(apiKey: "sua-api-key-aqui");

Future<void> _sendChatMessage() async {
  final request = ChatCompletionRequest(
    model: "gpt-4",
    messages: [
      {"role": "user", "content": "Descreva seu sonho aqui"}
    ],
  );

  final response = await chatGpt.createChatCompletion(request);
  print(response.choices[0].message.content);
}

🤖 Ferramentas Adicionais

    ChatGPT: Utilizamos o ChatGPT para gerar os textos do aplicativo e os códigos de integração da API.
    Midjourney: As imagens utilizadas no aplicativo foram geradas utilizando o Midjourney.

Conclusão

Este projeto demonstra o poder da Inteligência Artificial e como ela pode ser utilizada para criar aplicativos inovadores e úteis. A interpretação dos sonhos é apenas um exemplo das inúmeras possibilidades que a IA pode oferecer.

Esperamos que tenham gostado da apresentação e estamos abertos para perguntas e discussões!

Feito com ❤️ por Davidson