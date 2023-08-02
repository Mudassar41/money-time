class Region {
  final String name;
  String? id;

  Region({
    required this.name,
    this.id,
  });

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
