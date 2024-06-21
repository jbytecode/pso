import 'Particle.dart';

class PSO {
  late List<Particle> _population;

  Particle findGBest() {
    var b = _population[0].getFitnessValue();
    var result = _population[0];
    for (var i = 1; i < _population.length; i++) {
      var f = _population[i].getFitnessValue();
      if (f > b) {
        b = f;
        result = _population[i];
      }
    }
    return result.deepCopy();
  }

  List<Particle> getPopulation() {
    return _population;
  }

  PSO(FitnessFunctionType fitnessFunction, int popsize, List<double> mins,
      List<double> maxs) {
    _population =
        List<Particle>.filled(popsize, Particle(mins, maxs, fitnessFunction));
    for (var i = 0; i < popsize; i++) {
      _population[i] = Particle(mins, maxs, fitnessFunction);
    }
  }

  void iterate() {
    iterateWithParameters(0.5, 1, 1);
  }

  void iterateN(int n) {
    for (var i = 0; i < n; i++) {
      iterate();
    }
  }

  void iterateWithParameters(double w, double c1, double c2) {
    var gbest = findGBest();
    for (var i = 0; i < _population.length; i++) {
      _population[i].update(w, c1, c2, gbest);
    }
  }

  void iterateNWithParameters(int n, double w, double c1, double c2) {
    for (var i = 0; i < n; i++) {
      iterateWithParameters(w, c1, c2);
    }
  }
}
