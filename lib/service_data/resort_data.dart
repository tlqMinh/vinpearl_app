import 'package:cloud_firestore/cloud_firestore.dart';
class ResortService {
  List<dynamic> anh;
  String diaChi, gia, maDV, moTa, sdt, tenDV, xepLoai;

  ResortService({
    required this.anh,
    required this.diaChi,
    required this.gia,
    required this.maDV,
    required this.moTa,
    required this.sdt,
    required this.tenDV,
    required this.xepLoai,
  });

  Map<String, dynamic> toJson() {
    return {
      'anh': anh,
      'diaChi': diaChi,
      'gia': gia,
      'maDV': maDV,
      'moTa': moTa,
      'sdt': sdt,
      'tenDV': tenDV,
      'xepLoai': xepLoai,
    };
  }

  factory ResortService.fromJson(Map<String, dynamic> map) {
    return ResortService(
      anh: map['anh'] as List<dynamic>,
      diaChi: map['diaChi'] as String,
      gia: map['gia'] as String,
      maDV: map['maDV'] as String,
      moTa: map['moTa'] as String,
      sdt: map['sdt'] as String,
      tenDV: map['tenDV'] as String,
      xepLoai: map['xepLoai'] as String,
    );
  }

}

class ResortServiceSnapshot {
  ResortService resortService;
  DocumentReference documentReference;

  ResortServiceSnapshot({
    required this.resortService,
    required this.documentReference,
  });
  // hàm get để lấy thông tin cho trang cart
  String getTenDV() {
    return resortService.tenDV;
  }
  String getAnh() {
    return resortService.anh[0];
  }
  void updatePrice() {
    resortService.gia = (double.parse(resortService.gia) * quantity).toString();
  }


  factory ResortServiceSnapshot.fromSnapshot(DocumentSnapshot docSnapGolfService) {
    return ResortServiceSnapshot(
      resortService: ResortService.fromJson(docSnapGolfService.data() as Map<String, dynamic>),
      documentReference: docSnapGolfService.reference,
    );
  }

  static Stream<List<ResortServiceSnapshot>> listResortService()
  {
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("ResortService")
        .snapshots();
    Stream<List<DocumentSnapshot>> streamListDocSnap = streamQS.map(
            (queryInfo) => queryInfo.docs);
    return streamListDocSnap.map((listDS) => listDS.map((ds) => ResortServiceSnapshot.fromSnapshot(ds)).toList()
    );
  }

  int quantity = 1;

  // Method to get quantity
  int getQuantity() {
    return quantity;
  }

  // Method to increase quantity
  void increaseQuantity() {
    quantity++;
  }

  // Method to decrease quantity
  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
