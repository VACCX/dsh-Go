// About QUQI: app information, then the brand mark and slogan.
//
// 2026-11 QUQI 版：原作者与个人主页（B站 / X / GitHub）、开源许可入口一律不保留。
// 这与上游仓库的同名文件不再相同，属于衍生构建。

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../state/app_info.dart';
import '../../state/star_prompt.dart' show starLinkOpenerProvider;
import '../../state/update_state.dart';
import '../shell/brand_mark.dart';
import '../shell/page_frame.dart';
import '../star/star_prompt_dialog.dart' show openStarProject;
import '../theme/app_icons.dart';
import '../theme/theme.dart';
import '../update/update_tiles.dart';
import 'settings_widgets.dart';

/// The installed version as the app shows it: `8.4.9 (1)`.
String installedVersionLabel(WidgetRef ref) {
  final installed = ref.watch(installedBuildProvider);
  return installed;
}

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colors = DshColors.of(context);
    final version = installedVersionLabel(ref);
    return AppPage.list(
      title: l10n.hubAbout,
      children: [
        SettingsSection(
          children: [
            SettingsTile(
              spot: Spots.version,
              value: Text(version, style: AppType.tabular(theme.textTheme.bodyMedium!)),
            ),
            const AppUpdateTiles(),
            SettingsTile(
              key: const ValueKey('settings-star'),
              spot: Spots.star,
              onTap: () => unawaited(
                openStarProject(
                  ProviderScope.containerOf(context, listen: false),
                  ScaffoldMessenger.maybeOf(context),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          child: Column(
            children: [
              BrandMark(size: 18, color: colors.textDisabled),
              const SizedBox(height: 10),
              Text(
                AppInfo.slogan,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(color: colors.textTertiary),
              ),
              const SizedBox(height: 8),
              Text(
                AppInfo.disclaimer,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(color: colors.textTertiary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
