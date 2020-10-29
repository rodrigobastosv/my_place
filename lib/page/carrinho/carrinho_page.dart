import 'package:flutter/material.dart';
import 'package:my_place/model/produto_model.dart';
import 'package:my_place/model/usuario_model.dart';
import 'package:my_place/page/carrinho/carrinho_controller.dart';
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
      body: FutureBuilder<List<ProdutoModel>>(
        future: futureCarrinho,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final produtosCarrinho = snapshot.data;
            return ListView.builder(
              itemBuilder: (_, i) => ListTile(
                title: Text(produtosCarrinho[i].nome),
              ),
              itemCount: produtosCarrinho.length,
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
