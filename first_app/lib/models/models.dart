// lib/models/api_response.dart
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? error;

  ApiResponse._({
    required this.success,
    this.data,
    this.error,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse._(success: true, data: data);
  }

  factory ApiResponse.error(String error) {
    return ApiResponse._(success: false, error: error);
  }
}

// lib/models/user_model.dart
class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final bool emailVerified;
  final bool isGoogleUser;
  final DateTime createdAt;
  final DateTime? lastLogin;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    required this.emailVerified,
    required this.isGoogleUser,
    required this.createdAt,
    this.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      emailVerified: json['email_verified'] ?? false,
      isGoogleUser: json['is_google_user'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'email_verified': emailVerified,
      'is_google_user': isGoogleUser,
      'created_at': createdAt.toIso8601String(),
      'last_login': lastLogin?.toIso8601String(),
    };
  }

  String get fullName => '$firstName $lastName';

  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    bool? emailVerified,
    bool? isGoogleUser,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      emailVerified: emailVerified ?? this.emailVerified,
      isGoogleUser: isGoogleUser ?? this.isGoogleUser,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}