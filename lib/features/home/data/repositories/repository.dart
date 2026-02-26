import 'package:boilerplate/features/home/data/datasources/local_datasource.dart';
import 'package:boilerplate/features/home/data/models/model.dart';
import 'package:boilerplate/features/home/domain/repositories/repository.dart';

class DreamRepositoryImpl implements IDreamRepository {
  final DreamLocalDataSource _dataSource;

  DreamRepositoryImpl(this._dataSource);

  @override
  List<DreamModel> getDreams() => _dataSource.getDreams();

  @override
  Future<void> addDream(DreamModel dream) async {
    final dreams = getDreams();
    await _dataSource.saveDreams([...dreams, dream]);
  }

  @override
  Future<void> updateDream(DreamModel dream) async {
    final dreams = getDreams();
    final updated = dreams.map((d) => d.id == dream.id ? dream : d).toList();
    await _dataSource.saveDreams(updated);
  }

  @override
  Future<void> deleteDream(String id) async {
    final dreams = getDreams();
    await _dataSource.saveDreams(dreams.where((d) => d.id != id).toList());
  }

  @override
  Future<void> addContribution(
      String dreamId, ContributionModel contribution) async {
    final dreams = getDreams();
    final updated = dreams.map((d) {
      if (d.id != dreamId) return d;
      final newAmount =
          (d.currentAmount + contribution.amount).clamp(0.0, d.targetAmount);
      return d.copyWith(
        currentAmount: newAmount,
        contributions: [...d.contributions, contribution],
      );
    }).toList();
    await _dataSource.saveDreams(updated);
  }
}
