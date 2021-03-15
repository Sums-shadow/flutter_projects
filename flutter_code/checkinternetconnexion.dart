Future<bool> _checkInternetConnection() async {
  //kindacode
  try {
    final response = await InternetAddress.lookup('www.kindacode.com');
    if (response.isNotEmpty) {
      return true;
    }
  } on SocketException catch (err) {
    print(err);
    return false;
  }
}
