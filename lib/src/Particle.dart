import 'dart:math' as Math;

import 'package:pso/src/Vector.dart';

typedef double FitnessFunctionType(List<double> x);

class Particle {
  List<double> _values;
  List<double> _velocity;
  List<double> _bestvalues;
  List<double> _mins;
  List<double> _maxs;
  double _fitness;
  double _bestfitness;
  FitnessFunctionType _FitnessFunctionType;
  Math.Random _random;

  Particle(List<double> mins, List<double> maxs,
      FitnessFunctionType fitnessFunction) {
    _random = Math.Random();
    _mins = mins;
    _maxs = maxs;
    _FitnessFunctionType = fitnessFunction;
    _values = List<double>(mins.length);
    _velocity = List<double>(mins.length);
    _bestvalues = List<double>(mins.length);
    for (int i = 0; i < mins.length; i++) {
      double val = mins[i] + (maxs[i] - mins[i]) * _random.nextDouble();
      _values[i] = val;
      _bestvalues[i] = val;
      _velocity[i] = 0.0;
    }
    _fitness = _FitnessFunctionType(_values);
    _bestfitness = _fitness;
  }

  Particle deepCopy() {
    Particle newp = Particle(_mins, _maxs, _FitnessFunctionType);
    newp._bestvalues = List.from(_bestvalues);
    newp._fitness = _fitness;
    newp._values = List.from(_values);
    newp._bestfitness = _bestfitness;
    newp._velocity = List.from(_velocity);
    return newp;
  }

  List<double> getValues() {
    return _values;
  }

  List<double> getBestValues(){
    return _bestvalues;
  }

  double getFitnessValue() {
    return _fitness;
  }

  void update(double w, double c1, double c2, Particle gbest) {
    double r1 = _random.nextDouble();
    double r2 = _random.nextDouble();
    List<double> part1 = Vector.ProdWithScaler(_velocity, w);
    List<double> part2 =
        Vector.ProdWithScaler(Vector.Sub(_bestvalues, _values), c1 * r1);
    List<double> part3 =
        Vector.ProdWithScaler(Vector.Sub(gbest.getValues(), _values), c2 * r2);
    _velocity = Vector.Sum(part1, Vector.Sum(part2, part3));
    _values = Vector.Sum(_values, _velocity);
    _fitness = _FitnessFunctionType(_values);
    if (_fitness > _bestfitness) {
      _bestfitness = _fitness;
      _bestvalues = List.from(_values);
    }
  }

  @override
  String toString() {
    return 'Particle{$_values, fitness: $_fitness}';
  }
}
