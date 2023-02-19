import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_final/apis/notifications_api.dart';

class SharedPreferencesConfig {
  SharedPreferences? sharedPreferences;
  static final SharedPreferencesConfig? _instance = SharedPreferencesConfig._();
  SharedPreferencesConfig._();

  String? _testValue;

  String? get timeInterval => _testValue;

  factory SharedPreferencesConfig() {
    return _instance!;
  }

  void initSharedPreferences() {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;

      if (sharedPreferences == null) {
        _testValue = '2s';

        persist(value: _testValue);
      } else {
        _testValue = sharedPreferences!.getString('freq');
      }
    });
  }

  void persist({value: null}) {
    if (value != null) {
      _testValue = value;
    }
    NotificationApi.scheduleNotifications(
        id: 0,
        title: "Aplicativo lista de compras",
        body: "Bora cadastrar um novo item?",
        payload: "acessarApp",
        data: DateTime.now().add(Duration(
            seconds:
                int.parse(_testValue!.substring(0, _testValue!.length - 1)))));

    sharedPreferences?.setString('freq', _testValue!);
  }
}
