import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/padrao.png");
  var _resultadoFinal = "Boa sorte!!!";
  int _pontosUsuario = 0;
  int _pontosApp = 0;

  void _opcaoSelecionada(String escolhaUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];

    // Atualiza a imagem do app
    setState(() {
      _imagemApp = AssetImage("images/$escolhaApp.png");
    });

    // Lógica do jogo e atualização do placar
    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      setState(() {
        _resultadoFinal = "Parabéns!!! Você ganhou :)";
        _pontosUsuario++;
      });
    } else if ((escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")) {
      setState(() {
        _resultadoFinal = "Puxa!!! Você perdeu :(";
        _pontosApp++;
      });
    } else {
      setState(() {
        _resultadoFinal = "Empate!!! Tente novamente :/";
      });
    }
  }

  void _resetarPlacar() {
    setState(() {
      _pontosUsuario = 0;
      _pontosApp = 0;
      _resultadoFinal = "Boa sorte!!!";
      _imagemApp = AssetImage("images/padrao.png");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('JokenPO'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Placar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Placar - Você: $_pontosUsuario | App: $_pontosApp",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Escolha do App
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Imagem do App
          Image(image: _imagemApp),

          // Resultado colorido
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              _resultadoFinal,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _resultadoFinal.contains("ganhou")
                    ? Colors.yellow
                    : _resultadoFinal.contains("perdeu")
                        ? Colors.red
                        : Colors.blue,
              ),
            ),
          ),

          // Opções do usuário
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 10),
            child: Text(
              "Escolha uma opção abaixo:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _opcaoJogador("pedra"),
              _opcaoJogador("papel"),
              _opcaoJogador("tesoura"),
            ],
          ),

          // Botão para resetar placar
          Padding(
            padding: EdgeInsets.only(),
            child: ElevatedButton(
              onPressed: _resetarPlacar,
              child: Text("Reiniciar Placar"),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para cada opção do jogador
  Widget _opcaoJogador(String escolha) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _opcaoSelecionada(escolha),
          child: Image(
            image: AssetImage('images/$escolha.png'),
            height: 100,
          ),
        ),
        Text(
          escolha.toUpperCase(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
