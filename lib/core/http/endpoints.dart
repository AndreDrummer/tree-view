class Endpoints {
  static String get companies => "/companies";

  static String locations(String companyId) {
    return "/companies/$companyId/locations";
  }

  static String assets(String companyId) {
    return "/companies/$companyId/assets";
  }
}
