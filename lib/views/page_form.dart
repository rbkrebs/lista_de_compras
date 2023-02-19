import 'dart:convert';
import 'package:projeto_final/views/shared_preferences_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/tela_lista_controller.dart';
import 'package:location/location.dart';

class PageForm extends StatefulWidget {
  @override
  _PageFormState createState() => _PageFormState();
}

class _PageFormState extends State<PageForm> {
  Tela1Controller controller = Tela1Controller();
  ImagePicker imagePicker = ImagePicker();

  String dropdownValue = 'Bebida';
  bool disableButton = true;
  LocationData? locationData;
  SharedPreferencesConfig sharedPreferencesConfig = SharedPreferencesConfig();

  @override
  void initState() {
    super.initState();
    sharedPreferencesConfig.initSharedPreferences();
    Location.instance.getLocation().then(
          (value) => {
            setState(() {
              controller.latitude = value.latitude.toString();
              controller.longitude = value.longitude.toString();
            })
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro de produto"),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            children: [
              TextField(
                  controller: controller.itemNomeTD,
                  decoration:
                      const InputDecoration(hintText: 'Nome do produto')),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 4,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    controller.itemDescricaoTD.text = newValue;
                  });
                },
                items: <String>[
                  'Bebida',
                  'Carne',
                  'Frios',
                  'Doce',
                  'Salgados',
                  'Frutas',
                  'Verduras',
                  'Legumes'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Container(
                child: TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: controller.itemValorTD,
                    decoration:
                        const InputDecoration(hintText: 'Valor do produto')),
              ),
              ElevatedButton(
                onPressed: () {
                  imagePicker
                      .pickImage(source: ImageSource.camera, imageQuality: 50)
                      .then((XFile? value) =>
                          value!.readAsBytes().then((bytes) => {
                                setState(() {
                                  disableButton = false;
                                  controller.image = base64.encode(bytes);
                                })
                              }));
                },
                child: const Text('Escolher foto'),
              ),
              ElevatedButton(
                onPressed: disableButton
                    ? null
                    : () {
                        controller.salvarItem();
                        Navigator.pop(context);
                      },
                child: const Text('Adicionar'),
              ),
            ],
          ),
        ));
  }
}
