class ImageUtils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getAnimPath(String name, {String format = 'json'}) {
    return 'assets/anim/$name.$format';
  }
}
