class Images {
  const Images._();

  static String get logo => 'logo'.png;
  static String get placeholder => 'placeholder'.jpg;
}

extension on String {
  String get png => 'assets/image/$this.png';
  String get jpg => 'assets/image/$this.jpg';
}