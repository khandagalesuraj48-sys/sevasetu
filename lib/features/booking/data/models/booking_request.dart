class CreateBookingRequest {
  final String serviceId;
  final String providerId;
  final String address;
  final double? latitude;
  final double? longitude;
  final String? notes;
  final List<String>? photos;

  CreateBookingRequest({
    required this.serviceId,
    required this.providerId,
    required this.address,
    this.latitude,
    this.longitude,
    this.notes,
    this.photos,
  });

  Map<String, dynamic> toJson() => {
    'serviceId': serviceId,
    'providerId': providerId,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'notes': notes,
    'photos': photos,
  };
}

class UpdateBookingRequest {
  final String bookingId;
  final String? status;
  final String? notes;

  UpdateBookingRequest({
    required this.bookingId,
    this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
    'bookingId': bookingId,
    'status': status,
    'notes': notes,
  };
}