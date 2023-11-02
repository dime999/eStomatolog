import 'package:estomatolog_mobile/models/Termin/termin.dart';
import 'package:estomatolog_mobile/providers/base_provider.dart';

class TerminProvider extends BaseProvider<Termin> {
  TerminProvider() : super("Termin");

  @override
  Termin fromJson(data) {
    return Termin.fromJson(data);
  }
}
