// Package imports:
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mangadex/utils/date_time_json_converter.dart';
import 'package:mangadex/utils/isar_utils.dart';

part 'settings.dto.g.dart';

@Collection(accessor: 'settings')
@JsonSerializable()
class SettingsWrapperDTO {
  static final constantId = fastHash('singleton_settings');
  Id get id => constantId;

  @JsonKey(includeToJson: false)
  final String result;

  @DateTimeConverter()
  final DateTime updatedAt;

  final SettingsDTO settings;

  @JsonKey(includeToJson: false)
  final String template;

  const SettingsWrapperDTO({
    required this.result,
    required this.updatedAt,
    required this.settings,
    required this.template,
  });

  factory SettingsWrapperDTO.fromJson(Map<String, dynamic> json) => _$SettingsWrapperDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsWrapperDTOToJson(this);

  factory SettingsWrapperDTO.empty() => SettingsWrapperDTO(
        result: 'ok',
        updatedAt: DateTime.now(),
        settings: const SettingsDTO(),
        template: '',
      );

  SettingsWrapperDTO copyWith({
    String? result,
    DateTime? updatedAt,
    SettingsDTO? settings,
    String? template,
  }) {
    return SettingsWrapperDTO(
      result: result ?? this.result,
      updatedAt: updatedAt ?? this.updatedAt,
      settings: settings ?? this.settings,
      template: template ?? this.template,
    );
  }
}

@embedded
@JsonSerializable()
class SettingsDTO {
  final SettingsMetadataDTO metadata;
  final SettingsPreferredLayoutDTO preferredLayout;
  final SettingsUserPreferencesDTO userPreferences;

  const SettingsDTO({
    this.metadata = const SettingsMetadataDTO(),
    this.preferredLayout = const SettingsPreferredLayoutDTO(),
    this.userPreferences = const SettingsUserPreferencesDTO(),
  });

  factory SettingsDTO.fromJson(Map<String, dynamic> json) => _$SettingsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsDTOToJson(this);

  SettingsDTO copyWith({
    SettingsMetadataDTO? metadata,
    SettingsPreferredLayoutDTO? preferredLayout,
    SettingsUserPreferencesDTO? userPreferences,
  }) {
    return SettingsDTO(
      metadata: metadata ?? this.metadata,
      preferredLayout: preferredLayout ?? this.preferredLayout,
      userPreferences: userPreferences ?? this.userPreferences,
    );
  }
}

@embedded
@JsonSerializable()
class SettingsMetadataDTO {
  final int version;

  const SettingsMetadataDTO({
    this.version = 0,
  });

  factory SettingsMetadataDTO.fromJson(Map<String, dynamic> json) => _$SettingsMetadataDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsMetadataDTOToJson(this);
}

@embedded
@JsonSerializable()
class SettingsPreferredLayoutDTO {
  final bool ambient;
  final bool oneLine;
  final int feedStyle;
  final int listStyle;
  final int listStyleNoArt;
  final int bottomNavPadding;

  const SettingsPreferredLayoutDTO({
    this.ambient = true,
    this.oneLine = false,
    this.feedStyle = 1,
    this.listStyle = 0,
    this.listStyleNoArt = 1,
    this.bottomNavPadding = 0,
  });

  factory SettingsPreferredLayoutDTO.fromJson(Map<String, dynamic> json) => _$SettingsPreferredLayoutDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsPreferredLayoutDTOToJson(this);
}

@embedded
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
    this.theme = 'system',
    this.locale = 'en',
    this.interfaceLocale = 'en',
    this.showSafe = true,
    this.showErotic = false,
    this.showHentai = false,
    this.showSuggestive = false,
    this.dataSaver = false,
    this.mdahPort443 = false,
    this.listMultiplier = 3,
    this.paginationCount = 32,
    this.userBlacklist = const [],
    this.groupBlacklist = const [],
    this.originLanguages = const [],
    this.filteredLanguages = const [],
  });

  factory SettingsUserPreferencesDTO.fromJson(Map<String, dynamic> json) => _$SettingsUserPreferencesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsUserPreferencesDTOToJson(this);

  SettingsUserPreferencesDTO copyWith({
    String? theme,
    String? locale,
    String? interfaceLocale,
    bool? showSafe,
    bool? showErotic,
    bool? showHentai,
    bool? showSuggestive,
    bool? dataSaver,
    bool? mdahPort443,
    int? listMultiplier,
    int? paginationCount,
    List<String>? userBlacklist,
    List<String>? groupBlacklist,
    List<String>? originLanguages,
    List<String>? filteredLanguages,
  }) {
    return SettingsUserPreferencesDTO(
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
      interfaceLocale: interfaceLocale ?? this.interfaceLocale,
      showSafe: showSafe ?? this.showSafe,
      showErotic: showErotic ?? this.showErotic,
      showHentai: showHentai ?? this.showHentai,
      showSuggestive: showSuggestive ?? this.showSuggestive,
      dataSaver: dataSaver ?? this.dataSaver,
      mdahPort443: mdahPort443 ?? this.mdahPort443,
      listMultiplier: listMultiplier ?? this.listMultiplier,
      paginationCount: paginationCount ?? this.paginationCount,
      userBlacklist: userBlacklist ?? this.userBlacklist,
      groupBlacklist: groupBlacklist ?? this.groupBlacklist,
      originLanguages: originLanguages ?? this.originLanguages,
      filteredLanguages: filteredLanguages ?? this.filteredLanguages,
    );
  }
}
