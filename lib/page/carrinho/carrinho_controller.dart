import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place/model/produto_model.dart';
import 'package:my_place/model/usuario_model.dart';

class CarrinhoController {
  CarrinhoController(this.user);

  final UsuarioModel user;
  final _carrinhosRef = FirebaseFirestore.instance.collection('carrinhos');

  Future<List<ProdutoModel>> getProdutosCarrinho() async {
    final querySnapshot =
        await _carrinhosRef.doc(user.id).collection('produtos').get();
    return querySnapshot.docs
        .map((doc) => ProdutoModel.fromJson(doc.id, doc.data())).toList();
  }

  Future<void> adicionaProduto(ProdutoModel produto) async {
    await _carrinhosRef
        .doc(user.id)
        .collection('produtos')
        .doc(produto.id)
        .set(produto.toJson());
  }
}
