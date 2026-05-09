import 'package:flutter/material.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  
  bool get isDarkMode => theme.brightness == Brightness.dark;
  
  Color get primaryColor => colorScheme.primary;
  Color get onPrimary => colorScheme.onPrimary;
  Color get secondaryColor => colorScheme.secondary;
  Color get onSecondary => colorScheme.onSecondary;
  Color get backgroundColor => colorScheme.surface;
  Color get onBackgroundColor => colorScheme.onSurface;
  Color get errorColor => colorScheme.error;
  Color get onError => colorScheme.onError;
  
  Color get surfaceColor => colorScheme.surface;
  Color get onSurface => colorScheme.onSurface;
}
