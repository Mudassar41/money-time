class Bank {
  final String name;
  String? id;

  Bank({
    required this.name,
    this.id,
  });

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
