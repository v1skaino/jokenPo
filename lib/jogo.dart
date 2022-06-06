import 'dart:math';

import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({ Key? key }) : super(key: key);

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = const AssetImage("images/padrao.png");
  var _mensagem = "Escolha uma opção abaixo";
  var _isStarted = false;
  var _placarPlayer = 0;
  var _placarMaquina = 0;
  var _rodadasJogadas = 0;

  void _opcaoSelecionada(String escolhaUsuario){

    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];
    _isStarted = true;

    switch( escolhaApp ){
      case "pedra" :
        setState(() {
         _imagemApp = const AssetImage("images/pedra.png");
        });
        break;
      case "papel" :
        setState(() {
         _imagemApp = const AssetImage("images/papel.png");
        });
        break;
      case "tesoura" :
        setState(() {
         _imagemApp = const AssetImage("images/tesoura.png");
        });
        break;
    }

    if(
        (escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")
    ){
      setState(() {
        var opcoes = ["Parabéns, você venceu!", "Boa!", "Você ganhou!", "Ai sim!", "Parabéns, você ganhou!", "Você ganhou!"];
        var numero = Random().nextInt(6);
        var _mensagemFinal = opcoes[numero];
       _mensagem = _mensagemFinal;
       _placarPlayer = _placarPlayer + 1;
       _rodadasJogadas = _rodadasJogadas + 1;
      });
    }else if(
        (escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")
    ){
      setState(() {
        var opcoes = ["Não foi dessa vez!", "Quase!", "Vish!", "Tente novamente!", "Você perdeu!", "Não deu!"];
        var numero = Random().nextInt(6);
        var _mensagemFinal = opcoes[numero];
       _mensagem = _mensagemFinal;
       _placarMaquina = _placarMaquina + 1;
        _rodadasJogadas = _rodadasJogadas + 1;
      });
    }else{
      setState(() {
       _mensagem = "Empate!";
       _rodadasJogadas = _rodadasJogadas + 1;
      });
    }
  }

  void _restartGame() {
    setState(() {
      _imagemApp = const AssetImage("images/padrao.png");
      _mensagem = "Escolha uma opção abaixo";
      _isStarted = false;
      _placarPlayer = 0;
      _placarMaquina = 0;
      _rodadasJogadas = 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JokenPo"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
                "Escolha da Máquina",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily : 'RobotoMono'
                ),
              ),
            ),
            Image(image:_imagemApp,),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
               _mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily : 'RobotoMono'
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _opcaoSelecionada("pedra") ,
                  child: Image.asset("images/pedra.png", height: 100,),
                ),
                GestureDetector(
                  onTap: () => _opcaoSelecionada("papel") ,
                  child: Image.asset("images/papel.png", height: 100,),
                ),
                GestureDetector(
                  onTap: () => _opcaoSelecionada("tesoura") ,
                  child: Image.asset("images/tesoura.png", height: 100,),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
               "Usuário || Máquina\n $_placarPlayer X $_placarMaquina\n\nRounds: $_rodadasJogadas",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily : 'RobotoMono'
                ),
              ),
            ),
            _isStarted ? ElevatedButton(
              onPressed: () => _restartGame(),
              child: const Text(
                "Restart",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily : 'RobotoMono'
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              ),
            ) : (
            const SizedBox()),
          ],
        ),
      ),
    );
  }
}