// Package imports:
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'di.config.dart';

@InjectableInit()
Future<void> configureDependencies() => GetIt.instance.init();
