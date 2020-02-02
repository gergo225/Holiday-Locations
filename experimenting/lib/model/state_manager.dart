import 'package:flutter/material.dart';

class StateManager with ChangeNotifier {
  String _selectedCountry;
  IconData _selectedMenuIcon;
  Set<String> _favoriteCountries;

  StateManager(
    this._selectedCountry,
    this._selectedMenuIcon,
  ) {
    _favoriteCountries = Set<String>();
  }

  get selectedCountry => _selectedCountry;
  get selectedMenuIcon => _selectedMenuIcon;

  set selectedCountry(String value) {
    if (selectedCountry != value) {
      _selectedCountry = value;
      notifyListeners();
    }
  }

  set selectedMenuIcon(IconData value) {
    if (selectedMenuIcon != value) {
      _selectedMenuIcon = value;
      notifyListeners();
    }
  }

  bool isFavoriteCountry(String country) =>
      _favoriteCountries.contains(country);

  void updateSelectedCountry(String newCountry) => selectedCountry = newCountry;

  void updateMenuIcon(IconData newIcon) => selectedMenuIcon = newIcon;

  void updateFavoriteCountries(String pressedCountry) {
    if (isFavoriteCountry(pressedCountry)) {
      _favoriteCountries.remove(pressedCountry);
    } else {
      _favoriteCountries.add(pressedCountry);
    }
    notifyListeners();
  }
}
