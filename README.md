![Dart CI](https://github.com/jbytecode/pso/workflows/Dart%20CI/badge.svg)

A Library for Particle Swarm Optimization

Created by Matletik - Mathematical Manipulatives and Interactive Learning Tools

http://www.matletik.com

## Usage

A simple usage example:

```dart
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
```

## Details
* The objective function is always in the form of

```dart
double f(List<double> x){
  
}
```

* The optimization is always a maximation. If the objective
function of the problem is a minimization, the returned value of the 
objective function can be multiplied by -1.0.

* The default parameters of the classical Particle Swarm Optimization 
are set to w = 0.5, c1 = 1.0, and c2 = 1.0. These optimization parameters can be customized 
in the 

```dart
void iterateWithParameters(double w, double c1, double c2) 
```

or

```dart
void iterateNWithParameters(int n, double w, double c1, double c2) 
```


in the class *PSO*.
