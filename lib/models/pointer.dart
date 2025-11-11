import 'package:espitaliaa_doctors/models/general_model.dart';

class Pointer {
  //   1 => clinic   ||   2 => lab   ||   3 => center   ||   4 => hospital
  static int placeType;
}

final List<GeneralData> orgListEn = [
  GeneralData(name: 'doctor', id: '0'),
  GeneralData(name: 'Hospital', id: '2'),
  GeneralData(name: 'center', id: '5'),
  GeneralData(name: 'lab', id: '1'),
];

final List<GeneralData> orgListAr = [
  GeneralData(name: 'طبيب', id: '0'),
  GeneralData(name: 'مستشفي', id: '2'),
  GeneralData(name: 'مركز', id: '5'),
  GeneralData(name: 'معمل', id: '1'),
];
