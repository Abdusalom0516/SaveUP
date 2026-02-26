import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState extends Equatable {
  const SettingsState({this.fontIndex = 0, this.colorIndex = 0});

  final int fontIndex;
  final int colorIndex;

  SettingsState copyWith({int? fontIndex, int? colorIndex}) => SettingsState(
        fontIndex: fontIndex ?? this.fontIndex,
        colorIndex: colorIndex ?? this.colorIndex,
      );

  @override
  List<Object?> get props => [fontIndex, colorIndex];
}

class SettingsCubit extends Cubit<SettingsState> {
  static const _fontKey = 'settings_font_index';
  static const _colorKey = 'settings_color_index';

  final SharedPreferences _prefs;

  SettingsCubit(SharedPreferences prefs)
      : _prefs = prefs,
        super(SettingsState(
          fontIndex: prefs.getInt(_fontKey) ?? 0,
          colorIndex: prefs.getInt(_colorKey) ?? 0,
        ));

  void setFont(int index) {
    _prefs.setInt(_fontKey, index);
    emit(state.copyWith(fontIndex: index));
  }

  void setColor(int index) {
    _prefs.setInt(_colorKey, index);
    emit(state.copyWith(colorIndex: index));
  }
}
