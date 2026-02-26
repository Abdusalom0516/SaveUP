import 'package:boilerplate/features/home/data/models/model.dart';

abstract class IDreamRepository {
  List<DreamModel> getDreams();
  Future<void> addDream(DreamModel dream);
  Future<void> updateDream(DreamModel dream);
  Future<void> deleteDream(String id);
  Future<void> addContribution(String dreamId, ContributionModel contribution);
}
