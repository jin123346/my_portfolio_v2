// lib/models/project.dart
import 'package:uuid/uuid.dart';

/// 프로젝트 정보를 담는 모델 클래스
class Project {
  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final String imageUrl;
  final List<Map<String, String>> githubUrls;
  final String? liveUrl;
  final String? githubUrl;
  // 추가 정보
  final String? role;
  final String? period;
  final List<String>? features;
  final List<Map<String, String>>? troubleShooting;

  Project({
    String? id,
    required this.title,
    required this.description,
    required this.technologies,
    required this.imageUrl,
    this.githubUrl,
    this.liveUrl,
    this.role,
    this.period,
    this.features,
    this.troubleShooting,
    this.githubUrls = const [],
  }) : id = id ?? const Uuid().v4(); // ID가 없으면 자동 생성

  // GitHub URL 목록을 반환하는 getter
  List<Map<String, String>> get allGithubUrls {
    List<Map<String, String>> result = List.from(githubUrls);

    // 하위 호환성을 위해 githubUrl이 있는데 githubUrls가 비어있다면 추가
    if (githubUrl != null && githubUrls.isEmpty) {
      result.add({"label": "GitHub", "url": githubUrl!});
    }

    return result;
  }

  // JSON에서 Project 객체로 변환
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      technologies: List<String>.from(json['technologies']),
      imageUrl: json['imageUrl'],
      githubUrl: json['githubUrl'],
      liveUrl: json['liveUrl'],
      role: json['role'],
      period: json['period'],
      features:
          json['features'] != null ? List<String>.from(json['features']) : null,
      troubleShooting: json['troubleShooting'] != null
          ? List<Map<String, String>>.from(json['troubleShooting']
              .map((item) => Map<String, String>.from(item)))
          : null,
    );
  }

  // Project 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'description': description,
      'technologies': technologies,
      'imageUrl': imageUrl,
      'githubUrl': githubUrl,
    };

    // 선택적 필드들 추가
    if (liveUrl != null) data['liveUrl'] = liveUrl;
    if (role != null) data['role'] = role;
    if (period != null) data['period'] = period;
    if (features != null) data['features'] = features;
    if (troubleShooting != null) data['troubleShooting'] = troubleShooting;

    return data;
  }

  // 객체 복사본 생성 (수정을 위해)
  Project copyWith({
    String? title,
    String? description,
    List<String>? technologies,
    String? imageUrl,
    String? githubUrl,
    String? liveUrl,
    String? role,
    String? period,
    List<String>? features,
    List<Map<String, String>>? troubleShooting,
  }) {
    return Project(
      id: this.id, // ID는 변경하지 않음
      title: title ?? this.title,
      description: description ?? this.description,
      technologies: technologies ?? this.technologies,
      imageUrl: imageUrl ?? this.imageUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      liveUrl: liveUrl ?? this.liveUrl,
      role: role ?? this.role,
      period: period ?? this.period,
      features: features ?? this.features,
      troubleShooting: troubleShooting ?? this.troubleShooting,
    );
  }
}
