/// Maps low-level failures to human-readable Turkish copy.
///
/// Expand in Phase 2+ for Firebase Auth / Firestore codes.
abstract final class AppErrorMapper {
  static String fromObject(Object error) {
    final String raw = error.toString();

    if (raw.contains('firebase_options_not_configured') ||
        raw.contains('FirebaseOptions')) {
      return 'Firebase henüz yapılandırılmadı. flutterfire configure çalıştır.';
    }

    if (raw.contains('network') || raw.contains('SocketException')) {
      return 'Bağlantı sorunu. İnternetini kontrol edip tekrar dene.';
    }

    return 'Beklenmeyen bir hata oluştu. Lütfen tekrar dene.';
  }
}
