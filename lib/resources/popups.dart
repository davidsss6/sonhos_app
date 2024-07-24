import 'package:flutter/material.dart';

class PopUpsGenericos {
  PopUpsGenericos() {}

  exibePopUpNaoAssistiuAnuncio(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erro"),
            // content: Text(sonho),
            content: SingleChildScrollView(
              // won't be scrollable
              child: Text(
                  "Voce não assistiu o anuncio até o fim. Tente novamente e assita até o fim o anuncio exibido para ganhar sua recompensa"),
            ),
            contentPadding: EdgeInsets.all(16),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                },
              ),
            ],
          );
        });
  }

  exibePopUpErroNoAnuncio(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erro"),
            // content: Text(sonho),
            content: SingleChildScrollView(
              // won't be scrollable
              child: Text(
                  "Infelizmente não conseguimos exibir o anúncio para desbloquear esta função.\n\nTente novamente mais tarde..."),
            ),
            contentPadding: EdgeInsets.all(16),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                },
              ),
            ],
          );
        });
  }

  exibePopUpErroNaResposta(BuildContext context, String nome) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erro"),
            // content: Text(sonho),
            content: SingleChildScrollView(
              // won't be scrollable
              child: Text("Desculpe " +
                  nome +
                  ", mas o nosso decifrador de sonhos parece estar dormindo. Tente novamente mais tarde"),
            ),
            contentPadding: EdgeInsets.all(16),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                },
              ),
            ],
          );
        });
  }

  exibePopUpSonho(BuildContext context, String sonho, String nome) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Sonho"),
            // content: Text(sonho),
            content: SingleChildScrollView(
              // won't be scrollable
              child: Text(nome + ". " + sonho),
            ),
            contentPadding: EdgeInsets.all(16),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                },
              ),
            ],
          );
        });
  }
}
