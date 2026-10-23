class WishItem {
  final String id;
  final String title;
  final String type; // link/photo/note
  final String? url;
  final String? imagePath;
  final double? price;
  final String reason;
  final int waitDays;
  final DateTime createdAt;
  final String status; // pending/kept/skipped/bought

  WishItem({
    required this.id,
    required this.title,
    required this.type,
    this.url,
    this.imagePath,
    this.price,
    required this.reason,
    required this.waitDays,
    required this.createdAt,
    this.status = 'pending',
  });

  DateTime get readyAt => createdAt.add(Duration(days: waitDays));
  bool get isReady => DateTime.now().isAfter(readyAt);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'type': type,
        'url': url,
        'imagePath': imagePath,
        'price': price,
        'reason': reason,
        'waitDays': waitDays,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
      };

  factory WishItem.fromMap(Map<String, dynamic> m) => WishItem(
        id: m['id'],
        title: m['title'],
        type: m['type'],
        url: m['url'],
        imagePath: m['imagePath'],
        price: m['price']?.toDouble(),
        reason: m['reason'],
        waitDays: m['waitDays'],
        createdAt: DateTime.parse(m['createdAt']),
        status: m['status'],
      );
}
