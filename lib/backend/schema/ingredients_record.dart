import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'ingredients_record.g.dart';

abstract class IngredientsRecord
    implements Built<IngredientsRecord, IngredientsRecordBuilder> {
  static Serializer<IngredientsRecord> get serializer =>
      _$ingredientsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get supplier;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  int get price;

  @nullable
  String get units;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(IngredientsRecordBuilder builder) => builder
    ..displayName = ''
    ..supplier = ''
    ..photoUrl = ''
    ..price = 0
    ..units = ''
    ..uid = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ingredients');

  static Stream<IngredientsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  IngredientsRecord._();
  factory IngredientsRecord([void Function(IngredientsRecordBuilder) updates]) =
      _$IngredientsRecord;

  static IngredientsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createIngredientsRecordData({
  String displayName,
  String supplier,
  String photoUrl,
  int price,
  String units,
  String uid,
  DateTime createdTime,
}) =>
    serializers.toFirestore(
        IngredientsRecord.serializer,
        IngredientsRecord((i) => i
          ..displayName = displayName
          ..supplier = supplier
          ..photoUrl = photoUrl
          ..price = price
          ..units = units
          ..uid = uid
          ..createdTime = createdTime));
