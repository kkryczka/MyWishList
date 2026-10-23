import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/wishes_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishes = ref.watch(wishesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Zachcianki')),
      body: wishes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Błąd: $e')),
        data: (list) => list.isEmpty
            ? const Center(child: Text('Brak zachcianek. Dodaj pierwszą!'))
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) {
                  final w = list[i];
                  final days = w.readyAt.difference(DateTime.now()).inDays;
                  return ListTile(
                    title: Text(w.title),
                    subtitle: Text(w.isReady ? 'Gotowa do oceny' : 'Oczekiwanie: $days dni'),
                    trailing: Text(w.price != null ? '${w.price} zł' : ''),
                    onTap: () => context.go('/item/${w.id}'),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
