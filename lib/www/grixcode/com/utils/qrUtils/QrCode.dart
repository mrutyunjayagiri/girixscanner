class QrCode {
  static final _email = "EMAIL:";

  static String createEmail({String email, String body, String subject}) {
    return _email + email + ";Subject: " + subject + ";Body: " + body;
  }
}
