import 'package:glyphora_language_core/glyphora_language_core.dart';
import 'package:test/test.dart';

void main() {
  group('ScriptConfig.findByCode', () {
    test('finds a script by canonical code case-insensitively', () {
      final script = ScriptConfig.findByCode('hnom');

      expect(script, isNotNull);
      expect(script!.code, 'Hnom');
    });

    test('finds a script by alias', () {
      final script = ScriptConfig.findByCode('chunom');

      expect(script, isNotNull);
      expect(script!.code, 'Hnom');
      expect(script.aliases, contains('chunom'));
    });

    test('returns null for an unknown code', () {
      expect(ScriptConfig.findByCode('unknown-script'), isNull);
    });
  });

  group('LanguageConfig.scriptNameOf', () {
    final vietnamese = LanguageConfig.findByCode('vi');

    test('uses language-specific script names when available', () {
      expect(vietnamese, isNotNull);
      expect(vietnamese!.scriptNameOf('Latn', 'zh'), '国语字');
      expect(vietnamese.scriptNameOf('Latn', 'vi'), 'Chữ Quốc ngữ');
      expect(vietnamese.scriptNameOf('Hnom', 'zh'), '喃字');
    });

    test('normalizes the UI locale before lookup', () {
      expect(vietnamese, isNotNull);
      expect(vietnamese!.scriptNameOf('Latn', 'vi-VN'), 'Chữ Quốc ngữ');
    });

    test('falls back to the global script name', () {
      final english = LanguageConfig.findByCode('en');

      expect(english, isNotNull);
      expect(english!.scriptNameOf('Latn', 'en'), 'Latin script');
    });

    test('falls back to the requested code when the script is unknown', () {
      expect(vietnamese, isNotNull);
      expect(vietnamese!.scriptNameOf('Unknown', 'en'), 'Unknown');
    });
  });
}
