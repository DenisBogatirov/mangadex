# mangadex

Mangadex flutter client

## Getting Started

### Building assets

To build assets run `flutter pub run assets_gen build` command in terminal.
Also it's built automatically as part of `flutter pub run build_runner build`

### Translations

To build translation keys run `flutter pub run easy_localization:generate --source-dir "assets/translations" --output-dir "lib/infrastructure/translations" --
output-file "locale_keys.g.dart" --format keys`
