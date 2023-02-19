import 'package:flutter/widgets.dart';

import '../models/item.dart';
import 'package:projeto_final/repository/item_repository.dart';

class Tela1Controller {
  static final Tela1Controller _singleton = Tela1Controller._internal();

  factory Tela1Controller() {
    return _singleton;
  }

  Tela1Controller._internal();
  ItemRepository itemRepository = ItemRepository();
  String? image;
  String? latitude;
  String? longitude;

  List<Item> itens = [];

  TextEditingController itemNomeTD = TextEditingController();
  TextEditingController itemDescricaoTD = TextEditingController();
  TextEditingController itemValorTD = TextEditingController();

  void salvarItem() {
    String itemNome = itemNomeTD.text;
    String itemDescricao =
        itemDescricaoTD.text.isEmpty ? "Bebida" : itemDescricaoTD.text;
    double itemValor = double.parse(itemValorTD.text);
    itemNomeTD.clear();
    itemDescricaoTD.clear();
    itemValorTD.clear();

    Item novoItem = Item(
        nome: itemNome,
        descricao: itemDescricao,
        valor: itemValor.toString(),
        imagem: image,
        lat: latitude,
        long: longitude);
    itemRepository.insert(novoItem);
  }

  void deletarItem(index) {
    itemRepository.delete(itens[index]);
  }

  void deletarTodos() {
    for (var item in itens) {
      itemRepository.delete(item);
    }
  }

  Future<void> listarItens() async {
    await itemRepository.selectAll().then((value) => itens = value);
  }
}
