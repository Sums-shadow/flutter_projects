//error widget sert a renvoyer un widget quand il y a une erreur
void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return <your widget>;
  };

  return runApp(MyApp());
}