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
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(produtos[i].urlImagem),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text('0'),
                    ),
                    const SizedBox(width: 4),
                    MPButtonIcon(
                      iconData: Icons.remove,
                      iconColor: Theme.of(context).primaryColor,
                      withBackgroundColor: true,
                      size: 30,
                      onTap: () {},
                    ),
                    const SizedBox(width: 4),
                    MPButtonIcon(
                      iconData: Icons.add,
                      iconColor: Theme.of(context).primaryColor,
                      withBackgroundColor: true,
                      size: 30,
                      onTap: () =>
                          _carrinhoController.adicionaProduto(produtos[i]),
                    ),
                  ],
                ),
                title: Text(produtos[i].nome),
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
