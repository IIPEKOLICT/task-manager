class DeleteDto {
  final String id;

  const DeleteDto(this.id);

  factory DeleteDto.fromJson(Map<String, dynamic> json) {
    return DeleteDto(json['_id']);
  }
}
