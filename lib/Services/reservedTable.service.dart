import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/ReservedTable.dart';
import 'package:ecommerce/common/Repository.dart';

class ServiceReservedTable {
  Repository _rep = Repository("reserved restaurant");
  final String resTableId;
  List<ReservedTable> resTables;

  final db = Firestore.instance.collection("reserved restaurant");

  ServiceReservedTable({this.resTableId});

  Future addRestable(ReservedTable data) async {
    return await _rep.addDocument(data.toJson());
  }

  Future<List<ReservedTable>> fetchData() async {
    var result = await _rep.getDataCollection();
    resTables = result.documents
        .map((doc) => ReservedTable.fromMap(doc.data, doc.documentID))
        .toList();
    return resTables;
  }

  Future<void> removeDocument(String resTableId) async {
    return await _rep.removeDocument(resTableId);
  }

  Future update(ReservedTable data, String resTableId) async {
    return await _rep.updateDocument(data.toJson(), resTableId);
  }

  Future<ReservedTable> getById(String resTableId) async {
    var result = await db.where("resTableId", isEqualTo: resTableId).getDocuments();
    var restaurant = result.documents.first;
    return ReservedTable.fromMap(restaurant.data, restaurant.documentID);
  }
}
