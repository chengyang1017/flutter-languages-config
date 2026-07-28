import 'languages.dart';
import 'language_variants.dart';

class CountryLanguageConfig {
  final String languageCode;

  /// 这个国家实际使用的方言。
  final List<String> variantCodes;

  /// 进入该语言时默认选择的方言。
  final String? defaultVariantCode;

  /// 是否允许直接选择语言，而不强制选择方言。
  final bool allowDirectSelection;

  const CountryLanguageConfig({
    required this.languageCode,
    this.variantCodes = const [],
    this.defaultVariantCode,
    this.allowDirectSelection = true,
  });

  LanguageConfig? get language {
    return LanguageConfig.findByCode(
      languageCode,
    );
  }

  List<LanguageVariantConfig> get variants {
    return LanguageVariantConfig.findByCodes(
      variantCodes,
    );
  }

  LanguageVariantConfig? get defaultVariant {
    final code = defaultVariantCode;

    if (code == null) {
      return null;
    }

    return LanguageVariantConfig.findByCode(
      code,
    );
  }

  bool get hasVariants {
    return variantCodes.isNotEmpty;
  }
}