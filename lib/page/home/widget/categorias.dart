import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_place/model/categoria_model.dart';
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
                    child: Image.network(
                      categoria.urlImagem,
                      fit: BoxFit.cover,
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
