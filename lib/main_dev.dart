import 'package:gem_fitpal/config/env.dart';
import 'package:gem_fitpal/main.dart';

void main() {
  AppEnvironment.setupEnv(Environment.dev);
  mainCommon();
}
