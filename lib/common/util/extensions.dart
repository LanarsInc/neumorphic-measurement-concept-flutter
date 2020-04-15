List<T> mapIndexed<T>(List list, {Function builder, T separator}) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(builder(i, list[i]));

    if (separator != null && i < list.length - 1) {
      result.add(separator);
    }
  }

  return result;
}
