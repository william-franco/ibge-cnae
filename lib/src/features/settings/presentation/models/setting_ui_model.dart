class SettingUiModel {
  final bool isDarkTheme;

  SettingUiModel({this.isDarkTheme = false});

  SettingUiModel copyWith({bool? isDarkTheme}) =>
      SettingUiModel(isDarkTheme: isDarkTheme ?? this.isDarkTheme);
}