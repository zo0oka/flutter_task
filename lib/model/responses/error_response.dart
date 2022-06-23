import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ErrorResponse {
  @JsonKey(name: 'error')
  List<String>? errors;

  ErrorResponse({this.errors});

  factory ErrorResponse.fromJson(dynamic json) => _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
