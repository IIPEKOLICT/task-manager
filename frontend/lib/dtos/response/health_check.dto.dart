class HealthCheckDto {
  final String status;

  HealthCheckDto(this.status);

  factory HealthCheckDto.fromJSON(Map<String, dynamic> json) {
    return HealthCheckDto(json['status']);
  }
}