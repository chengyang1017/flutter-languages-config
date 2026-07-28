class LanguageVariantConfig {
  final String code;

  /// 所属语言。
  final String languageCode;

  final Map<String, String> names;
  final Map<String, String> sortKeys;

  /// 主要使用地区，可选。
  final List<String> countryCodes;

  const LanguageVariantConfig({
    required this.code,
    required this.languageCode,
    required this.names,
    this.sortKeys = const {},
    this.countryCodes = const [],
  });

  String get name => nameOf('zh');

  String nameOf(String uiLangCode) {
    final code = uiLangCode.toLowerCase().trim().split(RegExp(r'[-_]')).first;

    return names[code] ?? names['en'] ?? names['zh'] ?? this.code;
  }

  static LanguageVariantConfig? findByCode(String code) {
    final normalized = code.trim().toLowerCase();

    for (final variant in allVariants) {
      if (variant.code.toLowerCase() == normalized) {
        return variant;
      }
    }

    return null;
  }

  static List<LanguageVariantConfig> findByCodes(Iterable<String> codes) {
    return codes
        .map(findByCode)
        .whereType<LanguageVariantConfig>()
        .toList(growable: false);
  }

  static const List<LanguageVariantConfig> allVariants = [
    LanguageVariantConfig(
      code: 'cmn',
      languageCode: 'zh',
      names: {
        'zh': '普通话',
        'en': 'Mandarin Chinese',
        'ms': 'Bahasa Mandarin',
        'vi': 'Tiếng Quan Thoại',
        'ru': 'Мандаринский китайский',
      },
      countryCodes: ['CN', 'TW', 'SG', 'MY'],
    ),
    LanguageVariantConfig(
      code: 'yue',
      languageCode: 'zh',
      names: {
        'zh': '粤语',
        'en': 'Cantonese',
        'ms': 'Bahasa Kantonis',
        'vi': 'Tiếng Quảng Đông',
        'ru': 'Кантонский язык',
      },
      countryCodes: ['CN', 'HK', 'MO', 'MY'],
    ),
    LanguageVariantConfig(
      code: 'hak',
      languageCode: 'zh',
      names: {
        'zh': '客家话',
        'en': 'Hakka',
        'ms': 'Bahasa Hakka',
        'vi': 'Tiếng Khách Gia',
        'ru': 'Язык хакка',
      },
      countryCodes: ['CN', 'TW', 'MY'],
    ),
    LanguageVariantConfig(
      code: 'nan',
      languageCode: 'zh',
      names: {
        'zh': '闽南语',
        'en': 'Southern Min',
        'ms': 'Bahasa Min Selatan',
        'vi': 'Tiếng Mân Nam',
        'ru': 'Южноминьский язык',
      },
      countryCodes: ['CN', 'TW', 'MY', 'SG'],
    ),
    LanguageVariantConfig(
      code: 'wuu',
      languageCode: 'zh',
      names: {
        'zh': '吴语',
        'en': 'Wu Chinese',
        'ms': 'Bahasa Wu',
        'vi': 'Tiếng Ngô',
        'ru': 'Язык у',
      },
      countryCodes: ['CN'],
    ),
  ];
}
