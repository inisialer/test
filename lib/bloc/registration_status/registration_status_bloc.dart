import 'package:alhikmah_app/bloc/registration_status/_bloc.dart';
import 'package:alhikmah_app/model/memberregistration/registration_status_model.dart';
import 'package:bloc/bloc.dart';

import '../../service/registration_status_service.dart';

class RegistrationStatusBloc
    extends Bloc<RegistrationStatusEvent, RegistrationStatusState> {
  @override
  RegistrationStatusState get initialState => RegistrationStatusInitial();

  RegistrationStatusModel registrationStatusModel;

  @override
  Stream<RegistrationStatusState> mapEventToState(
    RegistrationStatusEvent event,
  ) async* {
    if (event is GetRegistrationStatus) {
      registrationStatusModel =
          await RegistrationStatusService().getRegistrationStatus();
      if (registrationStatusModel != null) {
        yield RegistrationStatusLoaded(
            registrationStatusModel: registrationStatusModel);
      } else {
        yield RegistrationStatusError(error: "Error");
      }
    }
  }
}
