class ExceptionDto {
  final int? code;
  final String? message;

  ExceptionDto(this.code, this.message);

  factory ExceptionDto.fromJSON(Map<String, dynamic> json) {
    return ExceptionDto(json['code'], json['message']);
  }
}