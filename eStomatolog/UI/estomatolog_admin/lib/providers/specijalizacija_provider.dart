import 'package:estomatolog_admin/models/Specijalizacija/specijalizacija.dart';
import 'package:estomatolog_admin/providers/base_provider.dart';

class SpecijalizacijaProvider extends BaseProvider<Specijalizacija> {
  SpecijalizacijaProvider() : super("Specijalizacija");

  @override
  Specijalizacija fromJson(data) {
    return Specijalizacija.fromJson(data);
  }
}
