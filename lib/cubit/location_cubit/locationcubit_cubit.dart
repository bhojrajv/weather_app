import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather/view_model/getcurrentlocation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meta/meta.dart';

part 'locationcubit_state.dart';

class LocationcubitCubit extends Cubit<LocationcubitState> {
  LocationcubitCubit() : super(LocationcubitInitial());

  void getAddress()async{
    final position=await LocationSingleton.determinePosition();
    emit(LocationLoaded(address: await LocationSingleton.
    getCurrentplace(lat: position.latitude,long: position.longitude),long: position.longitude,lat: position.latitude));
  }
}
