import 'package:flutter/material.dart';
import 'package:my_place/model/categoria_model.dart';
import 'package:my_place/model/produto_model.dart';
import 'package:my_place/page/carrinho/carrinho_controller.dart';
import 'package:my_place/page/produtos_por_categoria/produtos_por_categoria_controller.dart';
import 'package:my_place/widget/mp_appbar.dart';
import 'package:my_place/widget/mp_button_icon.dart';
import 'package:my_place/widget/mp_list_tile.dart';
import 'package:my_place/widget/mp_loading.dart';
import 'package:provider/provider.dart';

import 'produto_page.dart';

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
      appBar: MPAppBar(
        title: Text('Produtos'),
      ),
      body: FutureBuilder<List<ProdutoModel>>(
        future: futureProdutos,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final produtos = snapshot.data;
            return ListView.builder(
              itemBuilder: (_, i) => MPListTile(
                leading: Hero(
                  tag: produtos[i].urlImagem,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(produtos[i].urlImagem),
                  ),
                ),
                trailing: Text(produtos[i].preco.toString()),
                title: Text(produtos[i].nome),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Provider.value(
                          value: Provider.of<CarrinhoController>(context),
                          child: ProdutoPage(produtos[i]),
                        ),
                      ),
                    );
                },
              ),
              itemCount: produtos.length,
            );
          }
          return MPLoading();
        },
      ),
    );
  }
}
