import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/wish_db.dart';
import '../models/wish_item.dart';
import '../providers/wishes_provider.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final String id;
  const DetailScreen({super.key, required this.id});
  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  WishItem? item;
  @override
  void initState() {
    super.initState();
    _load();
  }
  Future<void> _load() async {
    try {
      final all = await WishDb.all();
      final found = all.where((w) => w.id == widget.id).toList();
      if (found.isEmpty) {
        if (mounted) context.go('/');
        return;
      }
      setState(() => item = found.first);
    } catch (_) {
      if (mounted) context.go('/');
    }
  }
  Future<void> _setStatus(String s) async {
    await WishDb.updateStatus(widget.id, s);
    ref.invalidate(wishesProvider);
    if (mounted) context.go('/');
  }
  @override
  Widget build(BuildContext context) {
    if (item == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final w = item!;
    return Scaffold(
      appBar: AppBar(title: Text(w.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Cena: ${w.price ?? '-'}'),
          Text('Powód: ${w.reason}'),
          Text('Oczekiwanie: ${w.waitDays} dni'),
          Text('Gotowa: ${w.isReady}'),
          const SizedBox(height: 16),
          if (w.isReady) ...[
            ElevatedButton(onPressed: () => _setStatus('kept'), child: const Text('Nadal chcę')),
            ElevatedButton(onPressed: () => _setStatus('skipped'), child: const Text('Nie potrzebuję')),
          ],
          ElevatedButton(onPressed: () => _setStatus('bought'), child: const Text('Kupione')),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () async {
              await WishDb.delete(widget.id);
              ref.invalidate(wishesProvider);
              if (mounted) context.go('/');
            },
            child: const Text('Usuń'),
          ),
        ]),
      ),
    );
  }
}
