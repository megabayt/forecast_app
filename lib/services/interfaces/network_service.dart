import 'package:forecast_app/interfaces/common_info.dart';

abstract class NetworkService {
  Future<CommonInfo> getCommonInfo({required int height});
}
