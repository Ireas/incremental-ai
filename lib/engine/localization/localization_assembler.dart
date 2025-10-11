import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/localization_repository.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_current_language_usecase.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_placeholder_usecase.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_translate_usecase.dart';
import 'package:logger/logger.dart';

/// Assembler for the localization framework. Injects repository and usecases into GetIt.
class LocalizationAssembler {
  final Logger _logger = Logger();

  /// Initializes repository and injects GetIt singletons.
  Future<void> assemble() async {
    _logger.t("Assembling Localization");

    // assemble and register repository
    LocalizationRepository repository = LocalizationRepository();
    await repository.initialize();
    GetIt.I.registerSingleton<LocalizationRepository>(repository);

    // assemble and register usecases
    GetIt.I.registerSingleton<LocalizationCurrentLanguageUsecase>(LocalizationCurrentLanguageUsecase(repository));
    GetIt.I.registerSingleton<LocalizationTranslateUsecase>(LocalizationTranslateUsecase(repository));
    GetIt.I.registerSingleton<LocalizationPlaceholderUsecase>(LocalizationPlaceholderUsecase(repository));

    // validate after assembly
    repository.validate();
  }
}
