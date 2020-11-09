import 'package:flutter/material.dart';
import 'package:my_place/util/preco_utils.dart';
import 'package:my_place_models/models/models.dart';

class TotalizadorCarrinho extends StatelessWidget {
  const TotalizadorCarrinho(this.produtos);

  final List<ProdutoModel> produtos;

  double getTotal() {
    double total = 0;
    produtos.forEach((produto) {
      total += produto.quantidade *
          double.parse(PrecoUtils.limpaStringPreco(produto.preco));
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) => ListTile(
        title: Text('${produtos[i].quantidade} x ${produtos[i].preco}'),
      ),
      separatorBuilder: (_, i) => Divider(),
      itemCount: produtos.length,
    );
  }
}
