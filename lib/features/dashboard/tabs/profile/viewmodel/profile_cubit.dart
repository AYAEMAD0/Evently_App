import 'package:evently_app/domain/usecases/logout_usecase.dart';

import '../../../../../domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../domain/usecases/get_user_profile_usecase.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileCubit(this.getUserProfileUseCase,this.logoutUseCase) : super(ProfileInitial());

  void loadProfile() async {
    emit(ProfileLoading());
    try {
      final user = await getUserProfileUseCase();
      emit(ProfileSuccess(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
  Future<void> logout() async {
    await logoutUseCase();
  }
}
