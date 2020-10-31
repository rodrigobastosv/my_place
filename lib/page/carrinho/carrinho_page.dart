import 'package:flutter/material.dart';
import 'package:my_place/model/produto_model.dart';
import 'package:my_place/model/usuario_model.dart';
import 'package:my_place/page/carrinho/carrinho_controller.dart';
import 'package:my_place/widget/mp_appbar.dart';
import 'package:my_place/widget/mp_button_icon.dart';
import 'package:my_place/widget/mp_list_tile.dart';
import 'package:my_place/widget/mp_loading.dart';
import 'package:provider/provider.dart';

class CarrinhoPage extends StatefulWidget {
  CarrinhoPage(this.usuario);

  final UsuarioModel usuario;

  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  CarrinhoController _controller;
  Future<List<ProdutoModel>> futureCarrinho;

  @override
  void didChangeDependencies() {
    _controller = Provider.of<CarrinhoController>(context);
    futureCarrinho = _controller.getProdutosCarrinho();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MPAppBar(
        title: Text('Seu pedido'),
      ),
      body: FutureBuilder<List<ProdutoModel>>(
        future: futureCarrinho,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final produtosCarrinho = snapshot.data;
            return ListView.builder(
              itemBuilder: (_, i) => MPListTile(
                title: Text(produtosCarrinho[i].nome),
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
                          _controller.adicionaProduto(produtosCarrinho[i]),
                    ),
                  ],
                ),
              ),
              itemCount: produtosCarrinho.length,
            );
          }
          return MPLoading();
        },
      ),
    );
  }
}
