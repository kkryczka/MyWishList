import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/wish_item.dart';
import '../data/wish_db.dart';
import '../providers/wishes_provider.dart';

class AddWishScreen extends ConsumerStatefulWidget {
  const AddWishScreen({super.key});
  @override
  ConsumerState<AddWishScreen> createState() => _AddWishScreenState();
}

class _AddWishScreenState extends ConsumerState<AddWishScreen> {
  final _title = TextEditingController();
  final _reason = TextEditingController();
  final _price = TextEditingController();
  final _url = TextEditingController();
  int waitDays = 7;
  String type = 'note';

  Future<void> _save() async {
    final item = WishItem(
      id: const Uuid().v4(),
      title: _title.text,
      type: type,
      url: _url.text.isEmpty ? null : _url.text,
      price: double.tryParse(_price.text),
      reason: _reason.text,
      waitDays: waitDays,
      createdAt: DateTime.now(),
    );
    await WishDb.insert(item);
    ref.invalidate(wishesProvider);
    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nowa zachcianka')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(children: [
          TextField(controller: _title, decoration: const InputDecoration(labelText: 'Tytuł')),
          TextField(controller: _url, decoration: const InputDecoration(labelText: 'Link (opcjonalnie)')),
          TextField(controller: _price, decoration: const InputDecoration(labelText: 'Cena orientacyjna'), keyboardType: TextInputType.number),
          TextField(controller: _reason, decoration: const InputDecoration(labelText: 'Co ten zakup miałby mi dać?'), maxLines: 3),
          const SizedBox(height: 12),
          const Text('Okres oczekiwania (ile dni przed możliwością zakupu)'),
          DropdownButton<int>(
            value: waitDays,
            items: const [7, 30].map((d) => DropdownMenuItem(value: d, child: Text('$d dni'))).toList(),
            onChanged: (v) => setState(() => waitDays = v!),
          ),
          const SizedBox(height: 16),
          Row(children: [
            TextButton(onPressed: () => context.go('/'), child: const Text('Anuluj')),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: _save, child: const Text('Zapisz')),
          ]),
        ]),
      ),
    );
  }
}
