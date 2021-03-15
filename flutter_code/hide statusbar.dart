void main() {
  // Add these 2 lines 
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([
     SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);

  // Then call runApp() as normal
  runApp(MyApp());
}
  
  
  
  //on specific screen
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(
      [
        SystemUiOverlay.bottom, //This line is used for showing the bottom bar
      ]
    );
  }