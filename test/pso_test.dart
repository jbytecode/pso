import 'package:pso/pso.dart';
import 'package:test/test.dart';
import 'dart:math' as _math;

void main() {
  group('A group of tests', () {
    setUp(() {});

    test('Vector sum', () {
      var v1 = <double>[1, 2, 3, 4, 5];
      var v2 = <double>[5, 6, 7, 8, 9];
      var sm = Vector.Sum(v1, v2);
      assert(sm[0] == 6);
      assert(sm[1] == 8);
      assert(sm[2] == 10);
      assert(sm[3] == 12);
      assert(sm[4] == 14);
      assert(sm.length == 5);
    });

    test('Vector sub', () {
      var v1 = <double>[1, 2, 3, 4, 5];
      var v2 = <double>[5, 6, 7, 8, 9];
      var sm = Vector.Sub(v1, v2);
      assert(sm[0] == -4);
      assert(sm[1] == -4);
      assert(sm[2] == -4);
      assert(sm[3] == -4);
      assert(sm[4] == -4);
      assert(sm.length == 5);
    });

    test('Vector scaler product', () {
      var v1 = <double>[1, 2, 3, 4, 5];
      var sm = Vector.ProdWithScaler(v1, 10.0);
      assert(sm[0] == 10);
      assert(sm[1] == 20);
      assert(sm[2] == 30);
      assert(sm[3] == 40);
      assert(sm[4] == 50);
      assert(sm.length == 5);
    });

    test('Test for Min f(x, y) = (x - pi)^2 + (y - e)^2', () {
      double f(List<double> x) {
        var s = 0.0;
        s = _math.pow(x[0] - 3.14159265, 2.0) + _math.pow(x[1] - 2.71828, 2.0)
            as double;
        return -s;
      }

      var mins = <double>[-10, -10];
      var maxs = <double>[10, 10];

      var pso = PSO(f, 100, mins, maxs);
      pso.iterateN(500);

      var result = pso.findGBest();
      var strResult1 = result.getValues()[0].toString();
      var strResult2 = result.getValues()[1].toString();
      assert(strResult1.startsWith('3.1415'));
      assert(strResult2.startsWith('2.718'));
    });

    test('Test for finding median of [1,2,3,4,5,6,7,8,9,100] as 5.5', () {
      double f(List<double> x) {
        var s = 0.0;
        var nums = <double>[1, 2, 3, 4, 5, 6, 7, 8, 9, 100];
        for (var i = 0; i < nums.length; i++) {
          s += (nums[i] - x[0]).abs();
        }
        return -s;
      }

      var mins = <double>[-1000];
      var maxs = <double>[1000];

      var pso = PSO(f, 100, mins, maxs);
      pso.iterateNWithParameters(500, 0.5, 1, 1);

      var result = pso.findGBest();
      assert(result.getValues()[0].floor() == 5);
    });
  });
}
