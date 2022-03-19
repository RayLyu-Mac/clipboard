get_most_freq(List<String> inp) {
  Map<String, int> res = {};

  inp.forEach((element) {
    if (!res.containsKey(element)) {
      res[element] = 1;
    } else {
      res[element] = res[element]! + 1;
    }
  });
  List<List> f = [];
  for (var ss = 0; ss < res.length; ss++) {
    f.add([res.keys.toList()[ss], res.values.toList()[ss]]);
  }

  for (var s1 = 0; s1 < res.length; s1++) {
    for (var s2 = 0; s2 < res.length - s1 - 1; s2++) {
      if (f[s2][1] < f[s2 + 1][1]) {
        List stored = f[s2];
        f[s2] = f[s2 + 1];
        f[s2 + 1] = stored;
      }
    }
  }
  return f;
}
