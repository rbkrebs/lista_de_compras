import 'package:flutter/material.dart';
import 'package:projeto_final/views/shared_preferences_init.dart';

class ConfigNotifications extends StatefulWidget {
  ConfigNotifications({Key? key}) : super(key: key);

  @override
  _ConfigNotificationsState createState() => _ConfigNotificationsState();
}

class _ConfigNotificationsState extends State<ConfigNotifications> {
  SharedPreferencesConfig sharedPreferencesConfig = SharedPreferencesConfig();

  String? _testValue;

  @override
  void initState() {
    super.initState();
    sharedPreferencesConfig.initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Compras"), centerTitle: true),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(children: [
          const Center(
            child:
                Text("Envio de notificações", style: TextStyle(fontSize: 20)),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => {
                    sharedPreferencesConfig.persist(value: '2s'),
                    setState(() {})
                  },
                  child: const Text("2 segundos"),
                  style: ElevatedButton.styleFrom(
                      primary: sharedPreferencesConfig.timeInterval == '2s'
                          ? Colors.blue
                          : Colors.amber),
                ),
                ElevatedButton(
                  onPressed: () => {
                    sharedPreferencesConfig.persist(value: '5s'),
                    setState(() {})
                  },
                  child: const Text("5 segundos"),
                  style: ElevatedButton.styleFrom(
                      primary: sharedPreferencesConfig.timeInterval == '5s'
                          ? Colors.blue
                          : Colors.amber),
                ),
                ElevatedButton(
                  onPressed: () => {
                    sharedPreferencesConfig.persist(value: '10s'),
                    setState(() {})
                  },
                  child: const Text("10 segundos"),
                  style: ElevatedButton.styleFrom(
                      primary: sharedPreferencesConfig.timeInterval == '10s'
                          ? Colors.blue
                          : Colors.amber),
                ),
                ElevatedButton(
                  onPressed: () => {
                    sharedPreferencesConfig.persist(value: '15s'),
                    setState(() {})
                  },
                  child: const Text("15 segundos"),
                  style: ElevatedButton.styleFrom(
                      primary: sharedPreferencesConfig.timeInterval == '15s'
                          ? Colors.blue
                          : Colors.amber),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
