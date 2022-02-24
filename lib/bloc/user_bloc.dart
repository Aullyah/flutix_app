import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadUser) {
      Users user = await UserServices.getUser(event.id);
      yield UserLoaded(user);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateData) {
      Users updateUser = (state as UserLoaded)
          .user
          .copyWith(name: event.name, profilePicture: event.profileImage);

      await UserServices.updateUser(updateUser);
      yield UserLoaded(updateUser);
    } else if (event is TopUp) {
      if (state is UserLoaded) {
        try {
          Users updateUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance + event.amount);
          await UserServices.updateUser(updateUser);
          yield UserLoaded(updateUser);
        } catch (e) {
          print(e);
        }
      }
    } else if (event is Purchase) {
      if (state is UserLoaded) {
        try {
          Users updateUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance - event.amount);
          await UserServices.updateUser(updateUser);
          yield UserLoaded(updateUser);
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
