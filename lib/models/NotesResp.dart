class NotesResp {
  String? message;
  Data? data;
  NotesResp({this.message, this.data});
  NotesResp.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Note>? note;

  Data({this.note});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['note'] != null) {
      note = List<Note>.from(json['note'].map((noteJson) => Note.fromJson(noteJson)));
    }
  }
}

class Note {
  String? idEtud;
  String? idMat;
  String? mat;
  String? etud;
  int? noteNp;
  int? noteDc;
  int? noteTp;
  String? id;

  Note({
    this.idEtud,
    this.idMat,
    this.mat,
    this.etud,
    this.noteNp,
    this.noteDc,
    this.noteTp,
    this.id,
  });

  Note.fromJson(Map<String, dynamic> json) {
    idEtud = json['id_etud'];
    idMat = json['id_mat'];
    mat = json['mat'];
    etud = json['etud'];
    noteNp = json['note_np'];
    noteDc = json['note_dc'];
    noteTp = json['note_tp'];
    id = json['id'];
  }
}