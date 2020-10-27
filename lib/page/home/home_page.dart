import 'package:flutter/material.dart';
import 'package:my_place/model/promocao_model.dart';
import 'package:my_place/model/usuario_model.dart';
import 'package:my_place/page/home/home_controller.dart';
import 'package:my_place/page/home/widget/promocoes.dart';

class HomePage extends StatefulWidget {
  HomePage(this.user);

  final UsuarioModel user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<PromocaoModel>> futurePromocoes;
  final _controller = HomeController();

  @override
  void initState() {
    futurePromocoes = _controller.getPromocoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<List<PromocaoModel>>(
              future: futurePromocoes,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return Promocoes(snapshot.data);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
