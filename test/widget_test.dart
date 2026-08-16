import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovely_chat_app/app/app.dart';
import 'package:lovely_chat_app/core/constants/app_constants.dart';
import 'package:lovely_chat_app/core/services/theme_mode_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('Autumn Chat foundation shows chats shell', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const AutumnChatApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppConstants.appName), findsWidgets);
    expect(find.text('Sohbetler'), findsOneWidget);
    expect(find.text('Henüz sohbet yok'), findsOneWidget);
  });

  testWidgets('theme mode can switch to dark', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const AutumnChatApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ayarlar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tema'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Koyu'));
    await tester.pumpAndSettle();

    expect(prefs.getString('theme_mode'), 'dark');
  });
}
