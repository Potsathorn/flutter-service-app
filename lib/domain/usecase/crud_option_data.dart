import 'package:service_app/domain/entities/option_data.dart';
import 'package:service_app/domain/repositories/option_data_repository.dart';

class CrudOptionData {
  final OptionDataRepository optionDataRepository;

  CrudOptionData(this.optionDataRepository);

  //create
  Future<OptionData> insert() => optionDataRepository.insertOptionData();

  //read
  Future<OptionData> get() => optionDataRepository.getOptionData();

  //update
  Future<OptionData> update() => optionDataRepository.updateOptionData();

  //delete
  Future<OptionData> delete() => optionDataRepository.deleteOptionData();
}
