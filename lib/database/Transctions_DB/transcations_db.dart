import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mono/models/transcation_model/transcation_model.dart';

const TRANSCATION_DB_NAME = 'rranscation-db';

abstract class TranscationDbfunctions {
  Future<void> addtranscation(TranscationModel obj);
  Future<List<TranscationModel>> getalltranscation();
  Future<void> deletetranscation( String id);
}

class TranscationDB implements TranscationDbfunctions {

  TranscationDB._internal();
  static TranscationDB instance = TranscationDB._internal();
  factory TranscationDB() {
    return instance;
  }

  ValueNotifier<List<TranscationModel>> transcationNotifier = ValueNotifier([]);

  @override
  Future<void> addtranscation(TranscationModel obj) async {
    final _db = await Hive.openBox<TranscationModel>(TRANSCATION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getalltranscation();
    transcationNotifier.value.clear();
    transcationNotifier.value.addAll(_list);
    transcationNotifier.notifyListeners();
  }

  @override
  Future<List<TranscationModel>> getalltranscation() async {
    final _db = await Hive.openBox<TranscationModel>(TRANSCATION_DB_NAME);
    return _db.values.toList();
  }
  
  @override
  Future <void> deletetranscation( String id)async{
    final _db = await Hive.openBox<TranscationModel>(TRANSCATION_DB_NAME);
    await _db.delete(id);



  }
}
