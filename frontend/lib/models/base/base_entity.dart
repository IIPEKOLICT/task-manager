abstract class BaseEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BaseEntity({this.id = '', this.createdAt, this.updatedAt});

  static DateTime? parseDateFromJson(dynamic jsonDate) {
    return jsonDate == null ? null : DateTime.parse(jsonDate);
  }
}
