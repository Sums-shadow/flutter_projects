//JAVA
import android.view.WindowManager.LayoutParams;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.embedding.android.FlutterActivity;

@Override
protected void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  getWindow().addFlags(LayoutParams.FLAG_SECURE);
      // GeneratedPluginRegistrant.registerWith(this);
}


//FLUUTER
import 'package:flutter_windowmanager/flutter_windowmanager.dart';


  @override
  void initState() {
    super.initState();
    disableCapture();
  }

  Future<void> disableCapture() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
