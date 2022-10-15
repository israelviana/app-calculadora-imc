import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    setState((){
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculate(){
    setState((){
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double imc = weight/(height * height);
      if (imc < 18.6){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      }else if (imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      }else if (imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      }else if (imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      }else if (imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      }else if (imc >=40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          actions: [IconButton(onPressed: () {_resetFields();}, icon: Icon(Icons.refresh))],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 120.0, color: Colors.blueGrey),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Peso (kg)"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                  controller: weightController,
                  validator: (value){
                    if (value!.isEmpty){
                      return "Insira seu Peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Altura (cm)"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                  controller: heightController,
                  validator: (value){
                    if (value!.isEmpty){
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                      onPressed:(){
                        if(_formKey.currentState!.validate()){
                          calculate();
                        }
                      },
                      child: const Text('Calcular', style: TextStyle(color: Colors.white, fontSize: 25.0)
                      ),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
