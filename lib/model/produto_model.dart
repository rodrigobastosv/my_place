class ProdutoModel {
  String id;
  String nome;
  String descricao;
  String categoria;
  String urlImagem;
  String preco;
  int quantidade;

  ProdutoModel({
    this.nome,
    this.descricao,
    this.categoria,
    this.urlImagem,
    this.preco,
    this.quantidade,
  });

  ProdutoModel.fromJson(String docId, Map<String, dynamic> json) {
    id = docId;
    nome = json['nome'];
    descricao = json['descricao'];
    categoria = json['categoria'];
    urlImagem = json['urlImagem'];
    preco = json['preco'];
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['categoria'] = this.categoria;
    data['urlImagem'] = this.urlImagem;
    data['preco'] = this.preco;
    data['quantidade'] = this.quantidade;
    return data;
  }
}
