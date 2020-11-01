import 'package:flutter/material.dart';
import 'package:my_place/model/produto_model.dart';
import 'package:my_place/page/carrinho/carrinho_controller.dart';
import 'package:provider/provider.dart';

class ProdutoPage extends StatefulWidget {
  ProdutoPage(this.produto);

  final ProdutoModel produto;

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  CarrinhoController _carrinhoController;

  @override
  void didChangeDependencies() {
    _carrinhoController = Provider.of<CarrinhoController>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: widget.produto.urlImagem,
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.produto.urlImagem),
              radius: 80,
            ),
          ),
          Text(widget.produto.preco),
          Text(widget.produto.descricao),
          RaisedButton(
            onPressed: () async {
              await _carrinhoController.adicionaProduto(widget.produto);
            },
            child: Text('Adicionar ao carrinho'),
          ),
        ],
      ),
    );
  }
}
