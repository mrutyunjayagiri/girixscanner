import 'package:girixscanner/www/grixcode/com/scopedModel/connected_model.dart';

class ActionHandler extends ConnectedModel {
  void disposeLoader() {
    isLoading = false;
    print("Loading disposed");
    notifyListeners();
  }
}
