import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_place_models/models/models.dart';
import 'package:my_place/page/carrinho/carrinho_controller.dart';
import 'package:my_place/page/produtos_por_categoria/produtos_por_categoria_page.dart';
import 'package:my_place/widget/mp_title.dart';
import 'package:provider/provider.dart';

class Categorias extends StatelessWidget {
  Categorias(this.categorias);

  final List<CategoriaModel> categorias;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MPTitle('Categorias'),
        const SizedBox(height: 8),
        CarouselSlider(
          options: CarouselOptions(
            disableCenter: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            height: 200,
          ),
          items: categorias
              .map(
                (categoria) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Provider.value(
                          value: Provider.of<CarrinhoController>(context),
                          child: ProdutosPorCategoriaPage(categoria),
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Image.network(
                          categoria.urlImagem,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
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
                              categoria.nome,
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
