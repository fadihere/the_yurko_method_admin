// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideoModel {
  final String id;
  final String url;
  final String title;
  final String description;
  final DateTime createdAt;
  final String thumbnail;
  final int weeklyViews;
  final int totalViews;
  final int? order;
  final DurationModel duration;
  final String pdfUrl;
  final String webLink;
  final int dateTime;

  VideoModel({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.thumbnail,
    required this.weeklyViews,
    required this.totalViews,
    this.order,
    required this.duration,
    required this.pdfUrl,
    required this.webLink,
    required this.dateTime,
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
    int? order,
    DurationModel? duration,
    String? pdfUrl,
    String? webLink,
    int? dateTime,
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
      order: order ?? this.order,
      duration: duration ?? this.duration,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      webLink: webLink ?? this.webLink,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'thumbnail': thumbnail,
      'weeklyViews': weeklyViews,
      'totalViews': totalViews,
      'order': order,
      'duration': duration.toMap(),
      'pdfUrl': pdfUrl,
      'webLink': webLink,
      'dateTime': dateTime,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      url: map['url'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      thumbnail: map['thumbnail'] as String,
      weeklyViews: map['weeklyViews'] as int,
      totalViews: map['totalViews'] as int,
      order: map['order'] != null ? map['order'] as int : null,
      duration: DurationModel.fromMap(map['duration'] as Map<String, dynamic>),
      pdfUrl: map['pdfUrl'] as String,
      webLink: map['webLink'] as String,
      dateTime: map['dateTime'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(id: $id, url: $url, title: $title, description: $description, createdAt: $createdAt, thumbnail: $thumbnail, weeklyViews: $weeklyViews, totalViews: $totalViews, order: $order, duration: $duration, pdfUrl: $pdfUrl, webLink: $webLink, dateTime: $dateTime)';
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
        other.order == order &&
        other.duration == duration &&
        other.pdfUrl == pdfUrl &&
        other.webLink == webLink &&
        other.dateTime == dateTime;
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
        order.hashCode ^
        duration.hashCode ^
        pdfUrl.hashCode ^
        webLink.hashCode ^
        dateTime.hashCode;
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
