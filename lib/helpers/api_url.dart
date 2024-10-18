class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/';
  static const String registrasi = baseUrl + 'api/registrasi';
  static const String login = baseUrl + 'api/login';
  static const String listBahasa = baseUrl + 'api/buku/bahasa';
  static const String createBahasa = baseUrl + 'api/buku/bahasa';

  static String updateBahasa(int id) {
    return baseUrl + 'api/buku/bahasa/' + id.toString() + '/update';
  }

  static String showBahasa(int id) {
    return baseUrl + 'api/buku/bahasa/' + id.toString();
  }

  static String deleteBahasa(int id) {
    return baseUrl + 'api/buku/bahasa/' + id.toString() + '/delete';
  }
}
