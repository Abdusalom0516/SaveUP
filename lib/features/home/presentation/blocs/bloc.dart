import 'package:boilerplate/features/home/data/models/model.dart';
import 'package:boilerplate/features/home/domain/repositories/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─── States ────────────────────────────────────────────────────────────────

sealed class DreamsState extends Equatable {
  const DreamsState();
}

class DreamsInitial extends DreamsState {
  const DreamsInitial();
  @override
  List<Object?> get props => [];
}

class DreamsLoading extends DreamsState {
  const DreamsLoading();
  @override
  List<Object?> get props => [];
}

class DreamsLoaded extends DreamsState {
  final List<DreamModel> dreams;
  const DreamsLoaded(this.dreams);

  double get totalSaved => dreams.fold(0, (sum, d) => sum + d.currentAmount);
  double get totalTarget => dreams.fold(0, (sum, d) => sum + d.targetAmount);
  double get overallProgress =>
      totalTarget > 0 ? (totalSaved / totalTarget).clamp(0.0, 1.0) : 0.0;
  int get overallPercent => (overallProgress * 100).round();

  @override
  List<Object?> get props => [dreams];
}

class DreamsError extends DreamsState {
  final String message;
  const DreamsError(this.message);
  @override
  List<Object?> get props => [message];
}

// ─── Cubit ─────────────────────────────────────────────────────────────────

class DreamsCubit extends Cubit<DreamsState> {
  final IDreamRepository _repository;

  DreamsCubit(this._repository) : super(const DreamsInitial());

  void loadDreams() {
    emit(const DreamsLoading());
    try {
      final dreams = _repository.getDreams();
      emit(DreamsLoaded(dreams));
    } catch (e) {
      emit(DreamsError(e.toString()));
    }
  }

  Future<void> createDream({
    required String name,
    required double targetAmount,
    required double startingAmount,
    required int colorIndex,
    required DateTime deadline,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final clamped = startingAmount.clamp(0.0, targetAmount);
    final dream = DreamModel(
      id: id,
      name: name,
      targetAmount: targetAmount,
      currentAmount: clamped,
      colorIndex: colorIndex,
      deadline: deadline,
      createdAt: DateTime.now(),
      contributions: clamped > 0
          ? [
              ContributionModel(
                id: '${id}_init',
                amount: clamped,
                createdAt: DateTime.now(),
              )
            ]
          : [],
    );
    await _repository.addDream(dream);
    loadDreams();
  }

  Future<void> updateDream(DreamModel dream) async {
    await _repository.updateDream(dream);
    loadDreams();
  }

  Future<void> deleteDream(String id) async {
    await _repository.deleteDream(id);
    loadDreams();
  }

  Future<void> addContribution({
    required String dreamId,
    required double amount,
    required bool isAdding,
  }) async {
    if (amount <= 0) return;
    final contribution = ContributionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: isAdding ? amount : -amount,
      createdAt: DateTime.now(),
    );
    await _repository.addContribution(dreamId, contribution);
    loadDreams();
  }
}
