import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_place/model/promocao_model.dart';
import 'package:my_place/widget/mp_title.dart';

class Promocoes extends StatelessWidget {
  Promocoes(this.promocoes);

  final List<PromocaoModel> promocoes;

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
                  child: Image.network(
                    promocao.urlImagem,
                    fit: BoxFit.cover,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
