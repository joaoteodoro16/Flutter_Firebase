import 'dart:convert';

import 'package:flutter/widgets.dart';

class TodoModel {
  final String? id;
  final String description;
  final bool finished;
  final String user_id;
  TodoModel({
    this.id,
    required this.description,
    required this.finished,
    required this.user_id,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'finished': finished,
      'user_id': user_id,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map, [String? id]) {
    return TodoModel(
      id: id,
      description: map['description'] ?? '',
      finished: map['finished'] ?? false,
      user_id: map['user_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source));

  TodoModel copyWith({
    ValueGetter<String?>? id,
    String? description,
    bool? finished,
    String? user_id,
  }) {
    return TodoModel(
      id: id != null ? id() : this.id,
      description: description ?? this.description,
      finished: finished ?? this.finished,
      user_id: user_id ?? this.user_id,
    );
  }
}
