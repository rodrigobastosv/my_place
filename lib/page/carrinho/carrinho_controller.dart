import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place_utils/my_place_utils.dart';
import 'package:my_place_models/models/models.dart';
import 'package:my_place_models/models/pedido_model.dart';

class CarrinhoController {
  CarrinhoController(this.user) : pedido = PedidoModel();

  final PedidoModel pedido;
  final UsuarioModel user;
  final _carrinhosRef = FirebaseFirestore.instance.collection('carrinhos');
  final _pedidosPendentesRef =
      FirebaseFirestore.instance.collection('pedidos_pendentes');

  Future<List<ProdutoModel>> getProdutosCarrinho() async {
    await _carrinhosRef.doc(user.id).get();
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

  Future<void> removeProduto(ProdutoModel produto) async {
    final doc =
        _carrinhosRef.doc(user.id).collection('produtos').doc(produto.id);
    final docSnapshot = await doc.get();
    final quantidade = docSnapshot.data()['quantidade'] ?? 0;
    if (quantidade == 1) {
      await doc.delete();
    } else {
      doc.set({
        ...produto.toJson(),
        'quantidade': quantidade - 1,
      });
    }
  }

  double getValorTotalPedido(List<ProdutoModel> produtos) {
    double valor = 0.0;
    for (ProdutoModel produto in produtos) {
      valor += produto.quantidade *
          double.parse(PrecoUtils.limpaStringPreco(produto.preco));
    }
    return valor;
  }

  void onChangeAvaliacaoPedido(int avaliacao) {
    pedido.avaliacao = avaliacao;
  }

  void onChangeObservacao(String observacao) {
    pedido.observacao = observacao;
  }

  Future<void> finalizaPedido() async {
    final produtosCarrinho = await getProdutosCarrinho();
    final valorPedido = getValorTotalPedido(produtosCarrinho);
    pedido.produtos = produtosCarrinho;
    pedido.valorPedido = valorPedido;
    pedido.userId = user.id;
    pedido.nomeUsuario = user.nome;
    pedido.dataPedido = DateTime.now();

    await deleteCarrinho();
    await _pedidosPendentesRef.add(pedido.toJson());
  }

  Future<void> deleteCarrinho() async {
    await _carrinhosRef.doc(user.id).delete();
    final produtosCarrinho =
        await _carrinhosRef.doc(user.id).collection('produtos').get();
    produtosCarrinho.docs.forEach((doc) {
      _carrinhosRef.doc(user.id).collection('produtos').doc(doc.id).delete();
    });
  }
}
