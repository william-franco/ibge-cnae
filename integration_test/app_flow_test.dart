import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ibge_cnae/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('cnae home reaches list, error, or loading state', (
    tester,
  ) async {
    await app.main();
    await tester.pumpAndSettle(const Duration(seconds: 20));

    final hasHomeTitle =
        find.text('Seções CNAE').evaluate().isNotEmpty;
    final hasError =
        find.textContaining('Não foi possível carregar').evaluate().isNotEmpty;
    final hasProgress =
        find.byType(CircularProgressIndicator).evaluate().isNotEmpty;
    final hasListItem = find
        .byType(ListTile)
        .evaluate()
        .isNotEmpty;

    expect(
      hasHomeTitle || hasError || hasProgress || hasListItem,
      isTrue,
    );
  });
}