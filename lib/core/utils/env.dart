import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
  path: '.env',
  obfuscate: true,
)
abstract class Env {
  @EnviedField(varName: 'API_KEY_AUTH', obfuscate: true)
  static String apiKeyAuth = _Env.apiKeyAuth;

  @EnviedField(varName: 'ACCESS_TOKEN_AUTH', obfuscate: true)
  static String accessTokenAuth = _Env.accessTokenAuth;
}
