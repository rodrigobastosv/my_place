import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place_models/models/models.dart';

class ProdutosPorCategoriaController {
  ProdutosPorCategoriaController(this.categoria);

  final CategoriaModel categoria;
  final _produtosRef = FirebaseFirestore.instance.collection('produtos');

  Future<List<ProdutoModel>> getProdutosPorCategoria() async {
    final query = _produtosRef.where('categoria', isEqualTo: categoria.nome);
    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => ProdutoModel.fromJson(doc.id, doc.data()))
        .toList();
  }
}
