class Item {
  int? id;
  String? nome;
  String? descricao;
  String? valor;
  String? imagem;
  String? lat;
  String? long;

  Item(
      {this.nome,
      this.descricao,
      this.valor,
      this.imagem,
      this.lat,
      this.long});

  Item.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    valor = json['valor'];
    imagem = json['imagem'];
    lat = json['lat'];
    long = json['long'];
  }
}
