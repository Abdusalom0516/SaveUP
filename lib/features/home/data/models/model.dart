import 'package:intl/intl.dart';

class ContributionModel {
  final String id;
  final double amount; // positive = add, negative = withdraw
  final DateTime createdAt;

  const ContributionModel({
    required this.id,
    required this.amount,
    required this.createdAt,
  });

  bool get isAdding => amount >= 0;
  double get absoluteAmount => amount.abs();
  String get formattedMonth => DateFormat('MMM yyyy').format(createdAt);
  String get formattedDate => DateFormat('M/d/yyyy').format(createdAt);

  ContributionModel copyWith({String? id, double? amount, DateTime? createdAt}) {
    return ContributionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };

  factory ContributionModel.fromJson(Map<String, dynamic> json) =>
      ContributionModel(
        id: json['id'] as String,
        amount: (json['amount'] as num).toDouble(),
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      );
}

class DreamModel {
  final String id;
  final String name;
  final double targetAmount;
  final double currentAmount;
  final int colorIndex; // 0=purple,1=blue,2=pink,3=green,4=orange
  final DateTime deadline;
  final DateTime createdAt;
  final List<ContributionModel> contributions;

  const DreamModel({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    required this.colorIndex,
    required this.deadline,
    required this.createdAt,
    required this.contributions,
  });

  double get progressRatio =>
      targetAmount > 0 ? (currentAmount / targetAmount).clamp(0.0, 1.0) : 0.0;

  int get progressPercent => (progressRatio * 100).round();

  double get remaining =>
      (targetAmount - currentAmount).clamp(0.0, double.infinity);

  int get daysLeft =>
      deadline.difference(DateTime.now()).inDays.clamp(0, 999999);

  double get monthlyNeed {
    if (remaining <= 0) return 0;
    if (daysLeft <= 0) return remaining;
    return remaining / (daysLeft / 30.0);
  }

  String get formattedDeadline => DateFormat('M/d/yyyy').format(deadline);

  DreamModel copyWith({
    String? id,
    String? name,
    double? targetAmount,
    double? currentAmount,
    int? colorIndex,
    DateTime? deadline,
    DateTime? createdAt,
    List<ContributionModel>? contributions,
  }) {
    return DreamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      colorIndex: colorIndex ?? this.colorIndex,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt ?? this.createdAt,
      contributions: contributions ?? this.contributions,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'targetAmount': targetAmount,
        'currentAmount': currentAmount,
        'colorIndex': colorIndex,
        'deadline': deadline.millisecondsSinceEpoch,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'contributions': contributions.map((c) => c.toJson()).toList(),
      };

  factory DreamModel.fromJson(Map<String, dynamic> json) => DreamModel(
        id: json['id'] as String,
        name: json['name'] as String,
        targetAmount: (json['targetAmount'] as num).toDouble(),
        currentAmount: (json['currentAmount'] as num).toDouble(),
        colorIndex: json['colorIndex'] as int,
        deadline: DateTime.fromMillisecondsSinceEpoch(json['deadline'] as int),
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
        contributions: (json['contributions'] as List)
            .map((e) => ContributionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
