class Item {
  String item;

  bool isReviewed;

  int followers;

  Item({
    required this.item,
    required this.isReviewed,
    required this.followers,
  });

  Map<String, dynamic> toJson() => {
        'item': item,
        'isReviewed': isReviewed,
        'followers': followers,
      };

  static Item fromJson(Map<String, dynamic> json) => Item(
        item: json['item'],
        isReviewed: json['isReviewed'],
        followers: json['followers'],
      );
}
