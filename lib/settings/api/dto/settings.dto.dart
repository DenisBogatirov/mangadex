// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'settings.dto.g.dart';

@JsonSerializable()
class SettingsWrapperDTO {
  final String result;
  final DateTime updatedAt;
  final SettingsDTO settings;
  final String template;

  const SettingsWrapperDTO({
    required this.result,
    required this.updatedAt,
    required this.settings,
    required this.template,
  });

  factory SettingsWrapperDTO.fromJson(Map<String, dynamic> json) => _$SettingsWrapperDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsWrapperDTOToJson(this);
}

@JsonSerializable()
class SettingsDTO {
  final SettingsMetadataDTO metadata;
  final SettingsPreferredLayoutDTO preferredLayout;
  final SettingsUserPreferencesDTO userPreferences;

  const SettingsDTO({
    required this.metadata,
    required this.preferredLayout,
    required this.userPreferences,
  });

  factory SettingsDTO.fromJson(Map<String, dynamic> json) => _$SettingsDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsDTOToJson(this);
}

@JsonSerializable()
class SettingsMetadataDTO {
  final int version;

  const SettingsMetadataDTO({
    required this.version,
  });

  factory SettingsMetadataDTO.fromJson(Map<String, dynamic> json) => _$SettingsMetadataDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsMetadataDTOToJson(this);
}

@JsonSerializable()
class SettingsPreferredLayoutDTO {
  final bool ambient;
  final bool oneLine;
  final int feedStyle;
  final int listStyle;
  final int listStyleNoArt;
  final int bottomNavPadding;

  const SettingsPreferredLayoutDTO({
    required this.ambient,
    required this.oneLine,
    required this.feedStyle,
    required this.listStyle,
    required this.listStyleNoArt,
    required this.bottomNavPadding,
  });

  factory SettingsPreferredLayoutDTO.fromJson(Map<String, dynamic> json) => _$SettingsPreferredLayoutDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsPreferredLayoutDTOToJson(this);
}

@JsonSerializable()
class SettingsUserPreferencesDTO {
  final String theme;
  final String locale;
  final String interfaceLocale;
  final bool showSafe;
  final bool showErotic;
  final bool showHentai;
  final bool showSuggestive;
  final bool dataSaver;
  final bool mdahPort443;
  final int listMultiplier;
  final int paginationCount;
  final List<String> userBlacklist;
  final List<String> groupBlacklist;
  final List<String> originLanguages;
  final List<String> filteredLanguages;

  const SettingsUserPreferencesDTO({
    required this.theme,
    required this.locale,
    required this.interfaceLocale,
    required this.showSafe,
    required this.showErotic,
    required this.showHentai,
    required this.showSuggestive,
    required this.dataSaver,
    required this.mdahPort443,
    required this.listMultiplier,
    required this.paginationCount,
    required this.userBlacklist,
    required this.groupBlacklist,
    required this.originLanguages,
    required this.filteredLanguages,
  });

  factory SettingsUserPreferencesDTO.fromJson(Map<String, dynamic> json) => _$SettingsUserPreferencesDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsUserPreferencesDTOToJson(this);
}
