import 'package:connection_verify/connection_verify.dart';

class CheckConncection{

  Future<bool> checkInternetConnection() async {
    if (await ConnectionVerify.connectionStatus()) {
      return true;
    }else
      return false;
  }
}