import 'package:flutter/material.dart';

import '../models/dismiss_settings.dart';

/// Controls for changing the three Dismissible properties while the app runs.
class SettingsPanel extends StatelessWidget {
  const SettingsPanel({
    super.key,
    required this.settings,
    required this.onChanged,
  });

  final DismissSettings settings;
  final ValueChanged<DismissSettings> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      elevation: 8,
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Dismissible properties', style: textTheme.titleMedium),
                  const Spacer(),
                  TextButton(
                    onPressed: () => onChanged(DismissSettings.flutterDefaults),
                    child: const Text('Flutter defaults'),
                  ),
                ],
              ),

              // 1. direction
              const _Label('direction', 'default: horizontal'),
              SegmentedButton<DismissDirection>(
                segments: const [
                  ButtonSegment(
                    value: DismissDirection.horizontal,
                    label: Text('Both'),
                  ),
                  ButtonSegment(
                    value: DismissDirection.endToStart,
                    label: Text('Left only'),
                  ),
                  ButtonSegment(
                    value: DismissDirection.startToEnd,
                    label: Text('Right only'),
                  ),
                ],
                selected: {settings.direction},
                onSelectionChanged: (selection) =>
                    onChanged(settings.copyWith(direction: selection.first)),
              ),

              // 2. background
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const _Label('background', 'default: null'),
                value: settings.showBackgrounds,
                onChanged: (value) =>
                    onChanged(settings.copyWith(showBackgrounds: value)),
              ),

              // 3. dismissThresholds
              _Label(
                'dismissThresholds',
                'default: 40%  •  now: ${(settings.threshold * 100).round()}%',
              ),
              Slider(
                value: settings.threshold,
                min: 0.2,
                max: 0.8,
                divisions: 12,
                label: '${(settings.threshold * 100).round()}%',
                onChanged: (value) =>
                    onChanged(settings.copyWith(threshold: value)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A property name in code style, followed by its default value.
class _Label extends StatelessWidget {
  const _Label(this.property, this.hint);

  final String property;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text.rich(
        // Fixed style, so all three labels look the same even inside a ListTile.
        style: Theme.of(context).textTheme.bodyMedium,
        TextSpan(
          children: [
            TextSpan(
              text: property,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '   $hint',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
