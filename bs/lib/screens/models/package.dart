class Package {
  final String? id;
  final double weightKg;
  final double sizeWidthCm;
  final double sizeHeightCm;
  final double sizeDepthCm;
  final String clientName;
  final String clientAddress;
  final String clientPhone;
  final DateTime pickupDate;
  final double? price;
  final String? status;

  Package({
    this.id,
    required this.weightKg,
    required this.sizeWidthCm,
    required this.sizeHeightCm,
    required this.sizeDepthCm,
    required this.clientName,
    required this.clientAddress,
    required this.clientPhone,
    required this.pickupDate,
    this.price,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'weightKg': weightKg,
      'sizeWidthCm': sizeWidthCm,
      'sizeHeightCm': sizeHeightCm,
      'sizeDepthCm': sizeDepthCm,
      'clientName': clientName,
      'clientAddress': clientAddress,
      'clientPhone': clientPhone,
      'pickupDate': pickupDate.toIso8601String(),
    };
  }
}
