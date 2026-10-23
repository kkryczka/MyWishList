import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/wish_db.dart';
import '../models/wish_item.dart';

final wishesProvider = FutureProvider<List<WishItem>>((ref) async => WishDb.all());

class WishActions {
  static Future<void> add(WishItem i) async {
    await WishDb.insert(i);
  }
}
