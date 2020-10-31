import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/categoria_model.dart';
import '../../model/promocao_model.dart';
import '../../model/usuario_model.dart';
import '../../widget/mp_appbar.dart';
import '../../widget/mp_button_icon.dart';
import '../../widget/mp_loading.dart';
import '../../widget/mp_logo.dart';
import '../carrinho/carrinho_controller.dart';
import '../carrinho/carrinho_page.dart';
import 'home_controller.dart';
import 'widget/categorias.dart';
import 'widget/promocoes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<PromocaoModel>> futurePromocoes;
  Future<List<CategoriaModel>> futureCategorias;
  final _controller = HomeController();

  @override
  void initState() {
    futurePromocoes = _controller.getPromocoes();
    futureCategorias = _controller.getCategorias();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MPAppBar(
        title: MPLogo(
          fontSize: 24,
        ),
        actions: [
          MPButtonIcon(
            iconData: Icons.shopping_cart,
            onTap: () {
              final usuario = Provider.of<UsuarioModel>(context, listen: false);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Provider.value(
                    value: Provider.of<CarrinhoController>(context),
                    child: CarrinhoPage(usuario),
                  ),
                ),
              );
            },
          ),
        ],
        withLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<PromocaoModel>>(
                future: futurePromocoes,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Promocoes(snapshot.data);
                  } else {
                    return MPLoading();
                  }
                },
              ),
              const SizedBox(height: 24),
              FutureBuilder<List<CategoriaModel>>(
                future: futureCategorias,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Categorias(snapshot.data);
                  } else {
                    return MPLoading();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
