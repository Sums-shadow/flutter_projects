// Import the Firebase Core package
import 'package:firebase_core/firebase_core.dart';

// Add async/await and 2 lines of code to the main function
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}