import 'package:url_launcher/url_launcher.dart';

extension IntentExt on String {
  Future<void> phoneCall() async {
    final uri = Uri.parse('tel:$this');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'phone not exit! $this';
    }
  }

  Future<void> launch() async {
    final uri = Uri.parse(this);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'url not exit! $this';
    }
  }

  void get sendSms => 'sms:$this'.launch();

  void get sendEmail => 'mailto:$this'.launch();

  String get replaceFirstZero => replaceFirst(RegExp(r'^0*'), '');
}
