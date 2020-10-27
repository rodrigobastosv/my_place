import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place/model/promocao_model.dart';

class HomeController {
  final _promocoesRef = FirebaseFirestore.instance.collection('promocoes');

  Future<List<PromocaoModel>> getPromocoes() async {
    final query = _promocoesRef.orderBy('desconto');
    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => PromocaoModel.fromJson(doc.id, doc.data()))
        .toList();
  }
}
