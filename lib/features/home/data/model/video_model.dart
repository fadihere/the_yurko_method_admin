import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String id;
  final String url;
  final String title;
  final String description;
  final DateTime createdAt;
  final String thumbnail;
  final int weeklyViews;
  final int totalViews;
  VideoModel({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.thumbnail,
    required this.weeklyViews,
    required this.totalViews,
  });

  VideoModel copyWith({
    String? id,
    String? url,
    String? title,
    String? description,
    DateTime? createdAt,
    String? thumbnail,
    int? weeklyViews,
    int? totalViews,
  }) {
    return VideoModel(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      thumbnail: thumbnail ?? this.thumbnail,
      weeklyViews: weeklyViews ?? this.weeklyViews,
      totalViews: totalViews ?? this.totalViews,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'thumbnail': thumbnail,
      'weeklyViews': weeklyViews,
      'totalViews': totalViews,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      url: map['url'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      thumbnail: map['thumbnail'] as String,
      weeklyViews: map['weeklyViews'] as int,
      totalViews: map['totalViews'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(id: $id, url: $url, title: $title, description: $description, createdAt: $createdAt, thumbnail: $thumbnail, weeklyViews: $weeklyViews, totalViews: $totalViews)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.url == url &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.thumbnail == thumbnail &&
        other.weeklyViews == weeklyViews &&
        other.totalViews == totalViews;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        url.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        thumbnail.hashCode ^
        weeklyViews.hashCode ^
        totalViews.hashCode;
  }
}
