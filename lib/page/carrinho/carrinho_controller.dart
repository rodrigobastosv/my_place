import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place_models/models/models.dart';

class CarrinhoController {
  CarrinhoController(this.user);

  final UsuarioModel user;
  final _carrinhosRef = FirebaseFirestore.instance.collection('carrinhos');

  Future<List<ProdutoModel>> getProdutosCarrinho() async {
    final querySnapshot =
        await _carrinhosRef.doc(user.id).collection('produtos').get();
    return querySnapshot.docs
        .map((doc) => ProdutoModel.fromJson(doc.id, doc.data()))
        .toList();
  }

  Future<void> adicionaProduto(ProdutoModel produto) async {
    final doc =
        _carrinhosRef.doc(user.id).collection('produtos').doc(produto.id);
    final docSnapshot = await doc.get();
    if (docSnapshot.exists) {
      final quantidade = docSnapshot.data()['quantidade'] ?? 0;
      doc.set({
        ...produto.toJson(),
        'quantidade': quantidade + 1,
      });
    } else {
      doc.set({
        ...produto.toJson(),
        'quantidade': 1,
      });
    }
  }
}
