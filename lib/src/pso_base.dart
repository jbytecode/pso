import 'Particle.dart';

class PSO {
  List<Particle> _population;

  Particle findGBest() {
    double b = _population[0].getFitnessValue();
    Particle result = _population[0];
    for (int i = 1; i < _population.length; i++) {
      double f = _population[i].getFitnessValue();
      if (f > b) {
        b = f;
        result = _population[i];
      }
    }
    return result.deepCopy();
  }

  List<Particle> getPopulation(){
    return _population;
  }

  PSO(FitnessFunctionType fitnessFunction, int popsize, List<double> mins,
      List<double> maxs) {
    _population = List<Particle>(popsize);
    for (int i = 0; i < popsize; i++) {
      _population[i] = Particle(mins, maxs, fitnessFunction);
    }
  }

  void iterate() {
    iterateWithParameters(0.5, 1, 1);
  }

  void iterateN(int n) {
    for (int i = 0; i < n; i++) {
      iterate();
    }
  }

  void iterateWithParameters(double w, double c1, double c2) {
    Particle gbest = findGBest();
    for (int i = 0; i < _population.length; i++) {
      _population[i].update(w, c1, c2, gbest);
    }
  }

  void iterateNWithParameters(int n, double w, double c1, double c2) {
    for (int i = 0; i < n; i++) {
      iterateWithParameters(w, c1, c2);
    }
  }
}
