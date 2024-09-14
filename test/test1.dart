Map<String, dynamic>? castMap(Map? map) {
  if (map == null) return null;
  return map.cast<String, dynamic>();
}

void main() {
  Map rawMap = {'key': 'value', 'age': null}; // 任意类型的 Map
  Map<String, dynamic>? result = castMap(rawMap); // 转换为 Map<String, dynamic>

  print(result); // 输出: {key: value, age: 25}

  Map? nullMap;
  Map<String, dynamic>? resultNull = castMap(nullMap);

  print(resultNull); // 输出: null
}