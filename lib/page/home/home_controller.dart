import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place_models/models/models.dart';
import 'package:my_place_utils/my_place_utils.dart';

class HomeController {
  final _promocoesRef = FirebaseFirestore.instance.collection('promocoes');
  final _produtosRef = FirebaseFirestore.instance.collection('produtos');
  final _categoriasRef = FirebaseFirestore.instance.collection('categorias');

  Future<List<PromocaoModel>> getPromocoes() async {
    final query = _promocoesRef.orderBy('desconto');
    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => PromocaoModel.fromJson(doc.id, doc.data()))
        .toList();
  }

  Future<List<CategoriaModel>> getCategorias() async {
    final querySnapshot = await _categoriasRef.get();
    return querySnapshot.docs
        .map((doc) => CategoriaModel.fromJson(doc.id, doc.data()))
        .toList();
  }

  Future<ProdutoModel> getProdutoPromocao(PromocaoModel promocao) async {
    final querySnapshot = await _produtosRef
        .where(
          'nome',
          isEqualTo: promocao.nomeProduto,
        )
        .get();
    final doc = querySnapshot.docs.first;
    final produto = ProdutoModel.fromJson(doc.id, doc.data());
    final preco =
        promocao.valorOriginalProduto * (1 - (promocao.desconto / 100));
    produto.preco = PrecoUtils.numeroToPreco(preco.toString());
    return produto;
  }
}
