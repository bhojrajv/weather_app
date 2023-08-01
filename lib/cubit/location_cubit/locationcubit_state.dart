part of 'locationcubit_cubit.dart';

@immutable
abstract class LocationcubitState extends Equatable {}

class LocationcubitInitial extends LocationcubitState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LocationLoaded extends LocationcubitState{
  final double? lat;
  final double? long;
  final List<Placemark>?address;
  LocationLoaded({this.long,this.lat,this.address});
  @override
  // TODO: implement props
  List<Object?> get props =>[lat,long,address];

}
