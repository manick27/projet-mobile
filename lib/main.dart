import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';
import '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Calculatrice App",
        debugShowCheckedModeBanner: false,
        home: CalculatriceApp());
  }
}

class CalculatriceApp extends StatefulWidget {
  const CalculatriceApp({Key? key}) : super(key: key);

  @override
  State<CalculatriceApp> createState() => _CalculatriceAppState();
}

class _CalculatriceAppState extends State<CalculatriceApp> {

  String equation = "0";
  String resultat = "0";
  String expression = "0";

  pressedButton(String e){
    setState(() {
        if(e == "C"){
          equation = "0";
          expression = "0";
        }else if(e == "⌫"){
          equation = equation.substring(0, equation.length - 1);
          if(equation.isEmpty){
            equation = "0";
          }
        }else if(e == "="){
          expression = equation;
          expression = expression.replaceAll("÷", "/");

          try{
            Parser p = Parser();
            Expression epx = p.parse(expression);
            ContextModel cm = ContextModel();
            resultat = "${epx.evaluate(EvaluationType.REAL, cm)}";
            equation = "";
          }catch(e){
            resultat = "Erreur de syntaxe";
            print(e);
          }
        }else{
          if(equation == "0"){
            equation = e;
          }else {
            equation = equation + e;
          }
        }
    });
    print(e);
  }


  Widget CalculatriceButton(
      String texte, Color fontColor, Color backColor, double taille) {
    return Container(
        color: backColor,
        height: MediaQuery.of(context).size.height * 0.1 * taille,
        child: MaterialButton(
            onPressed: ()=> pressedButton(texte),
            padding: const EdgeInsets.all(16),
            child: Text(texte,
                style:
                    TextStyle(color: fontColor, fontWeight: FontWeight.bold))));
  }

  Widget EqualButton(
      String texte, Color fontColor, Color backColor, double taille) {
    return Container(
        color: backColor,
        height: MediaQuery.of(context).size.height * 0.1 * taille,
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
            onPressed: ()=> pressedButton(texte),
            padding: const EdgeInsets.all(16),
            child: Text(texte,
                style:
                TextStyle(color: fontColor, fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height * 0.05 * taille))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculatrice"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              equation,
              style: TextStyle(fontSize: 40),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              resultat,
              style: TextStyle(fontSize: 50),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [

                    TableRow(
                      children: [
                        CalculatriceButton("1", Colors.black, Colors.grey, 1),
                        CalculatriceButton("2", Colors.black, Colors.grey, 1),
                        CalculatriceButton("3", Colors.black, Colors.grey, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        CalculatriceButton("4", Colors.black, Colors.grey, 1),
                        CalculatriceButton("5", Colors.black, Colors.grey, 1),
                        CalculatriceButton("6", Colors.black, Colors.grey, 1),
                      ],
                    ),

                    TableRow(
                      children: [
                        CalculatriceButton("7", Colors.black, Colors.grey, 1),
                        CalculatriceButton("8", Colors.black, Colors.grey, 1),
                        CalculatriceButton("9", Colors.black, Colors.grey, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        CalculatriceButton("0", Colors.black, Colors.grey, 1),
                        CalculatriceButton(".", Colors.black, Colors.grey, 1),
                        CalculatriceButton("C", Colors.black, Colors.grey, 1),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        CalculatriceButton("+", Colors.black, Colors.grey, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        CalculatriceButton("-", Colors.black, Colors.grey, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        CalculatriceButton("*", Colors.black, Colors.grey, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        CalculatriceButton("/", Colors.black, Colors.grey, 1),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            child: EqualButton("=", Colors.white, Colors.blueAccent, 1),
          )
        ],
      ),
    );
  }
}
