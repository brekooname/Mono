import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
//import 'package:mono/models/category_model/category_model.dart';
import 'package:mono/models/transcation_model/transcation_model.dart';
import 'package:mono/screens/transcation_screen/transcation_screen.dart';

const TRANSCATION_DB_NAME = 'rranscation-db';

abstract class TranscationDbfunctions {
  Future<void> addtranscation(TranscationModel obj);
  Future<List<TranscationModel>> getalltranscation();
  Future<void> deletetranscation(String id);
  Future<void> updatetranscation(TranscationModel obj);
}

class TranscationDB implements TranscationDbfunctions {
  TranscationDB._internal();
  static TranscationDB instance = TranscationDB._internal();
  factory TranscationDB() {
    return instance;
  }

  @override
  Future<void> updatetranscation(TranscationModel obj) async {
    final _db = await Hive.openBox<TranscationModel>(TRANSCATION_DB_NAME);
    _db.put(obj.id, obj);
  }

  ValueNotifier<List<TranscationModel>> transcationNotifier = ValueNotifier([]);
  ValueNotifier<List<TranscationModel>> incomelistnotifier = ValueNotifier([]);
  ValueNotifier<List<TranscationModel>> expenselistnotifier = ValueNotifier([]);
  ValueNotifier<List<TranscationModel>> todaylistnotifier = ValueNotifier([]);
  ValueNotifier<List<TranscationModel>> yesterdaylistnotifier =
      ValueNotifier([]);

  @override
  Future<void> addtranscation(TranscationModel obj) async {
    final _db = await Hive.openBox<TranscationModel>(TRANSCATION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getalltranscation();
    totalBalanceCheck(_list);
    _list.sort((first, second) => second.date.compareTo(first.date));
    yesterdaylistnotifier.value.clear();
    transcationNotifier.value.clear();
    incomelistnotifier.value.clear();
    expenselistnotifier.value.clear();
    todaylistnotifier.value.clear();

    transcationNotifier.value.addAll(_list);
    
    final _today = DateFormat().add_yMMMMd().format(DateTime.now());
    final _yesterday = DateFormat() .add_yMMMMd().format(DateTime.now().subtract(const Duration(days: 1)));

    Future.forEach(_list, (TranscationModel transcationlist) {
      if (transcationlist.type == 'Expense') {
        expenselistnotifier.value.add(transcationlist);
      } else {
        incomelistnotifier.value.add(transcationlist);
      }

      final _dates = DateFormat().add_yMMMMd().format(transcationlist.date);

      if (_dates == _today) {
        todaylistnotifier.value.add(transcationlist);
      } else if (_dates == _yesterday) {
        yesterdaylistnotifier.value.add(transcationlist);
      }
      
    });

    yesterdaylistnotifier.notifyListeners();
    transcationNotifier.notifyListeners();
    expenselistnotifier.notifyListeners();
    incomelistnotifier.notifyListeners();
    todaylistnotifier.notifyListeners();
  }

  @override
  Future<List<TranscationModel>> getalltranscation() async {
    final _db = await Hive.openBox<TranscationModel>(TRANSCATION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deletetranscation(String id) async {
    final _db = await Hive.openBox<TranscationModel>(TRANSCATION_DB_NAME);
    await _db.delete(id);
  }
}
