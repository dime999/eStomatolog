import 'package:estomatolog_mobile/models/Grad/grad.dart';
import 'package:estomatolog_mobile/providers/base_provider.dart';

class GradProvider extends BaseProvider<Grad> {
  GradProvider() : super("Grad");

  @override
  Grad fromJson(data) {
    return Grad.fromJson(data);
  }
}
