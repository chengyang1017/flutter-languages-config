import 'fonts.dart';

class ScriptConfig {
  final String code;
  final Map<String, String> names;
  final String sampleText;
  final bool isRtl;
  final List<String> fontIds;
  final List<String> aliases;
  final List<String> languageCodes;

  const ScriptConfig({
    required this.code,
    required this.names,
    required this.sampleText,
    this.isRtl = false,
    this.fontIds = const [],
    this.aliases = const [],
    this.languageCodes = const [],
  });

  List<FontConfig> get fonts {
    return FontConfig.findByIds(fontIds);
  }

  String nameOf(String uiLanguageCode) {
    final code = uiLanguageCode
        .trim()
        .toLowerCase()
        .split(RegExp(r'[-_]'))
        .first;

    return names[code] ?? names['en'] ?? names['zh'] ?? this.code;
  }

  static ScriptConfig? findByCode(String code) {
    final normalizedCode = code.trim().toLowerCase();

    for (final script in allScripts) {
      if (script.code.toLowerCase() == normalizedCode) {
        return script;
      }

      if (script.aliases.any(
        (alias) => alias.toLowerCase() == normalizedCode,
      )) {
        return script;
      }
    }

    return null;
  }

  static const List<ScriptConfig> allScripts = [
    ScriptConfig(
      code: 'Latn',
      names: {
        'zh': '拉丁字母',
        'en': 'Latin script',
        'ms': 'Tulisan Latin',
        'vi': 'Chữ Latinh',
        'ru': 'Латиница',
      },
      sampleText: 'Glyphora',
      fontIds: ['noto-sans'],
    ),
    ScriptConfig(
      code: 'Hnom',
      names: {
        'zh': '喃字',
        'en': 'Chữ Nôm',
        'ms': 'Aksara Nôm',
        'vi': 'Chữ Nôm',
        'ru': 'Тьы Ном',
      },
      sampleText: '𡦂喃',
      aliases: ['chunom'],
      languageCodes: ['vi'],
      fontIds: ['nom-na-tong'],
    ),
  ];
}
