class ProfileModel {
  final String email;
  final String username;
  final String? name;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;
  final List<String> interests;

  ProfileModel({
    required this.email,
    required this.username,
    this.name,
    this.birthday,
    this.horoscope,
    this.zodiac,
    this.height,
    this.weight,
    required this.interests,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] as String?,
      birthday: json['birthday'] as String?,
      horoscope: json['horoscope'] as String?,
      zodiac: json['zodiac'] as String?,
      height: json['height'] != null ? (json['height'] as num?)?.toInt() : null,
      weight: json['weight'] != null ? (json['weight'] as num?)?.toInt() : null,
      interests: List<String>.from(json['interests'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'name': name,
      'height': height,
      'weight': weight,
      'interests': interests,
    };
  }

  ProfileModel copyWith({
    String? email,
    String? username,
    String? name,
    String? birthday,
    String? horoscope,
    String? zodiac,
    int? height,
    int? weight,
    List<String>? interests,
  }) {
    return ProfileModel(
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      horoscope: horoscope ?? this.horoscope,
      zodiac: zodiac ?? this.zodiac,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      interests: interests ?? this.interests,
    );
  }
}
