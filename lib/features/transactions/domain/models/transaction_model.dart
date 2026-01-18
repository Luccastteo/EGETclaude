import 'package:cloud_firestore/cloud_firestore.dart';

/// Transaction types
enum TransactionType { income, expense }

/// Transaction Model
/// All values stored in cents (int) for precision
class TransactionModel {
    final String id;
    final String userId;
    final int amountInCents;  // Store in cents for precision
    final TransactionType type;
    final String categoryId;
    final String? categoryName;
    final String? note;
    final DateTime date;
    final DateTime createdAt;
    final DateTime updatedAt;

    TransactionModel({
          required this.id,
          required this.userId,
          required this.amountInCents,
          required this.type,
          required this.categoryId,
          this.categoryName,
          this.note,
          required this.date,
          required this.createdAt,
          required this.updatedAt,
    });

    // Amount in currency (converted from cents)
    double get amount => amountInCents / 100;

    // Formatted amount string
    String get formattedAmount {
          final formatted = amount.toStringAsFixed(2);
          return type == TransactionType.income ? '+R\$ $formatted' : '-R\$ $formatted';
    }

    // Is income check
    bool get isIncome => type == TransactionType.income;

    // Create from Firestore document
    factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          return TransactionModel(
                  id: doc.id,
                  userId: data['userId'] ?? '',
                  amountInCents: data['amountInCents'] ?? 0,
                  type: data['type'] == 'income' ? TransactionType.income : TransactionType.expense,
                  categoryId: data['categoryId'] ?? '',
                  categoryName: data['categoryName'],
                  note: data['note'],
                  date: (data['date'] as Timestamp).toDate(),
                  createdAt: (data['createdAt'] as Timestamp).toDate(),
                  updatedAt: (data['updatedAt'] as Timestamp).toDate(),
                );
    }

    // Convert to Firestore map
    Map<String, dynamic> toFirestore() {
          return {
                  'userId': userId,
                  'amountInCents': amountInCents,
                  'type': type == TransactionType.income ? 'income' : 'expense',
                  'categoryId': categoryId,
                  'categoryName': categoryName,
                  'note': note,
                  'date': Timestamp.fromDate(date),
                  'createdAt': Timestamp.fromDate(createdAt),
                  'updatedAt': Timestamp.fromDate(updatedAt),
          };
    }

    // Create from JSON (for local storage)
    factory TransactionModel.fromJson(Map<String, dynamic> json) {
          return TransactionModel(
                  id: json['id'] ?? '',
                  userId: json['userId'] ?? '',
                  amountInCents: json['amountInCents'] ?? 0,
                  type: json['type'] == 'income' ? TransactionType.income : TransactionType.expense,
                  categoryId: json['categoryId'] ?? '',
                  categoryName: json['categoryName'],
                  note: json['note'],
                  date: DateTime.parse(json['date']),
                  createdAt: DateTime.parse(json['createdAt']),
                  updatedAt: DateTime.parse(json['updatedAt']),
                );
    }

    // Convert to JSON (for local storage)
    Map<String, dynamic> toJson() {
          return {
                  'id': id,
                  'userId': userId,
                  'amountInCents': amountInCents,
                  'type': type == TransactionType.income ? 'income' : 'expense',
                  'categoryId': categoryId,
                  'categoryName': categoryName,
                  'note': note,
                  'date': date.toIso8601String(),
                  'createdAt': createdAt.toIso8601String(),
                  'updatedAt': updatedAt.toIso8601String(),
          };
    }

    // CopyWith method
    TransactionModel copyWith({
          String? id,
          String? userId,
          int? amountInCents,
          TransactionType? type,
          String? categoryId,
          String? categoryName,
          String? note,
          DateTime? date,
          DateTime? createdAt,
          DateTime? updatedAt,
    }) {
          return TransactionModel(
                  id: id ?? this.id,
                  userId: userId ?? this.userId,
                  amountInCents: amountInCents ?? this.amountInCents,
                  type: type ?? this.type,
                  categoryId: categoryId ?? this.categoryId,
                  categoryName: categoryName ?? this.categoryName,
                  note: note ?? this.note,
                  date: date ?? this.date,
                  createdAt: createdAt ?? this.createdAt,
                  updatedAt: updatedAt ?? this.updatedAt,
                );
    }

    @override
    String toString() {
          return 'TransactionModel(id: $id, amount: $amount, type: $type, category: $categoryName)';
    }
}
