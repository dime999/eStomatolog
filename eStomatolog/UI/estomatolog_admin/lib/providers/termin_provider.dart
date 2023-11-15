import 'package:estomatolog_admin/models/Termin/termin.dart';
import 'package:estomatolog_admin/providers/base_provider.dart';

class TerminProvider extends BaseProvider<Termin> {
  TerminProvider() : super("Termin");

  @override
  Termin fromJson(data) {
    return Termin.fromJson(data);
  }
}
