import 'package:girixscanner/www/grixcode/com/scopedModel/connected_model.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/user_service.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with ConnectedModel, UserService {}
