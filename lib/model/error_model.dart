

class ErrorModel{
  String? namaUser;
  String? idUser;
  String? pesan;
  String? lokasi;
  String? appVersi;
  String? device;
  String? waktu;

  ErrorModel({
    this.namaUser = "",
    this.idUser = "",
    this.pesan = "",
    this.lokasi = "",
    this.appVersi = "",
    this.device = "",
    this.waktu = "",
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    namaUser = json['namaUser'];
    idUser = json['idUser'];
    pesan = json['pesan'];
    lokasi = json['lokasi'];
    appVersi = json['appVersi'];
    device = json['device'];
    waktu = json['waktu'];
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'namaUser': namaUser,
        'idUser': idUser,
        'pesan': pesan,
        'lokasi': lokasi,
        'appVersi': appVersi,
        'device': device,
        'waktu': waktu,
      };
}