// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptoDetailsAdapter extends TypeAdapter<CryptoDetails> {
  @override
  final int typeId = 1;

  @override
  CryptoDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoDetails(
      symbol: fields[0] as String,
      cryptoFullName: fields[2] as String?,
      cryptoIcon: fields[3] as String?,
      priceInUSD: fields[4] as double,
      marketCap: fields[5] as double,
      volume24h: fields[6] as double,
      change24h: fields[7] as double,
      lastUpdate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CryptoDetails obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.lastUpdate)
      ..writeByte(2)
      ..write(obj.cryptoFullName)
      ..writeByte(3)
      ..write(obj.cryptoIcon)
      ..writeByte(4)
      ..write(obj.priceInUSD)
      ..writeByte(5)
      ..write(obj.marketCap)
      ..writeByte(6)
      ..write(obj.volume24h)
      ..writeByte(7)
      ..write(obj.change24h);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoDetails _$CryptoDetailsFromJson(Map<String, dynamic> json) =>
    CryptoDetails(
      symbol: json['FROMSYMBOL'] as String,
      cryptoFullName: json['FULLNAME'] as String?,
      cryptoIcon: json['IMAGEURL'] as String?,
      priceInUSD: (json['PRICE'] as num).toDouble(),
      marketCap: (json['MKTCAP'] as num).toDouble(),
      volume24h: (json['VOLUME24HOUR'] as num).toDouble(),
      change24h: (json['CHANGEPCT24HOUR'] as num).toDouble(),
      lastUpdate:
          CryptoDetails._dateTimeFromJson((json['LASTUPDATE'] as num).toInt()),
    );

Map<String, dynamic> _$CryptoDetailsToJson(CryptoDetails instance) =>
    <String, dynamic>{
      'FROMSYMBOL': instance.symbol,
      'LASTUPDATE': CryptoDetails._dateTimeToJson(instance.lastUpdate),
      'FULLNAME': instance.cryptoFullName,
      'IMAGEURL': instance.cryptoIcon,
      'PRICE': instance.priceInUSD,
      'MKTCAP': instance.marketCap,
      'VOLUME24HOUR': instance.volume24h,
      'CHANGEPCT24HOUR': instance.change24h,
    };
