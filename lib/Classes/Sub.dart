class Sub {
  String coi;
  String sub;

  bool isReviewed;

  int followers;

  Sub({
    required this.coi,
    required this.sub,
    required this.isReviewed,
    required this.followers,
  });

  Map<String, dynamic> toJson() => {
        'coi': coi,
        'sub': sub,
        'isReviewed': isReviewed,
        'followers': followers,
      };

  static Sub fromJson(Map<String, dynamic> json) => Sub(
        coi: json['coi'],
        sub: json['sub'],
        isReviewed: json['isReviewed'],
        followers: json['followers'],
      );
}
