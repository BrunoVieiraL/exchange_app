import 'package:converter_moedas/component/text_field_component.dart';
import 'package:converter_moedas/controller/api_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();
  APIController controller = APIController();

  late double dolar;
  late double euro;

  void clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void realChanged(String text) {
    if (text.isEmpty) {
      clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void dolarChanged(String text) {
    if (text.isEmpty) {
      clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void euroChanged(String text) {
    if (text.isEmpty) {
      clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(title: const Center(child: Text('Conversor de Moedas'))),
      body: FutureBuilder<Map>(
          future: controller.getData,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                    child: Text(
                  "Carregando Dados...",
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              default:
                if (snapshot.hasError) {
                  return const Center(
                      child: Text("Erro ao Carregar Dados",
                          style:
                              TextStyle(color: Colors.orange, fontSize: 25.0),
                          textAlign: TextAlign.center));
                } else {
                  dolar = snapshot.data?["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data?["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Icon(Icons.monetization_on,
                            size: 150.0, color: Colors.amber),
                        TextFieldCustomWidget(
                            label: "Reais",
                            prefix: "R\$",
                            controller: realController,
                            onChanged: realChanged),
                        const Divider(),
                        TextFieldCustomWidget(
                            label: "Dólares",
                            prefix: "US\$",
                            controller: dolarController,
                            onChanged: dolarChanged),
                        const Divider(),
                        TextFieldCustomWidget(
                          label: 'Euros',
                          prefix: "€",
                          controller: euroController,
                          onChanged: euroChanged,
                        ),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}
