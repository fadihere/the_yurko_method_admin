// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final DurationModel duration;
  VideoModel({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.thumbnail,
    required this.weeklyViews,
    required this.totalViews,
    required this.duration,
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
    DurationModel? duration,
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
      duration: duration ?? this.duration,
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
      'duration': duration.toMap(),
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
      duration: DurationModel.fromMap(map['duration'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(id: $id, url: $url, title: $title, description: $description, createdAt: $createdAt, thumbnail: $thumbnail, weeklyViews: $weeklyViews, totalViews: $totalViews, duration: $duration)';
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
        other.totalViews == totalViews &&
        other.duration == duration;
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
        totalViews.hashCode ^
        duration.hashCode;
  }
}

class DurationModel {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final int milliseconds;
  final int microseconds;
  DurationModel({
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.milliseconds = 0,
    this.microseconds = 0,
  });

  DurationModel copyWith({
    int? days,
    int? hours,
    int? minutes,
    int? seconds,
    int? milliseconds,
    int? microseconds,
  }) {
    return DurationModel(
      days: days ?? this.days,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      milliseconds: milliseconds ?? this.milliseconds,
      microseconds: microseconds ?? this.microseconds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
      'milliseconds': milliseconds,
      'microseconds': microseconds,
    };
  }

  factory DurationModel.fromMap(Map<String, dynamic> map) {
    return DurationModel(
      days: map['days'] as int,
      hours: map['hours'] as int,
      minutes: map['minutes'] as int,
      seconds: map['seconds'] as int,
      milliseconds: map['milliseconds'] as int,
      microseconds: map['microseconds'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DurationModel.fromJson(String source) =>
      DurationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DurationModel(days: $days, hours: $hours, minutes: $minutes, seconds: $seconds, milliseconds: $milliseconds, microseconds: $microseconds)';
  }

  @override
  bool operator ==(covariant DurationModel other) {
    if (identical(this, other)) return true;

    return other.days == days &&
        other.hours == hours &&
        other.minutes == minutes &&
        other.seconds == seconds &&
        other.milliseconds == milliseconds &&
        other.microseconds == microseconds;
  }

  @override
  int get hashCode {
    return days.hashCode ^
        hours.hashCode ^
        minutes.hashCode ^
        seconds.hashCode ^
        milliseconds.hashCode ^
        microseconds.hashCode;
  }
}
