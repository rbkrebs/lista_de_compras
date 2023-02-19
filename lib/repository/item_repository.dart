import 'package:projeto_final/service/db.dart';
import 'package:projeto_final/models/item.dart';

class ItemRepository {
  final String sqlSelectAll = 'SELECT * FROM item';
  final String sqlInsert =
      'INSERT INTO item (nome, descricao, valor, imagem, lat, long) values (?,?,?,?,?,?)';
  final String sqlDelete = 'DELETE FROM item WHERE id = ?';

  Future<List<Item>> selectAll() async {
    List<Item> itens = [];
    List<Map<String, Object?>> json =
        await BancoDeDados().db!.rawQuery(sqlSelectAll);

    for (Map<String, Object?> element in json) {
      Item item = Item.fromMap(element);
      itens.add(item);
    }
    return itens;
  }

  Future<void> insert(Item item) async {
    await BancoDeDados().db!.rawInsert(
      sqlInsert,
      [item.nome, item.descricao, item.valor, item.imagem, item.lat, item.long],
    );
  }

  Future<void> delete(Item item) async {
    await BancoDeDados().db!.rawDelete(
      sqlDelete,
      [item.id],
    );
  }
}
