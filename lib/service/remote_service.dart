// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:in_app_update/in_app_update.dart';
// import 'package:intelligere/components/dialogs/k_dialog.dart';
// import 'package:intelligere/present/home/compo/k_alert_dialog.dart';
// import 'package:intelligere/utils/constants/k_colors.dart';
// import 'package:intelligere/utils/constants/k_styles.dart';

// final remoteConfigProvider = Provider<FirebaseRemoteConfig>((ref) {
//   return FirebaseRemoteConfig.instance;
// });

// class RemoteService {
//   final Ref _ref;
//   RemoteService(this._ref);

//   /// Independent Function to fetch update status
//   Future<(bool, bool)> checkFirebaseRemoteConfigForUpdateStatus() async {
//     try {
//       await _ref.read(remoteConfigProvider).fetchAndActivate();
//       bool isUpdate =
//           _ref.read(remoteConfigProvider).getBool('update_available');
//       bool isMandatoryUpdate =
//           _ref.read(remoteConfigProvider).getBool('update_required');
//       return (isUpdate, isMandatoryUpdate);
//     } catch (e) {
//       return (false, false);
//     }
//   }

//   /// Independent Function to fetch block app status
//   Future<bool> checkFirebaseRemoteConfigForRestriction() async {
//     try {
//       await _ref.read(remoteConfigProvider).fetchAndActivate();
//       bool isMandatoryRestrict =
//           _ref.read(remoteConfigProvider).getBool('block_app');
//       return isMandatoryRestrict;
//     } catch (e) {
//       return false;
//     }
//   }

//   /// Prime Function to fetch Restrictions
//   Future<void> checkforRestriction() async {
//     await Future.delayed(Duration.zero);
//     await _ref.read(remoteConfigProvider).setConfigSettings(
//           RemoteConfigSettings(
//             fetchTimeout: const Duration(seconds: 20),
//             minimumFetchInterval: const Duration(seconds: 0),
//           ),
//         );

//     bool restrictionAvailable = await checkFirebaseRemoteConfigForRestriction();
//     if (restrictionAvailable) {
//       await redirectRestriction(block: restrictionAvailable);
//     } else {
//       log("no restrictions");
//     }
//   }

//   /// Prime Function to fetch Update Status
//   Future<void> checkForUpdate() async {
//     try {
//       await Future.delayed(Duration.zero);
//       await _ref.read(remoteConfigProvider).setConfigSettings(
//             RemoteConfigSettings(
//               fetchTimeout: const Duration(seconds: 20),
//               minimumFetchInterval: const Duration(seconds: 0),
//             ),
//           );

//       (bool, bool) updateAvailable =
//           await checkFirebaseRemoteConfigForUpdateStatus();
//       if (Platform.isAndroid) {
//         await redirectUpdateAndroid(updateAvailable: updateAvailable);
//       } else {
//         redirectUpdateiOS(updateAvailable: updateAvailable);
//       }
//     } catch (e) {
//       log("$e", name: "checkForUpdate Error");
//     }
//   }

//   /// Restriction dialog
//   Future<void> redirectRestriction({required bool block}) async {
//     _ref.read(dialogProvider).openDialog(
//           barrierDismissible: false,
//           // ignore: deprecated_member_use
//           dialog: WillPopScope(
//             onWillPop: () => Future.value(false),
//             child: KAlertDialog(
//               title: "Error",
//               actiontitle: "Contact Admin",
//               subtitle: "Something went wrong",
//               onAction: () {},
//               onCancel: () {},
//               canceltitle: "Ask Later",
//               actions: [
//                 CupertinoDialogAction(
//                   onPressed: () {
//                     SystemNavigator.pop();
//                   },
//                   child: Text(
//                     "Contact Admin",
//                     style: Kstyles.kButtonStyle.copyWith(
//                       color: KColors.primaryColor,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//   }

//   /// update dialog for iOS
//   Future<void> redirectUpdateAndroid(
//       {required (bool, bool) updateAvailable}) async {
//     try {
//       InAppUpdate.checkForUpdate().then((updateInfo) {
//         if (updateInfo.updateAvailability ==
//             UpdateAvailability.updateAvailable) {
//           // if (updateInfo.flexibleUpdateAllowed) {
//           if (!updateAvailable.$2) {
//             InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
//               if (appUpdateResult == AppUpdateResult.success) {
//                 //App Update successful
//                 InAppUpdate.completeFlexibleUpdate();
//               }
//             });
//           } else {
//             InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
//               if (appUpdateResult == AppUpdateResult.success) {
//                 //App Update successful
//               }
//             });
//           }
//         }
//       }).catchError((e) {
//         log("$e", name: "In App update Error");
//         return e;
//       }).onError((e, st) {
//         log("$e", name: "In App update ON Catch Error");
//         // return s;
//       });
//     } catch (e) {
//       log("$e", name: "Redirect Android update Error");
//     }
//   }

//   /// update dialog for iOS
//   Future<void> redirectUpdateiOS(
//       {required (bool, bool) updateAvailable}) async {
//     if (updateAvailable.$1) {
//       _ref.read(dialogProvider).openDialog(
//             barrierDismissible: !updateAvailable.$2,
//             // ignore: deprecated_member_use
//             dialog: WillPopScope(
//               onWillPop: () => Future.value(!updateAvailable.$2),
//               child: KAlertDialog(
//                 title: "New update available",
//                 actiontitle: "Update Now",
//                 subtitle: updateAvailable.$2
//                     ? 'A new version of Intelligere is available, Kindly update !'
//                     : 'A new version of Intelligere is available, do you want to upgrade?',
//                 onAction: () {},
//                 onCancel: () {},
//                 canceltitle: "Ask Later",
//                 actions: (updateAvailable.$2)
//                     ? [
//                         CupertinoDialogAction(
//                           onPressed: () {},
//                           child: Text(
//                             "Update Now",
//                             style: Kstyles.kButtonStyle.copyWith(
//                               color: KColors.primaryColor,
//                             ),
//                           ),
//                         )
//                       ]
//                     : null,
//               ),
//             ),
//           );
//     }
//   }
// }
