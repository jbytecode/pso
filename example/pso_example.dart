import 'dart:math' as _math;
import 'package:pso/pso.dart';

double f(List<double> x) {
  var s = 0.0;
  s = _math.pow(x[0] - 3.14159265, 2.0) + _math.pow(x[1] - 2.71828, 2.0)
      as double;
  return -s;
}

void main() {
  var mins = <double>[-10, -10];
  var maxs = <double>[10, 10];

  var pso = PSO(f, 100, mins, maxs);
  pso.iterateN(500);

  var result = pso.findGBest();
  print(result);
}
