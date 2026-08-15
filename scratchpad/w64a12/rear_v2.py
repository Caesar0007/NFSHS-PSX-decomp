import json, os
CR = "\r\n"
HEAD = ('    {' + CR + '    int lo1;' + CR + '    int hi1;' + CR
        + '    lo1 = -0x10001;' + CR + '    hi1 = 0x26fffe;' + CR
        + '    __asm__("" : "=r"(lo1) : "0"(lo1));' + CR
        + '    __asm__("" : "=r"(hi1) : "0"(hi1));' + CR + CR
        + '    if (latDistance < 0) {' + CR + CR
        + '      latDistance = -latDistance;' + CR + CR
        + '    }' + CR + CR
        + '    if (((u_int)(longDistance + lo1) <= (u_int)hi1) && (latDistance < longDistance * 2)) {' + CR)

ABS_B = '    latDistance = __builtin_abs(latDistance);' + CR
ABS_IF = ('    if (latDistance < 0) {' + CR + CR + '      latDistance = -latDistance;'
          + CR + CR + '    }' + CR)
TEST_N = '    if (((u_int)(longDistance + lo1) <= (u_int)hi1) && (latDistance < longDistance * 2)) {' + CR
TEST_L = '    if (((u_int)(longDistance - 0x10001) <= 0x26fffeU) && (latDistance < longDistance * 2)) {' + CR
DECL = '    {' + CR + '    int lo1;' + CR + '    int hi1;' + CR
ASSIGN = '    lo1 = -0x10001;' + CR + '    hi1 = 0x26fffe;' + CR
ASSIGN_R = '    hi1 = 0x26fffe;' + CR + '    lo1 = -0x10001;' + CR
FENCE = ('    __asm__("" : "=r"(lo1) : "0"(lo1));' + CR
         + '    __asm__("" : "=r"(hi1) : "0"(hi1));' + CR)
FENCE_R = ('    __asm__("" : "=r"(hi1) : "0"(hi1));' + CR
           + '    __asm__("" : "=r"(lo1) : "0"(lo1));' + CR)

V = [
    {"name": "d1_abs_keepfence", "subs": [[HEAD, DECL + ASSIGN + FENCE + CR + ABS_B + CR + TEST_N]]},
    {"name": "d2_abs_nofence", "subs": [[HEAD, DECL + ASSIGN + CR + ABS_B + CR + TEST_N]]},
    {"name": "d3_abs_literals", "subs": [[HEAD, '    {' + CR + CR + ABS_B + CR + TEST_L]]},
    {"name": "d4_if_literals", "subs": [[HEAD, '    {' + CR + CR + ABS_IF + CR + TEST_L]]},
    {"name": "d5_abs_fence_revorder", "subs": [[HEAD, DECL + ASSIGN_R + FENCE_R + CR + ABS_B + CR + TEST_N]]},
    {"name": "d6_abs_fence_before_abs_only_lo", "subs": [[HEAD, DECL + ASSIGN
              + '    __asm__("" : "=r"(lo1) : "0"(lo1));' + CR + CR + ABS_B + CR + TEST_N]]},
    {"name": "d7_abs_after_fence_swapassign", "subs": [[HEAD, DECL + ASSIGN_R + FENCE + CR + ABS_B + CR + TEST_N]]},
]
p = os.path.join(os.path.dirname(__file__), "rear_v2.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
