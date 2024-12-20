class UserModel {
  final String id;
  final String name;
  final String pathImage;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.pathImage,
    required this.email,
  });

  UserModel.empty()
      : id = '',
        name = '',
        pathImage = '',
        email = '';

  UserModel.updateUserProfile({required this.name})
      : id = '',
        email = '',
        pathImage = '';


  @override
  List<Object?> get props => [id, name, pathImage, email];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.pathImage == pathImage &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ pathImage.hashCode ^ email.hashCode;
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? pathImage,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      pathImage: pathImage ?? this.pathImage,
      email: email ?? this.email,
    );
  }
}
