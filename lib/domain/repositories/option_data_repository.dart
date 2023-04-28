import 'package:service_app/domain/entities/option_data.dart';

abstract class OptionDataRepository {
  //create
  Future<OptionData> insertOptionData();

  //read
  Future<OptionData> getOptionData();

  //update
  Future<OptionData> updateOptionData();

  //delete
  Future<OptionData> deleteOptionData();
}
