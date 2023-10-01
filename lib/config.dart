import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

  static final Env _instance = Env._internal();

  Env._internal();

  static Env get instance => _instance;
}
