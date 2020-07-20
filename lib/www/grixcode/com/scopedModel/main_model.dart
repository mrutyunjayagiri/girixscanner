import 'package:girixscanner/www/grixcode/com/models/settings/settings.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/barcodeService/barcode_service.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/barcodeService/qr_code_service.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/connected_model.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/handler.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/user_service.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model
    with
        ConnectedModel,
        UserService,
        Settings,
        BarcodeService,
        ActionHandler,
        QrCodeService {}
