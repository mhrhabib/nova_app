import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nova_app/core/di/injection_container.dart';
import 'package:nova_app/main.dart';

void main() {
  testWidgets('Nova app initial render smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await initDependencyInjection();
    await tester.pumpWidget(const NovaApp());
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(NovaApp), findsOneWidget);
  });
}
