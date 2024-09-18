import 'package:fisatest/app/global/env/base/base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => "https://db.ygoprodeck.com/";
}
