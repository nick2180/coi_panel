class COI {
  String coi;

  bool isReviewed;

  int followers;

  COI({
    required this.coi,
    required this.isReviewed,
    required this.followers,
  });

  Map<String, dynamic> toJson() => {
        'coi': coi,
        'isReviewed': isReviewed,
        'followers': followers,
      };

  static COI fromJson(Map<String, dynamic> json) => COI(
        coi: json['coi'],
        isReviewed: json['isReviewed'],
        followers: json['followers'],
      );
}
