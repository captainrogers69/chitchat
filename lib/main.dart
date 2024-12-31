import 'dart:developer';

import 'package:chitchat/app/chat_app.dart';
import 'package:chitchat/firebase_options.dart';
import 'package:chitchat/service/local_service.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalService.initialisePrefs();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ChatApp());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Color(0XFFFFFFFF),
    ),
  );

  String storageLocation = (await getApplicationDocumentsDirectory()).path;
  await FastCachedImageConfig.init(
      subDir: storageLocation, clearCacheAfter: const Duration(days: 5));

  if (!kDebugMode) {
    try {
      FlutterError.onError = (errorDetails) {
        if (errorDetails.library == 'image resource service') {
          return;
        }
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };

      /// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    } catch (e) {
      log("Error Initialising Crashlytics:: $e");
    }
  }
}
