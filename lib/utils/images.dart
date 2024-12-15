class Images {
  const Images._();

  static String get logo => 'logo'.png;
  static String get logoWithName => 'logo_with_name'.png;
  static String get placeholder => 'placeholder'.jpg;
  static String get notLogin => 'not_login'.gif;
}


extension on String {
  String get png => 'assets/image/$this.png';
  String get jpg => 'assets/image/$this.jpg';
  String get gif => 'assets/image/$this.gif';
}