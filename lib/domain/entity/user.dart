import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id;
  final int? uId;
  final String? eMail;
  final String? password;

  User(
      {this.id = 0,
      required this.uId,
      required this.eMail,
      required this.password});

  User fromJson(Map<String, dynamic> json) {
    return User(
        uId: json['uid'] as int?,
        eMail: json['email'] as String?,
        password: json['password'] as String?);
  }

  Map<String, dynamic> toJson(User userInstance) => <String, dynamic>{
        'uid': userInstance.uId,
        'email': userInstance.eMail,
        'password': userInstance.password
      };

  User copyWith({String? eMail, String? password}) {
    return User(uId: uId, eMail: eMail, password: password);
  }
}
