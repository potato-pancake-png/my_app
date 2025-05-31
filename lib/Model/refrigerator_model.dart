class RefrigeratorItem {
  final int idrefrigerator;
  final String name;
  final int quantity;
  final String established;
  final String expired;
  final int familyId;
  final String location;
  final int category; // 추가

  RefrigeratorItem({
    required this.idrefrigerator,
    required this.name,
    required this.quantity,
    required this.established,
    required this.expired,
    required this.familyId,
    required this.location,
    required this.category, // 추가
  });

  factory RefrigeratorItem.fromJson(Map<String, dynamic> json) {
    return RefrigeratorItem(
      idrefrigerator:
          json['idrefrigerator'] is int
              ? json['idrefrigerator']
              : int.tryParse(json['idrefrigerator']?.toString() ?? '') ?? 0,
      name: json['name'] as String? ?? '',
      quantity:
          json['quantity'] is int
              ? json['quantity']
              : int.tryParse(json['quantity']?.toString() ?? '') ?? 0,
      established: json['established']?.toString() ?? '',
      expired: json['expired']?.toString() ?? '',
      familyId:
          json['family_id'] is int
              ? json['family_id']
              : int.tryParse(json['family_id']?.toString() ?? '') ?? 0,
      location: json['location'] as String? ?? '',
      category:
          json['category'] is int
              ? json['category']
              : int.tryParse(json['category']?.toString() ?? '') ?? 0, // 추가
    );
  }
}
