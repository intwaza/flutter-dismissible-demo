import 'package:flutter/widgets.dart';

/// The three Dismissible properties we change live during the demo.
class DismissSettings {
  const DismissSettings({
    this.direction = DismissDirection.horizontal,
    this.showBackgrounds = true,
    this.threshold = 0.4,
  });

  /// Exactly what Dismissible does when these properties are not set.
  static const flutterDefaults = DismissSettings(showBackgrounds: false);

  /// `direction`: which way(s) the user is allowed to swipe.
  final DismissDirection direction;

  /// `background` / `secondaryBackground`: show the colored panels or not.
  final bool showBackgrounds;

  /// `dismissThresholds`: how far (0.0 to 1.0 of the width) the user must
  /// drag before letting go dismisses the item.
  final double threshold;

  DismissSettings copyWith({
    DismissDirection? direction,
    bool? showBackgrounds,
    double? threshold,
  }) {
    return DismissSettings(
      direction: direction ?? this.direction,
      showBackgrounds: showBackgrounds ?? this.showBackgrounds,
      threshold: threshold ?? this.threshold,
    );
  }
}
