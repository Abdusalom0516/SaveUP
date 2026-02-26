import 'dart:convert';

import 'package:boilerplate/features/home/data/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DreamLocalDataSource {
  List<DreamModel> getDreams();
  Future<void> saveDreams(List<DreamModel> dreams);
}

class DreamLocalDataSourceImpl implements DreamLocalDataSource {
  static const _key = 'dreams_list';
  final SharedPreferences _prefs;

  DreamLocalDataSourceImpl(this._prefs);

  @override
  List<DreamModel> getDreams() {
    final json = _prefs.getString(_key);
    if (json == null) return [];
    try {
      final list = jsonDecode(json) as List;
      return list
          .map((e) => DreamModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveDreams(List<DreamModel> dreams) async {
    final json = jsonEncode(dreams.map((d) => d.toJson()).toList());
    await _prefs.setString(_key, json);
  }
}
