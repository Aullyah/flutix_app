part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);
  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheater = [
  Theater("CGV Grand Pramuka Square"),
  Theater("CGV Transmart"),
];
