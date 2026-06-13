class CarModel {
  final int id;
  final String carType;
  final String licensePlate;

  CarModel({
    required this.id,
    required this.carType,
    required this.licensePlate,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as int,
      carType: json['car_type'] as String,
      licensePlate: json['license_plate'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'car_type': carType,
        'license_plate': licensePlate,
      };
}

class SingleCarResponseModel {
  final int status;
  final String message;
  final CarModel? data;

  SingleCarResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory SingleCarResponseModel.fromJson(Map<String, dynamic> json) {
    return SingleCarResponseModel(
      status: json['status'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? CarModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
