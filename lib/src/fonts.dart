class FontConfig {
  final String id;
  final String family;
  final String displayName;

  /// 支持的文字代码。
  final List<String> scriptCodes;

  /// 字体来源说明，不是字体文件本身。
  final String? source;

  /// 是否推荐作为默认字体。
  final bool isPreferred;

  const FontConfig({
    required this.id,
    required this.family,
    required this.displayName,
    required this.scriptCodes,
    this.source,
    this.isPreferred = false,
  });

  static FontConfig? findById(String id) {
    final normalized = id.trim().toLowerCase();

    for (final font in allFonts) {
      if (font.id.toLowerCase() == normalized) {
        return font;
      }
    }

    return null;
  }

  static List<FontConfig> findByIds(
    Iterable<String> ids,
  ) {
    return ids
        .map(findById)
        .whereType<FontConfig>()
        .toList(growable: false);
  }

  static const List<FontConfig> allFonts = [
    FontConfig(
      id: 'noto-sans',
      family: 'Noto Sans',
      displayName: 'Noto Sans',
      scriptCodes: [
        'Latn',
        'Cyrl',
        'Grek',
      ],
      source: 'Google Noto',
      isPreferred: true,
    ),
    FontConfig(
      id: 'nom-na-tong',
      family: 'NomNaTong',
      displayName: 'Nom Na Tong',
      scriptCodes: [
        'Hnom',
        'Hani',
      ],
      source: 'Nom Foundation',
      isPreferred: true,
    ),
  ];
}