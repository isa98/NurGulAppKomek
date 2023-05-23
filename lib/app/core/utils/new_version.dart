import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../library/library.dart';

Future<void> checkVersion(BuildContext context) async {
  // Instantiate NewVersion manager object (Using GCP Console app as example)
  final newVersion = NewVersion();

  final status = await newVersion.getVersionStatus();
  if (status != null) {
    debugPrint('status.releaseNotes ${status.releaseNotes}');
    debugPrint('status.appStoreLink ${status.appStoreLink}');
    debugPrint('status.localVersion ${status.localVersion}');
    debugPrint('status.storeVersion ${status.storeVersion}');
    debugPrint('status.canUpdate ${status.canUpdate.toString()}');
    final canUpdate = status.canUpdate;
    if (canUpdate) {
      // ignore: use_build_context_synchronously
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'update_title'.tr,
        dialogText: 'update_text'.tr,
        updateButtonText: 'update_btn'.tr,
        dismissButtonText: 'update_later_btn'.tr,
      );
    }
  }
}
