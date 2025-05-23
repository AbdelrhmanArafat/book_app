class Formats {
  String? textHtml;
  String? applicationEpubZip;
  String? applicationXMobipocketEbook;
  String? applicationRdfXml;
  String? imageJpeg;
  String? textPlainCharsetUsAscii;
  String? applicationOctetStream;

  Formats({
    this.textHtml,
    this.applicationEpubZip,
    this.applicationXMobipocketEbook,
    this.applicationRdfXml,
    this.imageJpeg,
    this.textPlainCharsetUsAscii,
    this.applicationOctetStream,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
    textHtml: json['text/html'] as String?,
    applicationEpubZip: json['application/epub+zip'] as String?,
    applicationXMobipocketEbook:
        json['application/x-mobipocket-ebook'] as String?,
    applicationRdfXml: json['application/rdf+xml'] as String?,
    imageJpeg: json['image/jpeg'] as String?,
    textPlainCharsetUsAscii: json['text/plain; charset=us-ascii'] as String?,
    applicationOctetStream: json['application/octet-stream'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'text/html': textHtml,
    'application/epub+zip': applicationEpubZip,
    'application/x-mobipocket-ebook': applicationXMobipocketEbook,
    'application/rdf+xml': applicationRdfXml,
    'image/jpeg': imageJpeg,
    'text/plain; charset=us-ascii': textPlainCharsetUsAscii,
    'application/octet-stream': applicationOctetStream,
  };
}
