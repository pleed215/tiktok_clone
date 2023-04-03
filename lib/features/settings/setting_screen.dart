import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/features/authentication/log_in.dart';
import 'package:tiktok_clone/features/authentication/respository/authentication_repository.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_view_model.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations.override(
      locale: Locale('es'),
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Setting"),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: Breakpoints.md.toDouble()),
            alignment: Alignment.topCenter,
            child: ListView(
              children: [
                SwitchListTile.adaptive(
                  onChanged: (isChecked) {
                    ref
                        .read(playbackConfigProvider.notifier)
                        .setMuted(isChecked);
                  },
                  value: ref.watch(playbackConfigProvider).muted,
                  title: const Text("Enable auto mute?"),
                  subtitle: const Text(
                    "Videos will be muted by default",
                  ),
                ),
                SwitchListTile.adaptive(
                  onChanged: (isChecked) {
                    ref
                        .read(playbackConfigProvider.notifier)
                        .setAutoplay(isChecked);
                  },
                  value: ref.watch(playbackConfigProvider).autoplay,
                  title: const Text("Enable autoplay"),
                  subtitle: const Text(
                    "This option will always auto play videos.",
                  ),
                ),
                ListTile(
                  onTap: () => showAboutDialog(
                      context: context,
                      applicationVersion: "1.0",
                      applicationLegalese:
                          "All rights reserved. Don't copy me"),
                  title: const Text("About"),
                  subtitle: const Text("about this app..."),
                ),
                const AboutListTile(
                    applicationVersion: "1.0",
                    applicationLegalese: "All rights reserved. Don't copy me"),
                ListTile(
                    title: const Text("What is your birthday?"),
                    onTap: () async {
                      final dateTime = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(1920),
                        lastDate: DateTime.now(),
                      );
                    }),
                CupertinoSwitch(value: false, onChanged: (value) {}),
                CheckboxListTile(
                    value: false,
                    checkColor: Colors.white,
                    activeColor: Theme.of(context).primaryColor,
                    checkboxShape: const CircleBorder(),
                    title: const Text("helllo"),
                    onChanged: (value) {}),
                SwitchListTile.adaptive(
                  value: false,
                  title: const Text("Hello"),
                  onChanged: (value) {},
                ),
                ListTile(
                    title: const Text("Log out(ios)"),
                    textColor: Colors.red,
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text("Hello"),
                          content: const Text("Please don't go"),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("No"),
                              isDestructiveAction: true,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            CupertinoDialogAction(
                              child: const Text("Yes"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                    }),
                ListTile(
                    title: const Text("Log out(material)"),
                    textColor: Colors.red,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          icon: const FaIcon(FontAwesomeIcons.skull),
                          title: const Text("Hello"),
                          content: const Text("Please don't go"),
                          actions: [
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.car),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text("Yes"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                    }),
                ListTile(
                    title: const Text("Log out(ios, modalPopup)"),
                    textColor: Colors.red,
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          title: const Text("Hello"),
                          actions: [
                            CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("No"),
                            ),
                            CupertinoActionSheetAction(
                              isDefaultAction: true,
                              onPressed: () {
                                ref.read(authRepo).logout();
                                Navigator.of(context).pop();
                                context.goNamed(LogInScreen.routeName);
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
