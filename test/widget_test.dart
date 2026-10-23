import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zachcianki/app.dart';

void main() {
  testWidgets('app builds', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ZachciankiApp()));
    await tester.pump();
    expect(find.text('Zachcianki'), findsOneWidget);
  });
}
