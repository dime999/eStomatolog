import 'package:estomatolog_mobile/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_mobile/providers/base_provider.dart';

class OrdinacijaProvider extends BaseProvider<Ordinacija> {
  OrdinacijaProvider() : super("Ordinacija");

  @override
  Ordinacija fromJson(data) {
    return Ordinacija.fromJson(data);
  }
}
