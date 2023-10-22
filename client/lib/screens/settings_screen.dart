import 'package:client/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.put(SettingsController());

    void toggleDarkMode(bool switchTo) {
      settingsController.isDarkMode = switchTo;
    }

    return Obx(
      () => Column(
        children: [
          SwitchListTile.adaptive(
            title: const Text('Dark Mode'),
            value: settingsController.isDarkMode,
            onChanged: toggleDarkMode,
          ),
        ],
      ),
    );
  }
}
