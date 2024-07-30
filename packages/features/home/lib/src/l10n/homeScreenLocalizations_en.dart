import 'homeScreenLocalizations.dart';

/// The translations for English (`en`).
class HomeScreenLocalizationsEn extends HomeScreenLocalizations {
  HomeScreenLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appbarLabelHome => 'Home';

  @override
  String get bottomAppbarLabelIncome => '+';

  @override
  String get bottomAppbarLabelExpense => '-';

  @override
  String get bottomAppbarLabelTransfer => 'Tr';
}
