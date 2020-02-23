import 'dart:math' as _math;
import 'package:pso/pso.dart';

double f(List<double> x){
  double s = 0.0;
  s = _math.pow(x[0] - 3.14159265, 2.0) + _math.pow(x[1] - 2.71828, 2.0);
  return -s;
}

void main() {
  List<double> mins = [-10, -10];
  List<double> maxs = [10, 10];

  PSO pso = PSO(f, 100, mins, maxs);
  pso.iterateN(500);

  Particle result = pso.findGBest();
  print(result);
}
