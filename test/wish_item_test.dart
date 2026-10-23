import 'package:flutter_test/flutter_test.dart';
import 'package:zachcianki/models/wish_item.dart';

void main() {
  test('readyAt adds waitDays', () {
    final now = DateTime(2026, 1, 1);
    final w = WishItem(
      id: '1',
      title: 'x',
      type: 'note',
      reason: 'r',
      waitDays: 7,
      createdAt: now,
    );
    expect(w.readyAt, now.add(const Duration(days: 7)));
  });

  test('isReady false before readyAt', () {
    final future = DateTime.now().add(const Duration(days: 10));
    final w = WishItem(
      id: '2',
      title: 'x',
      type: 'note',
      reason: 'r',
      waitDays: 30,
      createdAt: future,
    );
    expect(w.isReady, isFalse);
  });

  test('toMap/fromMap roundtrip', () {
    final now = DateTime(2026, 5, 5);
    final w = WishItem(
      id: '3',
      title: 'Tytuł',
      type: 'link',
      url: 'https://example.com',
      price: 42.5,
      reason: 'powód',
      waitDays: 7,
      createdAt: now,
      status: 'pending',
    );
    final restored = WishItem.fromMap(w.toMap());
    expect(restored.id, w.id);
    expect(restored.title, w.title);
    expect(restored.url, w.url);
    expect(restored.price, w.price);
    expect(restored.status, w.status);
    expect(restored.createdAt, w.createdAt);
  });
}
