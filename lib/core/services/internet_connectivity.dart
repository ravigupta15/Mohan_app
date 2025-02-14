import 'dart:io';

class InternetConnectivity {

  
  static Future<bool> isConnected()async{
    try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
        else{
          return false;
        }

    } catch (e) {
      return false;
    }
  }
}