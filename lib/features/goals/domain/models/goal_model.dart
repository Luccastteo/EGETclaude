import 'package:cloud_firestore/cloud_firestore.dart';

/// Goal Model - Metas de Economia
/// Separadas do orcamento mensal
class GoalModel {
    final String id;
    final String userId;
    final String name;
    final String? description;
    final int targetAmountInCents;
    final int currentAmountInCents;
    final String? iconName;
    final String? color;
    final DateTime? targetDate;
    final bool isCompleted;
    final DateTime createdAt;
    final DateTime updatedAt;

    GoalModel({
          required this.id,
          required this.userId,
          required this.name,
          this.description,
          required this.targetAmountInCents,
          this.currentAmountInCents = 0,
          this.iconName,
          this.color,
          this.targetDate,
          this.isCompleted = false,
          required this.createdAt,
          required this.updatedAt,
    });

    double get targetAmount => targetAmountInCents / 100;
    double get currentAmount => currentAmountInCents / 100;
    double get progressPercent => targetAmountInCents > 0 ? (currentAmountInCents / targetAmountInCents * 100).clamp(0, 100) : 0;
    double get remainingAmount => (targetAmountInCents - currentAmountInCents) / 100;

    factory GoalModel.fromFirestore(DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          return GoalModel(
                  id: doc.id,
                  userId: data['userId'] ?? '',
                  name: data['name'] ?? '',
                  description: data['description'],
                  targetAmountInCents: data['targetAmountInCents'] ?? 0,
                  currentAmountInCents: data['currentAmountInCents'] ?? 0,
                  iconName: data['iconName'],
                  color: data['color'],
                  targetDate: data['targetDate'] != null ? (data['targetDate'] as Timestamp).toDate() : null,
                  isCompleted: data['isCompleted'] ?? false,
                  createdAt: (data['createdAt'] as Timestamp).toDate(),
                  updatedAt: (data['updatedAt'] as Timestamp).toDate(),
                );
    }

    Map<String, dynamic> toFirestore() {
          return {
                  'userId': userId,
                  'name': name,
                  'description': description,
                  'targetAmountInCents': targetAmountInCents,
                  'currentAmountInCents': currentAmountInCents,
                  'iconName': iconName,
                  'color': color,
                  'targetDate': targetDate != null ? Timestamp.fromDate(targetDate!) : null,
                  'isCompleted': isCompleted,
                  'createdAt': Timestamp.fromDate(createdAt),
                  'updatedAt': Timestamp.fromDate(updatedAt),
          };
    }

    GoalModel copyWith({
          String? id,
          String? userId,
          String? name,
          String? description,
          int? targetAmountInCents,
          int? currentAmountInCents,
          String? iconName,
          String? color,
          DateTime? targetDate,
          bool? isCompleted,
          DateTime? createdAt,
          DateTime? updatedAt,
    }) {
          return GoalModel(
                  id: id ?? this.id,
                  userId: userId ?? this.userId,
                  name: name ?? this.name,
                  description: description ?? this.description,
                  targetAmountInCents: targetAmountInCents ?? this.targetAmountInCents,
                  currentAmountInCents: currentAmountInCents ?? this.currentAmountInCents,
                  iconName: iconName ?? this.iconName,
                  color: color ?? this.color,
                  targetDate: targetDate ?? this.targetDate,
                  isCompleted: isCompleted ?? this.isCompleted,
                  createdAt: createdAt ?? this.createdAt,
                  updatedAt: updatedAt ?? this.updatedAt,
                );
    }
}
