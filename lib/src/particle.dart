import 'dart:math' as _math;

import 'package:pso/src/vector.dart';

typedef FitnessFunctionType = double Function(List<double> x);

class Particle {
  /// Holds the values of the candidate solution
  late List<double> _values;

  /// Velocity vector for changing values in all directions
  late List<double> _velocity;

  /// Keeps the best value that is ever reached
  late List<double> _bestvalues;

  /// Lower bounds of the random initial values
  late List<double> _mins;

  /// Upper bounds of the random initial values
  late List<double> _maxs;

  /// Current fitness value returned from the objective function
  late double _fitness;

  /// Best fitness ever reached by this [Particle]
  late double _bestfitness;

  /// A function that takes a List<double> and returns a double
  /// This function is used to measure how current Particle is good
  late FitnessFunctionType _FitnessFunctionType;

  /// Randomization object
  late _math.Random _random;

  /// The constructor, [_mins] for lower bounds of each variable
  /// [_maxs] for upper bounds of each variable
  /// [_FitnessFunctionType] for calculating how the current [Particle] is good
  /// at satisfying the objective function.
  Particle(List<double> mins, List<double> maxs,
      FitnessFunctionType fitnessFunction) {
    _random = _math.Random();
    _mins = mins;
    _maxs = maxs;
    _FitnessFunctionType = fitnessFunction;
    _values = List<double>.filled(mins.length, 0.0);
    _velocity = List<double>.filled(mins.length, 0.0);
    _bestvalues = List<double>.filled(mins.length, 0.0);
    for (var i = 0; i < mins.length; i++) {
      var val = mins[i] + (maxs[i] - mins[i]) * _random.nextDouble();
      _values[i] = val;
      _bestvalues[i] = val;
      _velocity[i] = 0.0;
    }
    _fitness = _FitnessFunctionType(_values);
    _bestfitness = _fitness;
  }

  /// Deep copies (clones) the current [Particle].
  Particle deepCopy() {
    var newp = Particle(_mins, _maxs, _FitnessFunctionType);
    newp._bestvalues = List.from(_bestvalues);
    newp._fitness = _fitness;
    newp._values = List.from(_values);
    newp._bestfitness = _bestfitness;
    newp._velocity = List.from(_velocity);
    return newp;
  }

  /// Returns the current [_values]
  List<double> getValues() {
    return _values;
  }

  /// Returns the best [_values] that ever reached.
  List<double> getBestValues() {
    return _bestvalues;
  }

  /// Returns the current fitness
  double getFitnessValue() {
    return _fitness;
  }

  /// Updates the current [Particle] using formulas:
  /// velocity(t+1) = w * velocity(t) + r1 * c1 * (best - x) + r2 * c2 * (gbest * x)
  /// x(t+1) = x(t) + velocity(t+1)
  /// where best is the current [Particles] best value that is ever reached
  /// gbest is the global best in the whole population
  void update(double w, double c1, double c2, Particle gbest) {
    var r1 = _random.nextDouble();
    var r2 = _random.nextDouble();
    var part1 = Vector.ProdWithScaler(_velocity, w);
    var part2 =
        Vector.ProdWithScaler(Vector.Sub(_bestvalues, _values), c1 * r1);
    var part3 =
        Vector.ProdWithScaler(Vector.Sub(gbest.getValues(), _values), c2 * r2);
    _velocity = Vector.Sum(part1, Vector.Sum(part2, part3));
    _values = Vector.Sum(_values, _velocity);
    _fitness = _FitnessFunctionType(_values);
    if (_fitness > _bestfitness) {
      _bestfitness = _fitness;
      _bestvalues = List.from(_values);
    }
  }

  /// A string representation of the current [Particle]
  @override
  String toString() {
    return 'Particle{$_values, fitness: $_fitness}';
  }
}
