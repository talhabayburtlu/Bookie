final List<City> cities = [
  City(1, "ADANA"),
  City(2, "ADIYAMAN"),
  City(3, "AFYONKARAHİSAR"),
  City(4, "AĞRI"),
  City(5, "AMASYA"),
  City(6, "ANKARA"),
  City(7, "ANTALYA"),
  City(8, "ARTVİN"),
  City(9, "AYDIN"),
  City(10, "BALIKESİR"),
  City(11, "BİLECİKK"),
  City(12, "BİNGÖL"),
  City(13, "BİTLİS"),
  City(14, "BOLU"),
  City(15, "BURDUR"),
  City(16, "BURSA"),
  City(17, "ÇANAKKALE"),
  City(18, "ÇANKIRI"),
  City(19, "ÇORUM"),
  City(20, "DENİZLİ"),
  City(21, "DİYARBAKIR"),
  City(22, "EDİRNE"),
  City(23, "ELAZIĞ"),
  City(24, "ERZİNCAN"),
  City(25, "ERZURUM"),
  City(26, "ESKİŞEHİR"),
  City(27, "GAZİANTEP"),
  City(28, "GİRESUN"),
  City(29, "GÜMÜŞHANE"),
  City(30, "HAKKARİ"),
  City(31, "HATAY"),
  City(32, "ISPARTA"),
  City(33, "MERSİN"),
  City(34, "İSTANBUL"),
  City(35, "İZMİR"),
  City(36, "KARS"),
  City(37, "KASTAMONU"),
  City(38, "KAYSERİ"),
  City(39, "KIRKLARELİ"),
  City(40, "KIRŞEHİR"),
  City(41, "KOCAELİ"),
  City(42, "KONYA"),
  City(43, "KÜTAHYA"),
  City(44, "MALATYA"),
  City(45, "MANİSA"),
  City(46, "KAHRAMANMARAŞ"),
  City(47, "MARDİN"),
  City(48, "MUĞLA"),
  City(49, "MUŞ"),
  City(50, "NEVŞEHİR"),
  City(51, "NİĞDE"),
  City(52, "ORDU"),
  City(53, "RİZE"),
  City(54, "SAKARYA"),
  City(55, "SAMSUN"),
  City(56, "SİİRT"),
  City(57, "SİNOP"),
  City(58, "SİVAS"),
  City(59, "TEKİRDAĞ"),
  City(60, "TOKAT"),
  City(61, "TRABZON"),
  City(62, "TUNCELİ"),
  City(63, "ŞANLIURFA"),
  City(64, "UŞAK"),
  City(65, "VAN"),
  City(66, "YOZGAT"),
  City(67, "ZONGULDAK"),
  City(68, "AKSARAY"),
  City(69, "BAYBURT"),
  City(70, "KARAMAN"),
  City(71, "KIRIKKALE"),
  City(72, "BATMAN"),
  City(73, "ŞIRNAK"),
  City(74, "BARTIN"),
  City(75, "ARDAHAN"),
  City(76, "IĞDIR"),
  City(77, "YALOVA"),
  City(78, "KARABüK"),
  City(79, "KİLİS"),
  City(80, "OSMANİYE"),
  City(81, "DÜZCE"),
];

class City {
  final int id; // Plaka kodu.
  final String name;

  City(this.id, this.name);

  @override
  bool operator ==(Object other) {
    return other is City && other.id == this.id;
  }

  @override
  int get hashCode => this.id;
}
