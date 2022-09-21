enum FileFormat { CODE_JPEG, CODE_MPEG }

class ImageInfoes {
  final FileFormat fileFormat;
  final num fileSize;
  final num imagePixWidth;
  final num imagePixHeight;
  final String fileName;
  final DateTime captureDate;
  final String fileId;

  ImageInfoes({
    required this.fileFormat,
    required this.fileSize,
    required this.imagePixWidth,
    required this.imagePixHeight,
    required this.fileName,
    required this.captureDate,
    required this.fileId,
  });

  factory ImageInfoes.fromMap(Map<String, dynamic> map) {
    return ImageInfoes(
      fileFormat: FileFormat.values.byName(map['fileFormat']),
      fileSize: map['fileSize'],
      imagePixWidth: map['imagePixWidth'],
      imagePixHeight: map['imagePixHeight'],
      fileName: map['fileName'],
      captureDate: DateTime.fromMillisecondsSinceEpoch(
          (map['captureDate'] as double).toInt()),
      fileId: map['fileId'],
    );
  }
}
