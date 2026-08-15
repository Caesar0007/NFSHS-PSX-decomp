import json, os
CR = "\r\n"
CALL = ('        Newton_SetInitialSlicePositionOrientationEtc(' + CR
        + '            &newState->carObj_->N,0,offset,1);' + CR)
CALL_T = ('        Newton_SetInitialSlicePositionOrientationEtc(' + CR
          + '            &newState->carObj_->N,0,&trafficOffset,1);' + CR)
MS = '        offset = (coorddef *)memset((u_char *)&trafficOffset,0,12);' + CR
MS_V = '        offset = (coorddef *)memset((u_char *)&trafficOffset,0,12);' + CR
BOTH_OLD = CALL  # appears twice -- probe helper handles count==1 only, so use a
# 2-step trick: replace the FIRST by a marker then the second.

V = [
    {"name": "r1_both_&trafficOffset",
     "subs": [[CALL + '        newState->carObj_->N.active = 0;' + CR,
               CALL_T + '        newState->carObj_->N.active = 0;' + CR]]},
]
p = os.path.join(os.path.dirname(__file__), "wing_v1.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
