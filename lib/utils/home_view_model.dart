import 'package:sirius_tracker_contratante/model/user.dart';

import 'base_view_model.dart';

class HomeViewModel extends BaseViewModel {

  User _userID;
  User get userID => _userID;

  @override
  void dispose() {
    super.dispose();
  }

  void setPerfilExpanded(bool perfilExpanded) {
    notifyListeners();
  }

  void setUser({User userID}) {
    _userID = userID;
    notifyListeners();
  }
}
