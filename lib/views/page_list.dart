import 'package:flutter/material.dart';
import 'package:projeto_final/apis/notifications_api.dart';
import 'package:projeto_final/service/db.dart';
import 'package:projeto_final/views/push_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/tela_lista_controller.dart';
import '../views/page_form.dart';
import 'dart:convert';
import 'package:projeto_final/views/shared_preferences_init.dart';

class PageList extends StatefulWidget {
  PageList({Key? key}) : super(key: key);

  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  Tela1Controller controller = Tela1Controller();

  bool loading = true;
  SharedPreferencesConfig sharedPreferencesConfig = SharedPreferencesConfig();

  @override
  void initState() {
    super.initState();
    sharedPreferencesConfig.initSharedPreferences();
    BancoDeDados().openDb().whenComplete(_carregar);
    NotificationApi.init();
    listenNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Compras"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  controller.deletarTodos();
                  _carregar();
                });
              },
              child: const Icon(
                Icons.close,
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: [
                  const Text("Rotina de envio de notificações"),
                  Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Text(
                              "${sharedPreferencesConfig.timeInterval != null ? sharedPreferencesConfig.sharedPreferences!.getString('freq') : ''}"),
                          const Spacer(),
                          InkWell(
                            child: const Text("alterar"),
                            onTap: () => {
                              Navigator.pop(context),
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return ConfigNotifications();
                              })).then((_) => setState(() {}))
                            },
                          )
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Flexible(
                  child: _lista(),
                ),
              ],
            ),
      bottomSheet: Container(
        child: Text("Total: R\$ ${_total()}"),
        margin: EdgeInsets.all(20),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return PageForm();
          })).then((_) => _carregar())
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _lista() {
    return controller.itens.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.only(bottom: 60, top: 20),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    controller.deletarItem(index);
                    _carregar();
                  });
                },
                child: ListTile(
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    controller.itens[index].nome!,
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Column(
                    children: [
                      Text("R\$ ${controller.itens[index].valor}"),
                      Text(
                          "Lat: ${controller.itens[index].lat} - Long: ${controller.itens[index].long}"),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.memory(
                          base64.decode(controller.itens[index].imagem!),
                          fit: BoxFit.fill,
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: controller.itens.length)
        : const Center(
            child: Text("Lista Vazia"),
          );
  }

  _total() {
    if (controller.itens.isEmpty) {
      return "0.00";
    } else {
      return controller.itens
          .map((e) => double.parse(e.valor!))
          .reduce((value, element) => value + element * 2)
          .toStringAsFixed(2);
    }
  }

  listenNotifications() {
    NotificationApi.onNotification.stream.listen((event) {
      if (event == 'acessarApp') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PageForm();
        })).then((_) => _carregar());
      }
    });
  }

  _carregar() {
    setState(() {
      loading = true;
    });
    controller.listarItens().whenComplete(() => {
          setState(() {
            loading = false;
          })
        });
    sharedPreferencesConfig.persist();
  }
}
