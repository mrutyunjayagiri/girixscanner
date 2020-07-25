abstract class BarcodeItem {}

class BarcodeHeader extends BarcodeItem {
  final String dateText;
  final DateTime dateTime;

  BarcodeHeader({this.dateText, this.dateTime});
}
