import '../../domain/entity/app_entity.dart';

abstract class AppDto<T extends AppEntity> {
  T toEntity();
}
