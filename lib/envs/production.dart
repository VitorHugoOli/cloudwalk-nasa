import 'package:cloudwalknasa/envs/base.dart';

// The API is exposed, but we could assign different keys for each environment.
// For production, we could leave the file containing the NasaApi key empty,
// and overwrite this file during the CI/CD pipeline process.
// By doing so, we avoid exposing the production API key, thereby enhancing security.
class ProductionEnv extends Environments {
  @override
  String get NASAAPIKEY => "YMYZQqMtc73mwvojfnICbeOhN8ljY0O5sZGL1xte";
}
