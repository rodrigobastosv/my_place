import 'package:flutter/material.dart';
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
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, i) => MPListTile(
                    title: Text(produtosCarrinho[i].nome),
                    subtitle: Text(produtosCarrinho[i].preco),
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
                          child: Text(
                              produtosCarrinho[i].quantidade?.toString() ??
                                  '0'),
                        ),
                        const SizedBox(width: 4),
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
                            iconColor: Theme.of(context).primaryColor,
                            withBackgroundColor: true,
                            size: 30,
                            onTap: () async {
                              await _controller
                                  .adicionaProduto(produtosCarrinho[i]);
                              futureCarrinho =
                                  _controller.getProdutosCarrinho();
                              setState(() {});
                            }),
                      ],
                    ),
                  ),
                  itemCount: produtosCarrinho.length,
                ),
                Expanded(
                  child: TotalizadorCarrinho(produtosCarrinho),
                ),
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: TextFormField(
                    onChanged: _controller.onChangeObservacao,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Observação',
                    ),
                    minLines: 2,
                    maxLines: 6,
                  ),
                ),
                RaisedButton(
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
                            _controller.onChangeAvaliacaoPedido(avaliacao);
                            await _controller.finalizaPedido();
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                  child: Text('Finalizar o Pedido'),
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
