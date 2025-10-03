import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _precoAController = TextEditingController();
  TextEditingController _quantidadeLitrosController = TextEditingController();

  TextEditingController _precoBController = TextEditingController();
  TextEditingController _quantidadeMlController = TextEditingController();

  String _resultado = 'Informe seus dados';
  IconData _icone = Icons.calculate;

  void _calcular() {
    double? precoA = double.tryParse(_precoAController.text);
    double? quantidadeLitros = double.tryParse(
      _quantidadeLitrosController.text,
    );
    double? precoB = double.tryParse(_precoBController.text);
    double? quantidadeMl = double.tryParse(_quantidadeMlController.text);

    if (precoA == null ||
        quantidadeLitros == null ||
        precoB == null ||
        quantidadeMl == null ||
        precoA <= 0 ||
        quantidadeLitros <= 0 ||
        precoB <= 0 ||
        quantidadeMl <= 0) {
      setState(() {
        _resultado = 'Digite valores válidos!';
        _icone = Icons.error;
      });
      return;
    }

    double quantidadeConvertida = quantidadeMl / 1000;
    double relacaoA = precoA / quantidadeLitros;
    double relacaoB = precoB / quantidadeConvertida;
    double porcentagemDiferenca;

    if (relacaoA < relacaoB) {
      porcentagemDiferenca = ((relacaoB - relacaoA) / relacaoB) * 100;
    } else {
      porcentagemDiferenca = ((relacaoA - relacaoB) / relacaoA) * 100;
    }
    ;

    setState(() {
      if (relacaoA < relacaoB) {
        _resultado =
            'Relação do Liquido em Litros ${relacaoA} \n'
            'Relação Liquido em Mililitros ${relacaoB} \n'
            'A opção A é mais vantagem, com diferença de ${porcentagemDiferenca.toStringAsFixed(1)}%';
      } else if (relacaoB < relacaoA) {
        _resultado =
            'Relação do Liquido Litros ${relacaoA} \n'
            'Relação Liquido Mililitros ${relacaoB} \n'
            'A opção B é mais vantagem, com diferença de ${porcentagemDiferenca.toStringAsFixed(1)}%';
      } else if (relacaoA == relacaoB) {
        _resultado =
            'Relação do Liquido Litros ${relacaoA} \n'
            'Relação Liquido Mililitros ${relacaoB} \n'
            'São iguais';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Liquido A ou B', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Liquido A em Litros',
              style: TextStyle(color: Colors.deepPurple, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              controller: _quantidadeLitrosController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Quantidade do líquido A (litros)',
                labelStyle: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              controller: _precoAController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Preço do líquido A (R\$)',
                labelStyle: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Liquido B em Mililitros',
              style: TextStyle(color: Colors.deepPurple, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              controller: _quantidadeMlController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Quantidade do líquido B (ml)',
                labelStyle: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              controller: _precoBController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Preço do líquido B (R\$)',
                labelStyle: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 30),
            height: 50,
            width: 200,
            child: ElevatedButton(
              child: const Text(
                'Calcular',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: _calcular,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    _resultado,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
