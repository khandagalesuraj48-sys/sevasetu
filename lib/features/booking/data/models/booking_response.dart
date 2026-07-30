class BookingModel {
  final String id;
  final String serviceId;
  final String providerId;
  final String customerId;
  final String status;
  final String address;
  final double? latitude;
  final double? longitude;
  final String? notes;
  final String? startedAt;
  final String? completedAt;
  final String? arrivalOtp;
  final String? startOtp;
  final String? endOtp;
  final String createdAt;
  final String updatedAt;

  BookingModel({
    required this.id,
    required this.serviceId,
    required this.providerId,
    required this.customerId,
    required this.status,
    required this.address,
    this.latitude,
    this.longitude,
    this.notes,
    this.startedAt,
    this.completedAt,
    this.arrivalOtp,
    this.startOtp,
    this.endOtp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: json['id'] ?? '',
    serviceId: json['serviceId'] ?? '',
    providerId: json['providerId'] ?? '',
    customerId: json['customerId'] ?? '',
    status: json['status'] ?? 'pending',
    address: json['address'] ?? '',
    latitude: json['latitude'],
    longitude: json['longitude'],
    notes: json['notes'],
    startedAt: json['startedAt'],
    completedAt: json['completedAt'],
    arrivalOtp: json['arrivalOtp'],
    startOtp: json['startOtp'],
    endOtp: json['endOtp'],
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'serviceId': serviceId,
    'providerId': providerId,
    'customerId': customerId,
    'status': status,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'notes': notes,
    'startedAt': startedAt,
    'completedAt': completedAt,
    'arrivalOtp': arrivalOtp,
    'startOtp': startOtp,
    'endOtp': endOtp,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  BookingModel copyWith({
    String? status,
    String? startedAt,
    String? completedAt,
    String? arrivalOtp,
    String? startOtp,
    String? endOtp,
  }) {
    return BookingModel(
      id: id,
      serviceId: serviceId,
      providerId: providerId,
      customerId: customerId,
      status: status ?? this.status,
      address: address,
      latitude: latitude,
      longitude: longitude,
      notes: notes,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      arrivalOtp: arrivalOtp ?? this.arrivalOtp,
      startOtp: startOtp ?? this.startOtp,
      endOtp: endOtp ?? this.endOtp,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}