import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  void checkPermission() async {
    PermissionStatus permissionStorage = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    List<PermissionGroup> askPermissionList = List<PermissionGroup>.empty();

    if (permissionStorage != PermissionStatus.granted) {
      askPermissionList.add(PermissionGroup.storage);
    }
  }
}
