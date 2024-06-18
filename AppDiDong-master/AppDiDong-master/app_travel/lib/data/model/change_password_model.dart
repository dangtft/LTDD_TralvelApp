class ChangePasswordModel {
  final int userId;
  final String newPassword;

  ChangePasswordModel({required this.userId, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'newPassword': newPassword,
    };
  }
}
