import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place/model/categoria_model.dart';
import 'package:my_place/model/promocao_model.dart';

class HomeController {
  final _promocoesRef = FirebaseFirestore.instance.collection('promocoes');
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
}
