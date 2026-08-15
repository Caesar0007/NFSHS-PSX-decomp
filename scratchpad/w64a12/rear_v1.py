import json, os
CR = "\r\n"
s1_old = ('    if (latDistance < 0) {' + CR + CR
          + '      latDistance = -latDistance;' + CR + CR
          + '    }' + CR)
s1_new = '    latDistance = __builtin_abs(latDistance);' + CR

s2_old = ('          if (latDistance < 0) {' + CR + CR
          + '            latDistance = -latDistance;' + CR + CR
          + '          }' + CR)
s2_new = '          latDistance = __builtin_abs(latDistance);' + CR

V = [
    {"name": "b1_site1_builtin_abs", "subs": [[s1_old, s1_new]]},
    {"name": "b2_site2_builtin_abs", "subs": [[s2_old, s2_new]]},
    {"name": "b3_both_builtin_abs", "subs": [[s1_old, s1_new], [s2_old, s2_new]]},
]
p = os.path.join(os.path.dirname(__file__), "rear_v1.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
