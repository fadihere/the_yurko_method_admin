import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ViewModel {
  final String id;
  final DateTime viewAt;
  final DocumentReference viewBy;
  ViewModel({
    required this.id,
    required this.viewAt,
    required this.viewBy,
  });

  ViewModel copyWith({
    String? id,
    DateTime? viewAt,
    DocumentReference? viewBy,
  }) {
    return ViewModel(
      id: id ?? this.id,
      viewAt: viewAt ?? this.viewAt,
      viewBy: viewBy ?? this.viewBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'viewAt': Timestamp.fromDate(viewAt),
      'viewBy': viewBy,
    };
  }

  factory ViewModel.fromMap(Map<String, dynamic> map) {
    return ViewModel(
      id: map['id'] as String,
      viewAt: (map['viewAt'] as Timestamp).toDate(),
      viewBy: map['viewBy'] as DocumentReference,
    );
  }

  String toJson() => json.encode(toMap());

  factory ViewModel.fromJson(String source) =>
      ViewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ViewModel(id: $id, viewAt: $viewAt, viewBy: $viewBy)';

  @override
  bool operator ==(covariant ViewModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.viewAt == viewAt && other.viewBy == viewBy;
  }

  @override
  int get hashCode => id.hashCode ^ viewAt.hashCode ^ viewBy.hashCode;
}
