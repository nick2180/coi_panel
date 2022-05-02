class COI {
  String coi;

  bool isReviewed;

  int followers;
  int subs;

  COI({
    required this.coi,
    required this.isReviewed,
    required this.followers,
    required this.subs,
  });

  Map<String, dynamic> toJson() => {
        'coi': coi,
        'isReviewed': isReviewed,
        'followers': followers,
        'subs': subs,
      };

  static COI fromJson(Map<String, dynamic> json) => COI(
        coi: json['coi'],
        isReviewed: json['isReviewed'],
        followers: json['followers'],
        subs: json['subs'],
      );
}
