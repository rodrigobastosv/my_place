import 'package:flutter/material.dart';
import 'package:my_place_utils/my_place_utils.dart';
import 'package:my_place/widget/mp_logo.dart';
import 'package:my_place_models/models/models.dart';
import 'package:my_place/page/carrinho/carrinho_controller.dart';
import 'package:my_place/widget/mp_appbar.dart';
import 'package:my_place/widget/mp_button_icon.dart';
import 'package:my_place/widget/mp_list_tile.dart';
import 'package:my_place/widget/mp_loading.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

import 'widget/totalizador_carrinho.dart';

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
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (_, i) => MPListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(produtosCarrinho[i].nome),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  produtosCarrinho[i].preco,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(produtosCarrinho[i]
                                              .quantidade
                                              ?.toString() ??
                                          '0'),
                                    ),
                                    const SizedBox(width: 8),
                                    MPButtonIcon(
                                      iconData: Icons.remove,
                                      iconColor: Theme.of(context).primaryColor,
                                      withBackgroundColor: true,
                                      size: 30,
                                      onTap: () async {
                                        await _controller
                                            .removeProduto(produtosCarrinho[i]);
                                        futureCarrinho =
                                            _controller.getProdutosCarrinho();
                                        setState(() {});
                                      },
                                    ),
                                    const SizedBox(width: 4),
                                    MPButtonIcon(
                                        iconData: Icons.add,
                                        iconColor:
                                            Theme.of(context).primaryColor,
                                        withBackgroundColor: true,
                                        size: 30,
                                        onTap: () async {
                                          await _controller.adicionaProduto(
                                              produtosCarrinho[i]);
                                          futureCarrinho =
                                              _controller.getProdutosCarrinho();
                                          setState(() {});
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      hasTrailing: false,
                    ),
                    itemCount: produtosCarrinho.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      TotalizadorCarrinho(produtosCarrinho),
                      SizedBox(height: 12),
                      TextFormField(
                        onChanged: _controller.onChangeObservacao,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Observação',
                        ),
                        minLines: 3,
                        maxLines: 6,
                      ),
                      SizedBox(height: 24),
                      RaisedButton.icon(
                        icon: Icon(Icons.done, size: 32),
                        label: Text(
                          'Finalizar o Pedido',
                          style: TextStyle(fontSize: 18),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 32,
                        ),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return RatingDialog(
                                icon: MPLogo(),
                                title: 'Dê uma nota para a sua experiência!',
                                description: '',
                                submitButton: "ENVIAR",
                                positiveComment: 'Que ótimo!',
                                negativeComment: 'Que pena :(',
                                accentColor: Theme.of(context).primaryColor,
                                onSubmitPressed: (int avaliacao) async {
                                  _controller
                                      .onChangeAvaliacaoPedido(avaliacao);
                                  await _controller.finalizaPedido();
                                  showSuccessToast(
                                      'Pedido finalizado com sucesso!');
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            );
          }
          return MPLoading();
        },
      ),
    );
  }
}
