import 'package:flutter_easyloading/flutter_easyloading.dart';

class Utils {
  static final String API_URL = "https://invetotrack.ugnews24.info/api/";

  static void showLoader(bool dismissable) {
    if (EasyLoading.isShow) {
      return;
    } else {
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: dismissable,
      );
    }
  }

  static void hideLoader() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    return;
  }
}
