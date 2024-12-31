import 'dart:developer';

class LocalService {
  LocalService._();
  static LocalService instance = LocalService._();
  //KLocalKeys
  // static late Box commonBox;

  /* /// ====================//[CURRENTUSER]//================== ///
  Future<String> fetchCurrentUserFromHive() async {
    return LocalService.commonBox.get(CURRENTUSER) ?? '';
  }

  Future<void> configCurrentUser(String userMain) async {
    LocalService.commonBox.put(CURRENTUSER, userMain);
  } */

  static Future<void> initialisePrefs() async {}

  static Future<void> initialiseHive() async {
    try {
      // final Directory directory = await getApplicationDocumentsDirectory();
      //// Hive.init(directory.path);
      // Hive..init(directory.path);
      //   //config hive start
      // ..registerAdapter(CityEventsBucketResponseAdaptor());
      int boxStartTime = DateTime.now().millisecondsSinceEpoch;
      // commonBox = await Hive.openBox('commonbox');
      int boxEndTime = DateTime.now().millisecondsSinceEpoch;
      log('Time taken open the boxes (hive thing): ${boxEndTime - boxStartTime}ms');
    } catch (e) {
      log("Error at initializing Hive: $e");
    }
  }

  /// clear local service
  Future<void> clearLocalService() async {
    // LocalService.commonBox.put(INTERESTEDEVENTS, '');
  }
}
