import 'package:flutter/material.dart';
import 'package:my_place_utils/my_place_utils.dart';
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
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor.withOpacity(.1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 8),
            Text(
              PrecoUtils.numeroToPreco(getTotal().toString()),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
