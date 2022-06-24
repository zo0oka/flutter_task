import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'full_name')
  String? fullName;
  @JsonKey(name: 'gender')
  String? gender;
  @JsonKey(name: 'age')
  int? age;
  @JsonKey(name: 'image')
  String? image;

  User(
      {this.userId,
      this.firstName,
      this.lastName,
      this.fullName,
      this.gender,
      this.age,
      this.image});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
