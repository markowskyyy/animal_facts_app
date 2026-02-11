class Animal {
  final String id;
  final String name;
  final String imageUrl;
  final String habitat;
  final String interestingFact;
  final List<String> wrongFacts;
  final String features;
  bool isLearned;

  Animal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.habitat,
    required this.interestingFact,
    required this.wrongFacts,
    required this.features,
    this.isLearned = false,
  });

  Animal copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? habitat,
    String? interestingFact,
    List<String>? wrongFacts,
    String? features,
    bool? isLearned,
  }) {
    return Animal(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      habitat: habitat ?? this.habitat,
      interestingFact: interestingFact ?? this.interestingFact,
      wrongFacts: wrongFacts ?? this.wrongFacts,
      features: features ?? this.features,
      isLearned: isLearned ?? this.isLearned,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'habitat': habitat,
      'interestingFact': interestingFact,
      'wrongFacts': wrongFacts,
      'features': features,
      'isLearned': isLearned,
    };
  }

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      habitat: json['habitat'],
      interestingFact: json['interestingFact'],
      wrongFacts: List<String>.from(json['wrongFacts']),
      features: json['features'],
      isLearned: json['isLearned'] ?? false,
    );
  }
}