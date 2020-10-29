import 'package:flutter/material.dart';
import 'package:my_place/model/categoria_model.dart';
import 'package:my_place/model/produto_model.dart';
import 'package:my_place/page/carrinho/carrinho_controller.dart';
import 'package:my_place/page/produtos_por_categoria/produtos_por_categoria_controller.dart';
import 'package:provider/provider.dart';

class ProdutosPorCategoriaPage extends StatefulWidget {
  ProdutosPorCategoriaPage(this.categoria);

  final CategoriaModel categoria;

  @override
  _ProdutosPorCategoriaPageState createState() =>
      _ProdutosPorCategoriaPageState();
}

class _ProdutosPorCategoriaPageState extends State<ProdutosPorCategoriaPage> {
  ProdutosPorCategoriaController _controller;
  CarrinhoController _carrinhoController;
  Future<List<ProdutoModel>> futureProdutos;

  @override
  void initState() {
    _controller = ProdutosPorCategoriaController(widget.categoria);
    futureProdutos = _controller.getProdutosPorCategoria();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _carrinhoController = Provider.of<CarrinhoController>(context);
    super.didChangeDependencies();
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
                onTap: () => _carrinhoController.adicionaProduto(produtos[i]),
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
