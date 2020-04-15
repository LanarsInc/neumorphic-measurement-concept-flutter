enum ChartDataType {
  hour,
  day,
  month,
}

extension ChartDataExtension on ChartDataType {
  static const dataTypes = {
    0: ChartDataType.hour,
    1: ChartDataType.day,
    2: ChartDataType.month,
  };

  ChartDataType getDataType(int index) => dataTypes[index];
}
