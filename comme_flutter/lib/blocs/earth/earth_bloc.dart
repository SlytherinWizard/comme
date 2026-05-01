import 'package:comme_flutter/repositories/earth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'earth_event.dart';
part 'earth_state.dart';

class EarthBloc extends Bloc<EarthEvent, EarthState> {
  final EarthRepository _earthRepository;
  EarthBloc({required EarthRepository earthRepository})
    : _earthRepository = earthRepository,
      super(EarthState()) {
    on<EarthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
