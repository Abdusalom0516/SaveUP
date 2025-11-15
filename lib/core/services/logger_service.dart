import 'package:logger/web.dart';

class LoggerService {
  static final logger = Logger();

  static void d({required String message}) {
    logger.d(message);
  }

  static void e({required String message}) {
    logger.e(message);
  }

  static void i({required String message}) {
    logger.i(message);
  }

  static void w({required String message}) {
    logger.w(message);
  }
}
