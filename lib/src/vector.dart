class Vector {
  /// Static method for vector summation.
  static List<double> Sum(List<double> v1, List<double> v2) {
    var result = List<double>.filled(v1.length, 0.0);
    for (var i = 0; i < v1.length; i++) {
      result[i] = v1[i] + v2[i];
    }
    return result;
  }

  /// Static method for vector subtraction
  static List<double> Sub(List<double> v1, List<double> v2) {
    var result = List<double>.filled(v1.length, 0.0);
    for (var i = 0; i < v1.length; i++) {
      result[i] = v1[i] - v2[i];
    }
    return result;
  }

  /// Static method to multiply all elements of [v1] with a [scaler].
  static List<double> ProdWithScaler(List<double> v1, double scaler) {
    var result = List<double>.filled(v1.length, 0.0);
    for (var i = 0; i < v1.length; i++) {
      result[i] = v1[i] * scaler;
    }
    return result;
  }
}
