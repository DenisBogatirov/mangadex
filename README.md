# mangadex

Mangadex flutter client

## Getting Started

### Generating files

To generate all required files run `dart run build_runner build` or `dart run build_runner build  --delete-conflicting-outputs`

### Building assets

To build assets run `dart run assets_gen build` command in terminal.
Also it's built automatically as part of `dart run build_runner build`

### Translations

To build translation keys run `dart run easy_localization:generate --source-dir "assets/translations" --output-dir "lib/infrastructure/translations" --output-file "locale_keys.g.dart" --format keys`
