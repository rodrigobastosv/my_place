import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_place/model/promocao_model.dart';

class Promocoes extends StatelessWidget {
  Promocoes(this.promocoes);

  final List<PromocaoModel> promocoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Promoções'),
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            height: 200,
          ),
          items: promocoes
              .map(
                (promocao) => Container(
                  child: Center(
                    child: Image.network(
                      promocao.urlImagem,
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
