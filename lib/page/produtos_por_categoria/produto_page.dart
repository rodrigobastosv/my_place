import 'package:flutter/material.dart';
import 'package:my_place_utils/my_place_utils.dart';
import 'package:my_place/widget/mp_appbar.dart';
import 'package:my_place_models/models/models.dart';
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
      appBar: MPAppBar(
        title: Text('Produto'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: widget.produto.urlImagem,
                child: Image.network(widget.produto.urlImagem),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.produto.descricao,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              widget.produto.preco,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 24),
            RaisedButton.icon(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 24,
              ),
              label: Text(
                'Adicionar ao carrinho',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () async {
                await _carrinhoController.adicionaProduto(widget.produto);
                showSuccessToast('Produto adicionado ao carrinho!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
