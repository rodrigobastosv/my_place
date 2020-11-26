import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_place/page/carrinho/carrinho_controller.dart';
import 'package:my_place/page/home/home_controller.dart';
import 'package:my_place/page/produtos_por_categoria/produto_page.dart';

import 'package:my_place_models/models/models.dart';
import 'package:provider/provider.dart';
import '../../../widget/mp_title.dart';

class Promocoes extends StatelessWidget {
  Promocoes(this.promocoes);

  final List<PromocaoModel> promocoes;
  final _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MPTitle('Promoções'),
        const SizedBox(height: 8),
        CarouselSlider(
          options: CarouselOptions(
            disableCenter: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            height: 200,
          ),
          items: promocoes
              .map(
                (promocao) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onTap: () async {
                      final produtoPromocao =
                          await _controller.getProdutoPromocao(promocao);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => Provider.value(
                            value: Provider.of<CarrinhoController>(context),
                            child: ProdutoPage(produtoPromocao),
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Image.network(
                          promocao.urlImagem,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Colors.red[400],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${promocao.desconto.toStringAsFixed(0)}% OFF',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                              ),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              promocao.nomeProduto,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
