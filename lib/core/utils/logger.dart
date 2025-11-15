import 'package:logger/web.dart';

class LoggerService {
  static final logger = Logger();

  static d({required String message}) {
    logger.d(message);
  }

  static e({required String message}) {
    logger.e(message);
  }

  static i({required String message}) {
    logger.i(message);
  }

  static w({required String message}) {
    logger.w(message);
  }
}
