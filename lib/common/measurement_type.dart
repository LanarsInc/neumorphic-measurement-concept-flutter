enum MeasurementType {
  temperature,
  pressure,
  co2,
  humidity,
}

extension MeasurementExtension on MeasurementType {
  static const units = {
    MeasurementType.temperature: '\u2103',
    MeasurementType.pressure: 'kPs',
    MeasurementType.co2: 'ppm',
    MeasurementType.humidity: '%',
  };

  String get unit => units[this];
}
