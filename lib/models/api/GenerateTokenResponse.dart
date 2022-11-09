import 'package:service_bee/models/generate_token.dart';

class GenerateTokenResponse {
  bool status = false;
  GenerateToken? generateToken;

  GenerateTokenResponse.fromJson(json) {
    status = true;

    generateToken = GenerateToken.fromJson(json);
  }

  GenerateTokenResponse.withError(msg) {
    status = false;
  }
}
