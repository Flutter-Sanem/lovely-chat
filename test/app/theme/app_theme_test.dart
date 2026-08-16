import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovely_chat_app/app/theme/app_colors.dart';
import 'package:lovely_chat_app/app/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  test('light and dark themes use Material 3', () {
    expect(AppTheme.light.useMaterial3, isTrue);
    expect(AppTheme.dark.useMaterial3, isTrue);
  });

  test('primary token matches autumn burnt orange', () {
    expect(AppTheme.light.colorScheme.primary, AppColors.primary);
    expect(AppTheme.dark.colorScheme.primary, AppColors.primary);
  });
}
