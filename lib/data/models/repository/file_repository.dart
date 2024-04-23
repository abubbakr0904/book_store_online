import '../../../utils/images/app_images.dart';
import '../file_model/file_model.dart';

class FileRepository {
  List<FileDataModel> files = [

    FileDataModel(
      iconPath: "https://kitoblardunyosi.uz/image/cache/catalog/bolalar/sariq-devni-minib-500x750.jpg",
      fileName: "Sariq devni minib",
      fileUrl: "http://ferlibrary.uz/f/sariq_devni_minib_roman.pdf",
    ),
    FileDataModel(
      iconPath: "https://tovar.uz/images/company/444/tovar/65500/o_616e619ab6d8d.jpg",
      fileName: "Shum bola",
      fileUrl: "http://ferlibrary.uz/f/6_shum_bola.pdf",
    ),
    FileDataModel(
      iconPath: "https://assets.asaxiy.uz/product/items/desktop/5e15bc6f4bd96.jpg.webp",
      fileName: "Oq kema",
      fileUrl: "https://n.ziyouz.com/books/jahon_nasri/Chingiz%20Aytmatov.%20Oqkema%20(qissa).pdf",
    ),
  ];
}