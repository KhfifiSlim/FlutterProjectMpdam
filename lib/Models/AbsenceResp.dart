class AbsenceResp {
  String message;
  List<Absence> absences;

  AbsenceResp({
    required this.message,
    required this.absences,
  });

  factory AbsenceResp.fromJson(Map<String, dynamic> json) {
    List<Absence> absences = [];
    for (var absenceJson in json['data']['absence']) {
      Absence absence = Absence.fromJson(absenceJson);
      absences.add(absence);
    }
    return AbsenceResp(
      message: json['message'],
      absences: absences,
    );
  }
}
class Absence {
  String idEtud;
  String idMat;
  String etud;
  String mat;
  int absence;
  String id;

  Absence({
    required this.idEtud,
    required this.idMat,
    required this.etud,
    required this.mat,
    required this.absence,
    required this.id,
  });

  factory Absence.fromJson(Map<String, dynamic> json) {
    return Absence(
      idEtud: json['id_etud'],
      idMat: json['id_mat'],
      etud: json['etud'],
      mat: json['mat'],
      absence: json['absence'],
      id: json['id'],
    );
  }
}
