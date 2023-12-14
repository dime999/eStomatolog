class Validators {
  static final RegExp samoSlova = RegExp(r'^[a-zA-Z]+$');
  static final RegExp minimalno9Cifara = RegExp(r'^\d{9,}$');
  static final RegExp validnaEmailAdresa =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  static final RegExp korisnickoIme = RegExp(r'^[a-zA-Z0-9]+$');
  static final RegExp adresa = RegExp(r'^[a-zA-Z0-9\s.,]+$');

  static bool validirajIme(String value) {
    return samoSlova.hasMatch(value) && value.isNotEmpty;
  }

  static bool validirajPrezime(String value) {
    return samoSlova.hasMatch(value) && value.isNotEmpty;
  }

  static bool validirajBrojTelefona(String value) {
    return minimalno9Cifara.hasMatch(value) && value.isNotEmpty;
  }

  static bool validirajEmail(String value) {
    return validnaEmailAdresa.hasMatch(value) && value.isNotEmpty;
  }

  static bool validirajKorisnickoIme(String value) {
    return korisnickoIme.hasMatch(value) && value.isNotEmpty;
  }

  static bool validirajLozinku(String value) {
    return value.length >= 4;
  }

  static bool validirajLozinkuUpdate(String value) {
    return value.length >= 4 || value.isEmpty;
  }

  static bool validirajAdresu(String value) {
    return adresa.hasMatch(value) && value.isNotEmpty;
  }
}
