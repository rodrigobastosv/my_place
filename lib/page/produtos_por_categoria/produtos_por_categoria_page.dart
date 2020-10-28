import 'package:flutter/material.dart';
import 'package:my_place/model/categoria_model.dart';
import 'package:my_place/model/produto_model.dart';
import 'package:my_place/page/produtos_por_categoria/produtos_por_categoria_controller.dart';

class ProdutosPorCategoriaPage extends StatefulWidget {
  ProdutosPorCategoriaPage(this.categoria);

  final CategoriaModel categoria;

  @override
  _ProdutosPorCategoriaPageState createState() =>
      _ProdutosPorCategoriaPageState();
}

class _ProdutosPorCategoriaPageState extends State<ProdutosPorCategoriaPage> {
  ProdutosPorCategoriaController _controller;
  Future<List<ProdutoModel>> futureProdutos;

  @override
  void initState() {
    _controller = ProdutosPorCategoriaController(widget.categoria);
    futureProdutos = _controller.getProdutosPorCategoria();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProdutoModel>>(
        future: futureProdutos,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final produtos = snapshot.data;
            return ListView.builder(
              itemBuilder: (_, i) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(produtos[i].urlImagem),
                ),
                title: Text(produtos[i].nome),
              ),
              itemCount: produtos.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
