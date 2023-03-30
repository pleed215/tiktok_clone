import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_configuration/video_config.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isChecked = false;
  bool _isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
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
                    context.read<VideoConfig>().toggleIsMuted();
                  },
                  value: context.watch<VideoConfig>().isMuted,
                  title: const Text("Enable auto mute?"),
                  subtitle: const Text(
                    "Videos will be muted by default",
                  ),
                ),
                SwitchListTile.adaptive(
                  onChanged: (isChecked) {
                    context.read<VideoConfig>().toggleDarkMode();
                  },
                  value: context.watch<VideoConfig>().isDarkMode,
                  title: const Text("Toggle dark mode"),
                  subtitle: const Text(
                    "If your system is set to dark mode, this value not effect anything.",
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
                CupertinoSwitch(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isSwitchOn = value;
                      });
                    }),
                CheckboxListTile(
                    value: _isChecked,
                    checkColor: Colors.white,
                    activeColor: Theme.of(context).primaryColor,
                    checkboxShape: const CircleBorder(),
                    title: const Text("helllo"),
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    }),
                SwitchListTile.adaptive(
                  value: _isSwitchOn,
                  title: const Text("Hello"),
                  onChanged: (value) {
                    setState(() {
                      _isSwitchOn = value;
                    });
                  },
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
                              onPressed: () => Navigator.of(context).pop(),
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
