| object | SYM obj | **-G** | G>= | G< | own small | own big | #gp-rel | #hi/lo mem | #hi/lo own-small | #addr-of | adj(la) | pre-split | min pre-split sz | witness G>= | witness G< | basis |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `aidatarecord` | `aidatarecord` | **4..16** | 4 | 96 | 4 | 1 | 4 | 17 | 0 | 13 | 16 | 15 | 36 | AIDataRecord_BestLine, AIDataRecord_RecordMethod, AIDataRecord_TrackCurve | recordCollection | placement+gp-rel+<placement |
| `aiinit` | `aiinit` | **4..16** | 4 | 108 | 3 | 1 | 3 | 16 | 0 | 7 | 25 | 11 | 16 | AIInit_forceHumanHandBrake, AIInit_useSpreadForce, AITraffic_rawTriggers | trafcfg | placement+gp-rel+<placement |
| `aiperson` | `aiperson` | **0..8** | 0 | 16 | 0 | 20 | 0 | 34 | 0 | 28 | 35 | 15 | 16 |  | AIPerson_attackActivationHits, AIPerson_attackTimes, AIPerson_bestLineAbilities | <placement |
| `aiphysic` | `aiphysic` | **4..16** | 4 | 108 | 3 | 1 | 2 | 19 | 0 | 8 | 58 | 15 | 12 | AIPhysic_elapsedTime, AIPhysic_iTime, AIPhysic_time | AIPhysicConfig | placement+gp-rel+<placement |
| `aiscript` | `aiscript` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `aitune` | `aitune` | **4..8** | 4 | 12 | 3 | 7 | 3 | 3 | 0 | 1 | 4 | 3 | 144 | AITune_driveSide, AITune_gRoughLapTime, AITune_oneWay | AITune_BTCPerpAccMults | placement+gp-rel+<placement |
| `eaclib/psx/eacpsxz/addtimer` | `eaclib/psx/eacpsxz/addtimer` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 3 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/asinfunc` | `eaclib/psx/eacpsxz/asinfunc` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 3 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/atanfunc` | `eaclib/psx/eacpsxz/atanfunc` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/blkfill` | `eaclib/psx/eacpsxz/blkfill` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/blkmov` | `eaclib/psx/eacpsxz/blkmov` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/callback` | `eaclib/psx/eacpsxz/callback` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 2 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/cdfs` | `eaclib/psx/eacpsxz/cdfs` | **UNDET** | 0 | None | 0 | 0 | 0 | 6 | 0 | 1 | 24 | 23 | 20 |  |  | gapsize |
| `eaclib/psx/eacpsxz/cluttype` | `eaclib/psx/eacpsxz/cluttype` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/crc` | `eaclib/psx/eacpsxz/crc` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/crossprd` | `eaclib/psx/eacpsxz/crossprd` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/devsys` | `eaclib/psx/eacpsxz/devsys` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/exit` | `eaclib/psx/eacpsxz/exit` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 2 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/fastmovf` | `eaclib/psx/eacpsxz/fastmovf` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 0 | 6 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/fileroot` | `eaclib/psx/eacpsxz/fileroot` | **CONFLICT** | 4 | 4 | 0 | 0 | 2 | 6 | 2 | 2 | 21 | 2 | 4 | D_8013DD34, D_8013DD40 | availablefilesystems, currentfilesystem | gp-rel+<hi/lo-own+excl-own+gapsize |
| `eaclib/psx/eacpsxz/fixdatan` | `eaclib/psx/eacpsxz/fixdatan` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 2 | 2 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/fixddiv` | `eaclib/psx/eacpsxz/fixddiv` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/fixdinv` | `eaclib/psx/eacpsxz/fixdinv` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/fixdmult` | `eaclib/psx/eacpsxz/fixdmult` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/fixdsin` | `eaclib/psx/eacpsxz/fixdsin` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/fixdsqrt` | `eaclib/psx/eacpsxz/fixdsqrt` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/fsincos` | `eaclib/psx/eacpsxz/fsincos` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/getm` | `eaclib/psx/eacpsxz/getm` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/inittmr` | `eaclib/psx/eacpsxz/inittmr` | **>=4** | 4 | None | 0 | 0 | 3 | 6 | 0 | 2 | 10 | 5 | 4 | reentryflag, timerevent, timerflag |  | gp-rel |
| `eaclib/psx/eacpsxz/isincos` | `eaclib/psx/eacpsxz/isincos` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 2 | 2 | None |  |  | - |
| `eaclib/psx/eacpsxz/isqrt` | `eaclib/psx/eacpsxz/isqrt` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 4 | 1 | None |  |  | - |
| `eaclib/psx/eacpsxz/isqrttbl` | `eaclib/psx/eacpsxz/isqrttbl` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/joystkn` | `eaclib/psx/eacpsxz/joystkn` | **CONFLICT** | 4 | 4 | 0 | 0 | 1 | 1 | 1 | 0 | 1 | 0 | None | joy_inited | numjoy | gp-rel+<hi/lo-own+excl-own |
| `eaclib/psx/eacpsxz/loadshp` | `eaclib/psx/eacpsxz/loadshp` | **>=8** | 8 | None | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | None | shapeext |  | gp-rel |
| `eaclib/psx/eacpsxz/locatbig` | `eaclib/psx/eacpsxz/locatbig` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/locatshp` | `eaclib/psx/eacpsxz/locatshp` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/math64a` | `eaclib/psx/eacpsxz/math64a` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/matrix` | `eaclib/psx/eacpsxz/matrix` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 2 | 5 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/meminit` | `eaclib/psx/eacpsxz/meminit` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/memstd` | `eaclib/psx/eacpsxz/memstd` | **0..2** | 0 | 4 | 0 | 0 | 0 | 3 | 1 | 2 | 9 | 0 | None |  | mb_default | <hi/lo-own+excl-own |
| `eaclib/psx/eacpsxz/movf` | `eaclib/psx/eacpsxz/movf` | **UNDET** | 0 | None | 0 | 0 | 0 | 3 | 0 | 0 | 8 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/nasync` | `eaclib/psx/eacpsxz/nasync` | **>=8** | 8 | None | 0 | 0 | 11 | 5 | 0 | 5 | 17 | 8 | None | D_8013DE98 |  | gp-rel |
| `eaclib/psx/eacpsxz/nfile` | `eaclib/psx/eacpsxz/nfile` | **>=4** | 4 | None | 0 | 0 | 1 | 11 | 0 | 5 | 25 | 20 | 8 | D_8013DC50 |  | gp-rel+gapsize |
| `eaclib/psx/eacpsxz/nloadpk` | `eaclib/psx/eacpsxz/nloadpk` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/nsync` | `eaclib/psx/eacpsxz/nsync` | **0..2** | 0 | 4 | 0 | 0 | 0 | 2 | 2 | 0 | 11 | 0 | None |  | abortflag, loadfilecallback | <hi/lo-own+excl-own |
| `eaclib/psx/eacpsxz/nullfunc` | `eaclib/psx/eacpsxz/nullfunc` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/primate` | `eaclib/psx/eacpsxz/primate` | **>=4** | 4 | None | 0 | 0 | 15 | 1 | 0 | 1 | 1 | 0 | None | D_8013DE74, D_8013DE88, drawpending |  | gp-rel |
| `eaclib/psx/eacpsxz/random` | `eaclib/psx/eacpsxz/random` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 2 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/resize` | `eaclib/psx/eacpsxz/resize` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/savegp` | `eaclib/psx/eacpsxz/savegp` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/setfont` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 2 | 4 | None |  |  | - |
| `eaclib/psx/eacpsxz/shpclut` | `eaclib/psx/eacpsxz/shpclut` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/shpdepth` | `eaclib/psx/eacpsxz/shpdepth` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/shpsubs` | `eaclib/psx/eacpsxz/shpsubs` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/shptype` | `eaclib/psx/eacpsxz/shptype` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/sinfunc` | `eaclib/psx/eacpsxz/sinfunc` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/stream` | `eaclib/psx/eacpsxz/stream` | **>=4** | 4 | None | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 4 | None | D_8013DEDC |  | gp-rel |
| `eaclib/psx/eacpsxz/stricmp` | `eaclib/psx/eacpsxz/stricmp` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/syncfile` | `eaclib/psx/eacpsxz/syncfile` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 3 | None |  |  | - |
| `eaclib/psx/eacpsxz/systask` | `eaclib/psx/eacpsxz/systask` | **>=4** | 4 | None | 0 | 0 | 2 | 1 | 0 | 0 | 8 | 2 | None | D_8013DC38, D_8013DC3C |  | gp-rel |
| `eaclib/psx/eacpsxz/textcode` | `eaclib/psx/eacpsxz/textcode` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/textcrnt` | `eaclib/psx/eacpsxz/textcrnt` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/textfor` | `eaclib/psx/eacpsxz/textfor` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 1 | 136 |  |  | - |
| `eaclib/psx/eacpsxz/threads` | `eaclib/psx/eacpsxz/threads` | **>=4** | 4 | None | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | None | g_currentthread |  | gp-rel |
| `eaclib/psx/eacpsxz/timer` | `eaclib/psx/eacpsxz/timer` | **>=4** | 4 | None | 0 | 0 | 2 | 1 | 0 | 0 | 3 | 0 | None | tickset, tickval |  | gp-rel |
| `eaclib/psx/eacpsxz/trnsfrm` | `eaclib/psx/eacpsxz/trnsfrm` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/trnsmult` | `eaclib/psx/eacpsxz/trnsmult` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/trnspos` | `eaclib/psx/eacpsxz/trnspos` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/unbtree` | `eaclib/psx/eacpsxz/unbtree` | **>=4** | 4 | None | 0 | 0 | 5 | 0 | 0 | 0 | 0 | 0 | None | D_8013DEC8, D_8013DECC, D_8013DED0 |  | gp-rel |
| `eaclib/psx/eacpsxz/unhuff` | `eaclib/psx/eacpsxz/unhuff` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/unref` | `eaclib/psx/eacpsxz/unref` | **>=4** | 4 | None | 0 | 0 | 4 | 0 | 0 | 0 | 0 | 0 | None | D_8013DEC8, D_8013DECC, D_8013DED0 |  | gp-rel |
| `eaclib/psx/eacpsxz/vramfxya` | `eaclib/psx/eacpsxz/vramfxya` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 2 | 0 | None |  |  | - |
| `eaclib/psx/eacpsxz/wildcard` | `eaclib/psx/eacpsxz/wildcard` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 2 | 2 | 1 | None |  |  | - |
| `eaclib/psx/eacpsxz/xform` | `eaclib/psx/eacpsxz/xform` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/pad` | `eaclib/psx/pad` | **0..8** | 0 | 16 | 0 | 2 | 0 | 2 | 0 | 1 | 9 | 2 | None |  | Padglobal | <placement |
| `eaclib/psx/sndpsxz/s3dlow` | `eaclib/psx/sndpsxz/s3dlow` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/s3dpos` | `eaclib/psx/sndpsxz/s3dpos` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 2 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/saelib` | `eaclib/psx/sndpsxz/saelib` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/saetodv` | `eaclib/psx/sndpsxz/saetodv` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/saetolrv` | `eaclib/psx/sndpsxz/saetolrv` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/salloc` | `eaclib/psx/sndpsxz/salloc` | **UNDET** | 0 | None | 0 | 0 | 0 | 4 | 0 | 1 | 12 | 6 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sautovol` | `eaclib/psx/sndpsxz/sautovol` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 1 | 16 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sbadd` | `eaclib/psx/sndpsxz/sbadd` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 1 | 16 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sballoc` | `eaclib/psx/sndpsxz/sballoc` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sbdload` | `eaclib/psx/sndpsxz/sbdload` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/sbend` | `eaclib/psx/sndpsxz/sbend` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 2 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sbhdrcpy` | `eaclib/psx/sndpsxz/sbhdrcpy` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 0 | 2 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sbhdrsze` | `eaclib/psx/sndpsxz/sbhdrsze` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sbirmpat` | `eaclib/psx/sndpsxz/sbirmpat` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sbremove` | `eaclib/psx/sndpsxz/sbremove` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 2 | 1 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sbvalid` | `eaclib/psx/sndpsxz/sbvalid` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/scdvol` | `eaclib/psx/sndpsxz/scdvol` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 1 | 12 |  |  | - |
| `eaclib/psx/sndpsxz/sclcptch` | `eaclib/psx/sndpsxz/sclcptch` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 1 | 1 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sdata` | `eaclib/psx/sndpsxz/sdata` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/sdcdvol` | `eaclib/psx/sndpsxz/sdcdvol` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sdfx` | `eaclib/psx/sndpsxz/sdfx` | **UNDET** | 0 | None | 0 | 0 | 0 | 5 | 0 | 3 | 4 | 4 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sdma` | `eaclib/psx/sndpsxz/sdma` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 2 | 10 | 5 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sdmemlu` | `eaclib/psx/sndpsxz/sdmemlu` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 2 | 2 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sdmemman` | `eaclib/psx/sndpsxz/sdmemman` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 2 | 5 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sdpacket` | `eaclib/psx/sndpsxz/sdpacket` | **UNDET** | 0 | None | 0 | 0 | 0 | 7 | 0 | 2 | 16 | 7 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sdplapat` | `eaclib/psx/sndpsxz/sdplapat` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 1 | 2 | 2 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sdresolv` | `eaclib/psx/sndpsxz/sdresolv` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/sdriver` | `eaclib/psx/sndpsxz/sdriver` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 3 | 1 | None |  |  | - |
| `eaclib/psx/sndpsxz/sdspuirq` | `eaclib/psx/sndpsxz/sdspuirq` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 2 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sdtimrem` | `eaclib/psx/sndpsxz/sdtimrem` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/seffect` | `eaclib/psx/sndpsxz/seffect` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 2 | 1 | 1 | 16 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sfxlevel` | `eaclib/psx/sndpsxz/sfxlevel` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 1 | 16 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sgetdata` | `eaclib/psx/sndpsxz/sgetdata` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/sgettag` | `eaclib/psx/sndpsxz/sgettag` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/sgetvol` | `eaclib/psx/sndpsxz/sgetvol` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 1 | 16 |  |  | gapsize |
| `eaclib/psx/sndpsxz/slib` | `eaclib/psx/sndpsxz/slib` | **UNDET** | 0 | None | 0 | 0 | 0 | 6 | 0 | 1 | 19 | 7 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/slimits` | `eaclib/psx/sndpsxz/slimits` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 4 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/smasterv` | `eaclib/psx/sndpsxz/smasterv` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 1 | 16 |  |  | gapsize |
| `eaclib/psx/sndpsxz/smath64` | `eaclib/psx/sndpsxz/smath64` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/smemman` | `eaclib/psx/sndpsxz/smemman` | **UNDET** | 0 | None | 0 | 0 | 0 | 3 | 0 | 1 | 5 | 1 | 2 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sover` | `eaclib/psx/sndpsxz/sover` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/span` | `eaclib/psx/sndpsxz/span` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 1 | 16 |  |  | gapsize |
| `eaclib/psx/sndpsxz/spat2hdr` | `eaclib/psx/sndpsxz/spat2hdr` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/spatkey` | `eaclib/psx/sndpsxz/spatkey` | **UNDET** | 0 | None | 0 | 0 | 0 | 4 | 0 | 2 | 9 | 2 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/spitch` | `eaclib/psx/sndpsxz/spitch` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 1 | 16 |  |  | gapsize |
| `eaclib/psx/sndpsxz/spktplay` | `eaclib/psx/sndpsxz/spktplay` | **UNDET** | 0 | None | 0 | 0 | 0 | 4 | 0 | 2 | 18 | 2 | 16 |  |  | gapsize |
| `eaclib/psx/sndpsxz/splay` | `eaclib/psx/sndpsxz/splay` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 0 | 1 | 1 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/splysdef` | `eaclib/psx/sndpsxz/splysdef` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/spvoices` | `eaclib/psx/sndpsxz/spvoices` | **UNDET** | 0 | None | 0 | 0 | 0 | 3 | 0 | 2 | 2 | 3 | 16 |  |  | gapsize |
| `eaclib/psx/sndpsxz/spvtolrv` | `eaclib/psx/sndpsxz/spvtolrv` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/srandom` | `eaclib/psx/sndpsxz/srandom` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 2 | 1 | None |  |  | - |
| `eaclib/psx/sndpsxz/srrange` | `eaclib/psx/sndpsxz/srrange` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/sserver` | `eaclib/psx/sndpsxz/sserver` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 6 | 4 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/ssine` | `eaclib/psx/sndpsxz/ssine` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 4 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/sst` | `eaclib/psx/sndpsxz/sst` | **UNDET** | 0 | None | 0 | 0 | 0 | 3 | 0 | 0 | 10 | 8 | 12 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sstautov` | `eaclib/psx/sndpsxz/sstautov` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sstgetrp` | `eaclib/psx/sndpsxz/sstgetrp` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/sstgetv` | `eaclib/psx/sndpsxz/sstgetv` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sstop` | `eaclib/psx/sndpsxz/sstop` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sstopall` | `eaclib/psx/sndpsxz/sstopall` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sstovrhd` | `eaclib/psx/sndpsxz/sstovrhd` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/sstrstat` | `eaclib/psx/sndpsxz/sstrstat` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 1 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sstsetgl` | `eaclib/psx/sndpsxz/sstsetgl` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sstsetgs` | `eaclib/psx/sndpsxz/sstsetgs` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sstsetpr` | `eaclib/psx/sndpsxz/sstsetpr` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/sststat` | `eaclib/psx/sndpsxz/sststat` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 1 |  |  | gapsize |
| `eaclib/psx/sndpsxz/sstvol` | `eaclib/psx/sndpsxz/sstvol` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/ssysinit` | `eaclib/psx/sndpsxz/ssysinit` | **UNDET** | 0 | None | 0 | 0 | 0 | 3 | 0 | 1 | 4 | 3 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/ssysreal` | `eaclib/psx/sndpsxz/ssysreal` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 2 | 0 | None |  |  | - |
| `eaclib/psx/sndpsxz/ssysserv` | `eaclib/psx/sndpsxz/ssysserv` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 3 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/stagpat` | `eaclib/psx/sndpsxz/stagpat` | **UNDET** | 0 | None | 0 | 0 | 0 | 5 | 0 | 2 | 5 | 4 | 4 |  |  | gapsize |
| `eaclib/psx/sndpsxz/stimerem` | `eaclib/psx/sndpsxz/stimerem` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | gapsize |
| `eaclib/psx/sndpsxz/svol` | `eaclib/psx/sndpsxz/svol` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 2 | 0 | None |  |  | gapsize |
| `eaclib/psx/spchpsxz/spchbank` | `eaclib/psx/spchpsxz/spchbank` | **UNDET** | 0 | None | 0 | 0 | 0 | 4 | 0 | 1 | 12 | 3 | None |  |  | gapsize |
| `eaclib/psx/spchpsxz/spchdata` | `eaclib/psx/spchpsxz/spchdata` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/spchpsxz/spchevnt` | `eaclib/psx/spchpsxz/spchevnt` | **UNDET** | 0 | None | 0 | 0 | 0 | 7 | 0 | 0 | 21 | 7 | None |  |  | gapsize |
| `eaclib/psx/spchpsxz/spchinit` | `eaclib/psx/spchpsxz/spchinit` | **UNDET** | 0 | None | 0 | 0 | 0 | 10 | 0 | 0 | 14 | 5 | 4 |  |  | gapsize |
| `eaclib/psx/spchpsxz/spchpick` | `eaclib/psx/spchpsxz/spchpick` | **UNDET** | 0 | None | 0 | 0 | 0 | 10 | 0 | 0 | 23 | 10 | 4 |  |  | gapsize |
| `eaclib/psx/spchpsxz/spchrand` | `eaclib/psx/spchpsxz/spchrand` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 4 | 1 | None |  |  | gapsize |
| `eaclib/psx/spchpsxz/spchrslv` | `eaclib/psx/spchpsxz/spchrslv` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `eaclib/psx/spchpsxz/spchrule` | `eaclib/psx/spchpsxz/spchrule` | **UNDET** | 0 | None | 0 | 0 | 0 | 3 | 0 | 1 | 2 | 1 | 4 |  |  | - |
| `eaclib/psx/spchpsxz/spchsamp` | `eaclib/psx/spchpsxz/spchsamp` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `front` | `front` | **0..0** | 0 | 1 | 0 | 11 | 0 | 0 | 0 | 0 | 0 | 0 | None |  | memCardReadOK | <placement |
| `frontend/common/feapp` | `feapp` | **0..2** | 0 | 4 | 0 | 2 | 0 | 29 | 0 | 16 | 51 | 40 | 4 |  | FEApp, gLargestUnused | <placement |
| `frontend/common/feaudio` | `feaudio` | **0..0** | 0 | 1 | 0 | 7 | 0 | 17 | 0 | 8 | 21 | 16 | 4 |  | gCurrentVIV | <placement |
| `frontend/common/fecars` | `fecars` | **0..0** | 0 | 1 | 0 | 2 | 0 | 12 | 0 | 11 | 24 | 7 | 200 |  | cars_disableBonuses | <placement |
| `frontend/common/fecheats` | `fecheats` | **0..16** | 0 | 36 | 0 | 2 | 0 | 10 | 0 | 7 | 14 | 6 | None |  | bonusList | <placement |
| `frontend/common/fecredits` | `fecredits` | **0..2** | 0 | 4 | 0 | 1 | 0 | 8 | 0 | 2 | 9 | 10 | 4 |  | CREDFADETICKS | <placement |
| `frontend/common/fedialog` | `fedialog` | **0..16** | 0 | 32 | 0 | 1 | 0 | 15 | 0 | 9 | 25 | 12 | 4 |  | DialogVisibilityList | <placement |
| `frontend/common/fefades` | `fefades` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 2 | 4 | 2 | None |  |  | - |
| `frontend/common/feinput` | `feinput` | **0..2** | 0 | 4 | 0 | 3 | 0 | 7 | 0 | 4 | 9 | 7 | 128 |  | nextTick | <placement |
| `frontend/common/felines` | `felines` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `frontend/common/fememcard` | `fememcard` | **0..0** | 0 | 1 | 0 | 7 | 0 | 31 | 0 | 20 | 77 | 35 | 1104 |  | CURRENTLYUSINGMEMCARD, MEMCARD_INITIALIZED, nomessage | <placement |
| `frontend/common/femenu` | `femenu` | **0..2** | 0 | 4 | 0 | 1 | 0 | 14 | 0 | 12 | 20 | 4 | 4 |  | gMenu_SubMenuPlayer | <placement |
| `frontend/common/femenudefs` | `femenudefs` | **0..2** | 0 | 4 | 0 | 16 | 0 | 62 | 0 | 30 | 287 | 152 | 4 |  | SelectListNull, menuDefs | <placement |
| `frontend/common/femenuextended` | `femenuextended` | **0..4** | 0 | 8 | 0 | 1 | 0 | 15 | 0 | 8 | 25 | 8 | 4 |  | gHelpPos | <placement |
| `frontend/common/femenuoptions` | `femenuoptions` | **0..2** | 0 | 4 | 0 | 2 | 0 | 36 | 0 | 21 | 53 | 33 | 2 |  | PulsateYellow, fHelpText | <placement |
| `frontend/common/femission` | `femission` | **UNDET** | 0 | None | 0 | 0 | 0 | 6 | 0 | 6 | 7 | 1 | None |  |  | - |
| `frontend/common/fescreen` | `fescreen` | **0..2** | 0 | 4 | 0 | 1 | 0 | 13 | 0 | 7 | 12 | 7 | 4 |  | gCurrentShapes | <placement |
| `frontend/common/fetextrender` | `fetextrender` | **0..0** | 0 | 1 | 0 | 2 | 0 | 9 | 0 | 3 | 10 | 9 | 4 |  | gSemiTransText | <placement |
| `frontend/common/fetools` | `fetools` | **0..1** | 0 | 2 | 0 | 5 | 0 | 8 | 0 | 4 | 4 | 7 | 2 |  | currentSize | <placement |
| `frontend/common/fetourn` | `fetourn` | **UNDET** | 0 | None | 0 | 0 | 0 | 16 | 0 | 12 | 23 | 18 | 200 |  |  | - |
| `frontend/common/fetracks` | `fetracks` | **0..2** | 0 | 4 | 0 | 2 | 0 | 6 | 0 | 4 | 5 | 2 | 200 |  | tracks_maxTrackIndex | <placement |
| `frontend/common/fetv` | `fetv` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 4 |  |  | - |
| `frontend/common/fevideowall` | `fevideowall` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 5 | 1 | None |  |  | - |
| `frontend/common/front` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 83 | 0 | 38 | 124 | 95 | 1 |  |  | - |
| `frontend/common/mcrd` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `frontend/common/screenaudio` | `screenaudio` | **0..2** | 0 | 4 | 0 | 1 | 0 | 19 | 0 | 7 | 37 | 15 | 4 |  | screenAudio | <placement |
| `frontend/common/screencarselect` | `screencarselect` | **0..2** | 0 | 4 | 0 | 18 | 0 | 49 | 0 | 31 | 156 | 58 | 1 |  | screenCarSelect, screenCarSelectDuel, screenCarSelectPlayerTwo | <placement |
| `frontend/common/screencongrats` | `screencongrats` | **0..2** | 0 | 4 | 0 | 6 | 0 | 17 | 0 | 11 | 41 | 19 | 1 |  | screenBeTheCopCongrats, screenPinkSlipCongrats, screenTournamentCongrats | <placement |
| `frontend/common/screencontroller` | `screencontroller` | **0..2** | 0 | 4 | 0 | 7 | 0 | 22 | 0 | 15 | 46 | 44 | 4 |  | screenControllerConfig | <placement |
| `frontend/common/screendisplay` | `screendisplay` | **0..2** | 0 | 4 | 0 | 1 | 0 | 2 | 0 | 1 | 2 | 0 | None |  | screenDisplay | <placement |
| `frontend/common/screenmain` | `screenmain` | **0..2** | 0 | 4 | 0 | 40 | 0 | 18 | 0 | 13 | 27 | 20 | 16 |  | screenMain | <placement |
| `frontend/common/screenmemcard` | `screenmemcard` | **0..2** | 0 | 4 | 0 | 19 | 0 | 29 | 0 | 6 | 31 | 66 | 4 |  | EXTRAYATTOP, GRIDMEMCARDGOURAUDBIT_X, GRIDMEMCARDGOURAUDBIT_Y | <placement |
| `frontend/common/screenpinkslips` | `screenpinkslips` | **0..2** | 0 | 4 | 0 | 2 | 0 | 12 | 0 | 7 | 25 | 16 | 16 |  | imageTVOrder, screenPinkSlips | <placement |
| `frontend/common/screenpost` | `screenpost` | **0..2** | 0 | 4 | 0 | 3 | 0 | 12 | 0 | 8 | 18 | 5 | 112 |  | screenPinkSlipStandings, screenTournamentStandings, screenTournamentStandings3item | <placement |
| `frontend/common/screentournselect` | `screentournselect` | **0..2** | 0 | 4 | 0 | 2 | 0 | 10 | 0 | 7 | 23 | 7 | 200 |  | screenTournSelect, trophyTVOrder | <placement |
| `frontend/common/screentrackinfo` | `screentrackinfo` | **0..2** | 0 | 4 | 0 | 2 | 0 | 10 | 0 | 10 | 9 | 4 | 6 |  | screenTrackInfo | <placement |
| `frontend/common/screentrackrecords` | `screentrackrecords` | **0..2** | 0 | 4 | 0 | 1 | 0 | 9 | 0 | 6 | 7 | 3 | 4 |  | screenTrackRecords | <placement |
| `frontend/common/screentracks` | `screentracks` | **0..2** | 0 | 4 | 0 | 1 | 0 | 11 | 0 | 7 | 23 | 12 | 200 |  | screenTrackSelect | <placement |
| `frontend/common/screentrophyinfo` | `screentrophyinfo` | **0..2** | 0 | 4 | 0 | 3 | 0 | 9 | 0 | 5 | 8 | 4 | 112 |  | screenTrophyInfo | <placement |
| `frontend/common/screentrophyroom` | `screentrophyroom` | **0..2** | 0 | 4 | 0 | 1 | 0 | 11 | 0 | 8 | 17 | 7 | 4 |  | screenTrophyRoom | <placement |
| `frontend/common/screenusername` | `screenusername` | **0..1** | 0 | 2 | 0 | 4 | 0 | 7 | 0 | 4 | 5 | 6 | None |  | MENUUSERNAME_STARTY, menu_kUserNameRows | <placement |
| `frontend/common/statchk` | `statchk` | **0..0** | 0 | 1 | 0 | 2 | 0 | 13 | 0 | 10 | 18 | 6 | 1 |  | NewBestLap | <placement |
| `frontend/common/stattool` | `stattool` | **0..4** | 0 | 6 | 0 | 2 | 0 | 14 | 0 | 13 | 13 | 3 | 6 |  | minChar, secChar | <placement |
| `frontend/psx/drawshp` | `drawshp` | **0..2** | 0 | 4 | 0 | 1 | 0 | 1 | 0 | 0 | 1 | 1 | None |  | kNoColor | <placement |
| `frontend/psx/fetexture` | `fetexture` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `frontend/psx/mdec` | `mdec` | **0..2** | 0 | 4 | 0 | 2 | 0 | 6 | 0 | 2 | 6 | 7 | 4 |  | g_mdecdrawsyncfailed | <placement |
| `frontend/psx/memcard` | `memcard` | **0..4** | 0 | 6 | 0 | 5 | 0 | 10 | 0 | 9 | 38 | 18 | 6108 |  | sjis_table | <placement |
| `frontend/psx/mmeffect` | `mmeffect` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `frontend/psx/movie` | `movie` | **0..0** | 0 | 1 | 0 | 30 | 0 | 35 | 0 | 11 | 61 | 58 | 2 |  | bMovieLoaded, bStopMovie, gIsRGB24 | <placement+gapsize |
| `frontend/psx/psxfront` | `psxfront` | **0..0** | 0 | 1 | 0 | 8 | 0 | 37 | 0 | 14 | 38 | 25 | 1 |  | rendering3DEnvironmentInitialized, titleScreenDisplayed | <placement |
| `frontend/psx/video` | `video` | **UNDET** | 0 | None | 0 | 0 | 0 | 8 | 0 | 4 | 7 | 5 | 200 |  |  | - |
| `game/common/ai` | `ai` | **4..8** | 4 | 12 | 3 | 3 | 2 | 26 | 0 | 5 | 119 | 27 | 16 | AI_elapsedTime, AI_iTime, AI_time | CarLogic_gObs | placement+gp-rel+<placement |
| `game/common/aicop` | `aicop` | **4..16** | 4 | 20 | 3 | 8 | 3 | 7 | 0 | 3 | 12 | 3 | 36 | AICop_gRoadBlockState, AICop_numArrestedHumans, AICop_rawTriggers | AICop_spikeBelt | placement+gp-rel+<placement |
| `game/common/aidelaycar` | `aidelaycar` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 2 | 0 | None |  |  | - |
| `game/common/aih_basiccop` | `aih_basiccop` | **UNDET** | 0 | None | 0 | 0 | 0 | 13 | 0 | 2 | 18 | 2 | 88 |  |  | - |
| `game/common/aih_basicperp` | `aih_basicperp` | **0..8** | 0 | 12 | 0 | 5 | 0 | 18 | 0 | 9 | 26 | 15 | 36 |  | AIHigh_BasicPerp_CaughtDistance, AIHigh_BasicPerp_CopCaughtSpeed, AIHigh_BasicPerp_MinDeltaSpeed | <placement |
| `game/common/aih_btccop` | `aih_btccop` | **4..8** | 4 | 12 | 0 | 2 | 2 | 36 | 0 | 16 | 111 | 16 | 12 | D_8013C564, _19AIHigh_BTC_HumanCop_lastInputRequestTick_ | AIH_BTC_Cop_1HC1HP_StageTimes | gp-rel+<placement |
| `game/common/aih_btcperp` | `aih_btcperp` | **0..8** | 0 | 12 | 0 | 2 | 0 | 24 | 0 | 14 | 70 | 23 | 12 |  | AIHigh_BTC_uTurnProb1000Skills | <placement |
| `game/common/aih_cop` | `aih_cop` | **0..8** | 0 | 12 | 0 | 4 | 0 | 29 | 0 | 12 | 73 | 17 | 16 |  | AICop_skillDelay | <placement |
| `game/common/aih_hum` | `aih_hum` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 2 | 2 | 0 | None |  |  | - |
| `game/common/aih_opp` | `aih_opp` | **UNDET** | 0 | None | 0 | 0 | 0 | 15 | 0 | 7 | 23 | 1 | None |  |  | - |
| `game/common/aih_play` | `aih_play` | **8** | 5 | 12 | 1 | 1 | 0 | 27 | 0 | 10 | 94 | 11 | 28 | gBlockadeTypes | AIHigh_Player_kNumArrestsByLap | placement+<placement |
| `game/common/aih_traf` | `aih_traf` | **UNDET** | 0 | None | 0 | 0 | 0 | 15 | 0 | 7 | 29 | 3 | 36 |  |  | - |
| `game/common/aihigh` | `aihigh` | **4..16** | 4 | 36 | 1 | 1 | 1 | 16 | 0 | 12 | 24 | 4 | None | AIHigh_CopGameType | highLevelAIObjs | placement+gp-rel+<placement |
| `game/common/ailife` | `ailife` | **UNDET** | 0 | None | 0 | 0 | 0 | 20 | 0 | 6 | 70 | 4 | 8 |  |  | - |
| `game/common/aispeeds` | `aispeeds` | **4..8** | 4 | 12 | 8 | 11 | 2 | 27 | 0 | 8 | 101 | 14 | 44 | AISpeeds_WeatherMultFactors, AISpeeds_trackAndNightMult, Track0Speeds | Track3Speeds, Track5Speeds | placement+gp-rel+<placement |
| `game/common/aistate` | `aistate` | **>=4** | 4 | None | 1 | 0 | 1 | 29 | 0 | 18 | 70 | 20 | 8 | AIState_Purgatory_numTrafficCarsInPurgatory |  | placement+gp-rel |
| `game/common/aitriger` | `aitriger` | **>=4** | 4 | None | 2 | 0 | 0 | 1 | 0 | 0 | 2 | 2 | None | triggerManagerCops, triggerManagerTraffic |  | placement |
| `game/common/aiworld` | `aiworld` | **0..16** | 0 | 320 | 0 | 1 | 0 | 4 | 0 | 1 | 23 | 1 | 320 |  | inverseLaneWidthTable | <placement |
| `game/common/anim` | `anim` | **0..16** | 0 | 40 | 0 | 3 | 0 | 9 | 0 | 7 | 14 | 9 | 4 |  | animScripts | <placement |
| `game/common/audedit` | `audedit` | **>=4** | 4 | None | 1 | 0 | 1 | 2 | 0 | 2 | 1 | 1 | 4 | gGameAudioList |  | placement+gp-rel |
| `game/common/audioclc` | `audioclc` | **4..16** | 4 | 36 | 8 | 4 | 8 | 17 | 0 | 7 | 46 | 18 | 160 | AudioClc_gBullHornCount, AudioClc_gBumpCopCount, AudioClc_gCameraVelocity | AudioClc_PursuitTime | placement+gp-rel+<placement |
| `game/common/audiocmn` | `audiocmn` | **8** | 8 | 12 | 47 | 20 | 31 | 44 | 0 | 34 | 130 | 50 | 4 | AudioCmn_gPlayerArrested, PlayersRampedGasLevel, bestLapTime | carbankname | placement+<placement |
| `game/common/audioeng` | `audioeng` | **>=8** | 8 | None | 1 | 0 | 0 | 15 | 0 | 13 | 14 | 11 | 8 | AudioEng_g |  | placement |
| `game/common/audiomus` | `audiomus` | **>=4** | 4 | None | 1 | 0 | 1 | 10 | 0 | 7 | 9 | 5 | 8 | AudioMus_g |  | placement+gp-rel |
| `game/common/audiotrk` | `audiotrk` | **>=4** | 4 | None | 1 | 0 | 1 | 9 | 0 | 2 | 15 | 4 | 128 | AudioTrk_g |  | placement+gp-rel |
| `game/common/bworld` | `bworld` | **4..16** | 4 | 36 | 12 | 5 | 14 | 41 | 0 | 13 | 75 | 14 | 4 | BW_gCopCarObj, BWorld_gChunkCount, D_8013C75C | gCopMat, gNightMat, gWorldMat | placement+gp-rel+<placement |
| `game/common/bworldsm` | `bworldsm` | **4..16** | 4 | 512 | 8 | 1 | 4 | 7 | 0 | 3 | 18 | 1 | 48 | BWSM_NormalCacheSysTime, BWorldSm_slices, gMaxFindQuadSliceIterations | BWSM_NormalCache | placement+gp-rel+<placement |
| `game/common/camera` | `camera` | **4..8** | 4 | 12 | 1 | 11 | 1 | 34 | 0 | 23 | 176 | 43 | 13 | Camera_gGeomScreen | gSplitCameras | placement+gp-rel+<placement |
| `game/common/cars` | `cars` | **4..16** | 4 | 28 | 11 | 20 | 11 | 44 | 0 | 30 | 124 | 54 | 4 | Cars_gNumAICars, Cars_gNumAIRaceCars, Cars_gNumCars | Cars_kAudioCollisoinTypeInterface | placement+gp-rel+<placement |
| `game/common/chunk` | `chunk` | **>=4** | 4 | None | 2 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None | Chunk_chunkCenters, Chunk_lightTable |  | placement |
| `game/common/clock` | `clock` | **4..8** | 4 | 12 | 3 | 1 | 3 | 3 | 0 | 0 | 4 | 2 | None | clock_InterruptStarted, generic128HzClock, stopClock | clock_realTime | placement+gp-rel+<placement |
| `game/common/collide` | `collide` | **4..16** | 4 | 24 | 11 | 5 | 11 | 9 | 0 | 3 | 10 | 8 | 36 | Collide_gNumRegistered, Collide_gRaiseUp, findClosestSideDave | basisDotRelative | placement+gp-rel+<placement |
| `game/common/color` | `color` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `game/common/control` | `control` | **UNDET** | 0 | None | 0 | 0 | 0 | 6 | 0 | 1 | 14 | 0 | None |  |  | - |
| `game/common/copspeak` | `copspeak` | **8** | 8 | 12 | 16 | 5 | 13 | 40 | 0 | 33 | 45 | 32 | 4 | CopSpeak_gStaticHandle | CopSpeak_gMusicStat | placement+<placement |
| `game/common/dashhud` | `dashhud` | **8..16** | 8 | 108 | 0 | 1 | 1 | 6 | 0 | 3 | 22 | 18 | None | D_8013DDB0 | DashHUD_gInfo | gp-rel+<placement |
| `game/common/fastrand` | `fastrand` | **>=4** | 4 | None | 4 | 0 | 3 | 0 | 0 | 0 | 0 | 0 | None | fastRandom, numRandCalls, randSeed |  | placement+gp-rel |
| `game/common/genericpmx` | `genericpmx` | **8** | 8 | 12 | 13 | 7 | 13 | 38 | 0 | 35 | 44 | 6 | 8 | gGravelPixmap, gSMokePixmap, gShadowPixmap | gFlarePixmap, gWeatherPixmap | placement+gp-rel+<placement |
| `game/common/gmesetup` | `gmesetup` | **0..16** | 0 | 48 | 0 | 4 | 0 | 9 | 0 | 3 | 7 | 11 | 736 |  | GameSetup_gTrackNames | <placement |
| `game/common/group` | `group` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `game/common/hudpmx` | `hudpmx` | **8..16** | 8 | 40 | 3 | 2 | 5 | 145 | 0 | 142 | 148 | 7 | 8 | D_8013CD37 | HudPmx_gHudNumberUV | gp-rel+<placement |
| `game/common/input` | `input` | **8..16** | 8 | 32 | 5 | 4 | 2 | 11 | 0 | 9 | 45 | 11 | 736 | Input_gLookBehind, Input_gMode, Input_gResults | Input_gDBFlags | placement+<placement |
| `game/common/mathnfs` | `mathnfs` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `game/common/minfront` | `minfront` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `game/common/mpause` | `mpause` | **8..16** | 8 | 24 | 9 | 1 | 11 | 16 | 0 | 3 | 46 | 2 | 84 | InGameSelectListAudioMode, SelectListConfig | gBackList | placement+<placement |
| `game/common/new` | `new` | **>=4** | 4 | None | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None | New_cplusplus_heap |  | placement |
| `game/common/newton` | `newton` | **0..8** | 0 | 16 | 0 | 5 | 0 | 19 | 0 | 7 | 68 | 9 | 12 |  | swap | <placement+gapsize |
| `game/common/nfs3` | `nfs3` | **8** | 8 | 10 | 16 | 9 | 1 | 34 | 0 | 24 | 41 | 20 | 8 | finishOrder, missionManager | befuddleTemp | placement+<placement+gapsize |
| `game/common/object` | `object` | **4..16** | 4 | 280 | 6 | 2 | 6 | 23 | 0 | 13 | 58 | 9 | 36 | Object_IMassObjInst, Object_customObjInst, Object_customSFXInst | gAnimDefs | placement+gp-rel+<placement |
| `game/common/paths` | `paths` | **4..16** | 4 | 200 | 3 | 1 | 0 | 3 | 0 | 3 | 4 | 0 | None | Paths_File | Paths_Paths | placement+<placement |
| `game/common/pausemenu` | `pausemenu` | **>=4** | 4 | None | 2 | 0 | 1 | 14 | 0 | 12 | 33 | 0 | None | gPause_CurrentY |  | placement+gp-rel |
| `game/common/physics` | `physics` | **4..8** | 4 | 12 | 13 | 6 | 13 | 18 | 0 | 6 | 35 | 18 | 12 | currentWallType, exceedRedline, frontMult | gravity_ch, gripLossTable, gripLossTableWet | placement+gp-rel+<placement |
| `game/common/quatern` | `quatern` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `game/common/r3dcar` | `r3dcar` | **8** | 8 | 12 | 15 | 20 | 14 | 73 | 0 | 53 | 162 | 56 | 4 | R3DCar_center | R3DCar_FlareOverlayIndex | placement+<placement |
| `game/common/render` | `render` | **8..16** | 8 | 140 | 10 | 1 | 8 | 7 | 0 | 3 | 18 | 3 | None | gPauseMenuRect | gCView | placement+gp-rel+<placement |
| `game/common/replay` | `replay` | **8..16** | 8 | 32 | 6 | 8 | 5 | 23 | 0 | 12 | 101 | 26 | 32 | Replay_ReplayCounter | Replay_ReplayCamera, Replay_ReplayInterface, uncompressed_data | placement+<placement |
| `game/common/scene` | `scene` | **>=4** | 4 | None | 1 | 0 | 1 | 5 | 0 | 2 | 3 | 2 | 200 | gGameSceneList |  | placement+gp-rel |
| `game/common/schedule` | `schedule` | **0..16** | 0 | 28 | 0 | 5 | 0 | 6 | 0 | 6 | 6 | 3 | 28 |  | Sched_ExecuteElapsedTimes, Sched_ExecuteMasks, Sched_ExecuteTimes | <placement |
| `game/common/sim` | `sim` | **4..8** | 4 | 16 | 4 | 3 | 4 | 23 | 0 | 5 | 74 | 18 | 16 | InBetween, quitType, skipRender | counter | placement+gp-rel+<placement |
| `game/common/simplemem` | `simplemem` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `game/common/simqueue` | `simqueue` | **8..16** | 8 | 524 | 5 | 1 | 4 | 3 | 0 | 3 | 12 | 3 | None | output | inputQueue | placement+<placement |
| `game/common/souffle` | `souffle` | **>=4** | 4 | None | 4 | 0 | 4 | 4 | 0 | 2 | 6 | 1 | None | gCISouffle, gISouffle, gTMoveSouffle |  | placement+gp-rel |
| `game/common/spchevnt` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `game/common/speech` | `speech` | **4..16** | 4 | 44 | 0 | 11 | 2 | 33 | 0 | 23 | 62 | 14 | 4 | _6Speech_fgSpeech, _6Speech_fgUndefined | Speech_gLocationDescription | gp-rel+<placement |
| `game/common/stats` | `stats` | **0..16** | 0 | 96 | 0 | 1 | 0 | 15 | 0 | 5 | 57 | 9 | None |  | Stats_racePosition | <placement |
| `game/common/textsys` | `textsys` | **4..16** | 4 | 24 | 1 | 1 | 1 | 4 | 0 | 3 | 4 | 2 | 4 | wordFile | langFileName | placement+gp-rel+<placement |
| `game/common/track` | `track` | **4..16** | 4 | 24 | 19 | 2 | 19 | 27 | 0 | 22 | 30 | 16 | 8 | Chunk_numLight, Track_chunkList, Track_gControllerCount | gInitialArt | placement+gp-rel+<placement+gapsize |
| `game/common/trgsfx` | `trgsfx` | **4..16** | 4 | 32 | 2 | 8 | 2 | 10 | 0 | 9 | 35 | 8 | None | gTAddCSmoke, gTAddCarWheelDelay | gTAddCarSfx, gTEnviroEffect | placement+gp-rel+<placement |
| `game/common/udff` | `udff` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `game/psx/audio` | `audio` | **4..16** | 4 | 20 | 3 | 1 | 2 | 6 | 0 | 4 | 8 | 3 | 8 | Audio_direct3davail, Audio_gHeap, gMusicHandle | backwardsTrackStartTrigger | placement+gp-rel+<placement |
| `game/psx/cario` | `cario` | **8** | 8 | 12 | 7 | 7 | 6 | 21 | 0 | 16 | 44 | 4 | 24 | CarIO_Plate1, CarIO_Plate2 | CarIO_carVRamAdd, CarIO_carVRamOffset | placement+gp-rel+<placement |
| `game/psx/device` | `device` | **8..16** | 8 | 60 | 6 | 1 | 6 | 8 | 0 | 5 | 20 | 3 | None | Device_gPrev, Device_gToggleTime | Device_gDeviceList | placement+gp-rel+<placement |
| `game/psx/draw` | `draw` | **4..16** | 4 | 48 | 9 | 2 | 9 | 10 | 0 | 6 | 29 | 8 | 4 | Draw_gDoVSync, Draw_gMaxPrim, Draw_gMidGroundOtz | gEnviro | placement+gp-rel+<placement |
| `game/psx/drawc` | `drawc` | **8..16** | 8 | 20 | 10 | 7 | 7 | 40 | 0 | 22 | 95 | 38 | 4 | DrawC_gEnvMapOffset, DrawC_gMenuColor | hilight_colors | placement+<placement |
| `game/psx/draww` | `draww` | **8..16** | 8 | 24 | 6 | 7 | 3 | 48 | 0 | 23 | 96 | 32 | 24 | goffsets | gChunkObjInfo | placement+<placement |
| `game/psx/fe3dmenu` | `fe3dmenu` | **0..0** | 0 | 1 | 0 | 5 | 0 | 11 | 0 | 4 | 5 | 7 | 4 |  | showRoomFlag | <placement |
| `game/psx/flare` | `flare` | **4..8** | 4 | 12 | 3 | 18 | 3 | 28 | 0 | 22 | 92 | 6 | 36 | gfrgb, gfrgb2, gscale | gfHexPt1, gfHexPt2 | placement+gp-rel+<placement |
| `game/psx/font` | `font` | **4..16** | 4 | 48 | 8 | 2 | 8 | 6 | 0 | 4 | 12 | 3 | None | font_abr, font_clutx, font_cluty | shpfontclut | placement+gp-rel+<placement |
| `game/psx/force` | `force` | **8** | 6 | 16 | 4 | 2 | 1 | 9 | 0 | 7 | 15 | 4 | 36 | Force_gActAlign, Force_gOffAlign | Force_g | placement+<placement |
| `game/psx/hrzsku` | `hrzsku` | **8** | 8 | 16 | 8 | 10 | 8 | 25 | 0 | 17 | 51 | 9 | 8 | Hrz_gLightningPosInSky, moonPosInSky, sunPosInSky | Hrz_gSaveCol | placement+gp-rel+<placement |
| `game/psx/hud` | `hud` | **8** | 8 | 10 | 42 | 17 | 38 | 75 | 0 | 58 | 264 | 78 | 4 | HudSplitTimeDiff1, HudSplitTimeDiff2, Hud_gHudView | BTC_CurrentPerpName | placement+gp-rel+<placement |
| `game/psx/loading` | `loading` | **4..16** | 4 | 24 | 2 | 1 | 2 | 7 | 0 | 7 | 4 | 4 | 8 | smallShapeFile, totalAvailMem | loading_languageNames | placement+gp-rel+<placement |
| `game/psx/night` | `night` | **8..16** | 8 | 20 | 31 | 3 | 29 | 23 | 0 | 18 | 39 | 12 | 8 | Night_gColor, Night_gCopColor, Night_gPlayerHeadLightColor | Night_gCopCountryLightTbl | placement+gp-rel+<placement |
| `game/psx/overlays` | `overlays` | **8..16** | 8 | 320 | 2 | 1 | 2 | 12 | 0 | 6 | 41 | 18 | 4 | StatsTimer | BTCPerpInfo | placement+gp-rel+<placement |
| `game/psx/platform` | `platform` | **>=4** | 4 | None | 7 | 0 | 6 | 5 | 0 | 3 | 5 | 1 | 8 | disablecard, gCurrentMemory, gDctXtraMem |  | placement+gp-rel |
| `game/psx/psxcontroller` | `psxcontroller` | **8..16** | 8 | 468 | 1 | 1 | 0 | 9 | 0 | 7 | 32 | 2 | None | hoff | mappings | placement+<placement |
| `game/psx/rpause` | `rpause` | **UNDET** | 0 | None | 0 | 0 | 0 | 6 | 0 | 2 | 13 | 1 | 48 |  |  | - |
| `game/psx/sfx` | `sfx` | **UNDET** | 0 | None | 0 | 0 | 0 | 13 | 0 | 6 | 25 | 0 | None |  |  | - |
| `game/psx/skidmark` | `skidmark` | **>=4** | 4 | None | 4 | 0 | 4 | 2 | 0 | 1 | 2 | 0 | None | gCountSm, gMaxSChunk, gSm |  | placement+gp-rel |
| `game/psx/textpix` | `textpix` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `game/psx/textpsx` | `textpsx` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 2 | 36 |  |  | - |
| `game/psx/texture` | `texture` | **4..16** | 4 | 32 | 13 | 2 | 13 | 19 | 0 | 17 | 16 | 5 | 200 | Texture_CarColor, Texture_gNum4bitPal, Texture_gNum8bitPal | gMenuPixmap | placement+gp-rel+<placement |
| `game/psx/textureprocess` | `textureprocess` | **8** | 8 | 12 | 10 | 4 | 6 | 18 | 0 | 14 | 21 | 11 | 8 | Fog_gCurrentKey | TP_gBlendColor | placement+gp-rel+<placement+gapsize |
| `game/psx/trackspec` | `trackspec` | **4..16** | 4 | 264 | 3 | 1 | 3 | 5 | 0 | 4 | 3 | 6 | 2600 | TrackSpec_gCurrentSpec, TrackSpec_gMaxSpec, TrackSpec_gPrevSpec | TrackSpec_gSpec | placement+gp-rel+<placement |
| `game/psx/trsproj` | `trsproj` | **>=4** | 4 | None | 1 | 0 | 1 | 2 | 0 | 0 | 2 | 0 | None | TrsProj_precision |  | placement+gp-rel |
| `game/psx/unpack` | `unpack` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `game/psx/weather` | `weather` | **8** | 8 | 16 | 22 | 7 | 21 | 25 | 0 | 23 | 45 | 38 | 12 | Weather_gDrawnServer, Weather_gLastProcessTime, Weather_gPServer | Weather_gDensityTbl, Weather_gIntensityTbl | placement+gp-rel+<placement |
| `main` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/2mbyte/2mbyte` | `-` | **0..4** | 0 | 8 | 0 | 0 | 0 | 3 | 1 | 1 | 8 | 1 | None |  | D_8013DE5C | <hi/lo-own+excl-own |
| `syslib/psx/libapi/a07` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a08` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a09` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a11` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a12` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a13` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a23` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a24` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a25` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a36` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a37` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a39` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a50` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a51` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a52` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a53` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a54` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a65` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a66` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a67` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a69` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/a91` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/c112` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/c114` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/c57` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/c68` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/c73` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/counter` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 3 | 0 | 0 | 4 | 1 | 24 |  |  | - |
| `syslib/psx/libapi/first` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 1 | 5 | 3 | None |  |  | gapsize |
| `syslib/psx/libapi/l02` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/l03` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libapi/l10` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/a63` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/bsearch` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c16` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c19` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c21` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c23` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c24` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c25` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c26` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c27` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c30` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c31` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c36` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c37` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c38` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c40` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c42` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c43` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c46` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c47` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/c63` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/memcmp` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/memmove` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/qsort` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libc/sprintf` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 4 | 0 | 3 | 2 | 2 | None |  |  | - |
| `syslib/psx/libcard/a74` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libcard/a75` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libcard/a76` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libcard/a78` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libcard/a80` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libcard/c171` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libcard/c172` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libcard/card` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libcard/cardinit` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libcard/end` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 4 | 0 | None |  |  | gapsize |
| `syslib/psx/libcard/init` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libcard/patch` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 12 | 0 | None |  |  | gapsize |
| `syslib/psx/libcd/cdcont` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 7 | 0 | 2 | 21 | 6 | 4 |  |  | - |
| `syslib/psx/libcd/cdread` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 12 | 0 | 10 | 27 | 7 | None |  |  | - |
| `syslib/psx/libcd/cdread2` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 3 | None |  |  | gapsize |
| `syslib/psx/libcd/drv` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 40 | 0 | 14 | 122 | 27 | 4 |  |  | gapsize |
| `syslib/psx/libcd/event` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 5 | 0 | 1 | 6 | 2 | 12 |  |  | - |
| `syslib/psx/libcd/iso9660` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 36 | 0 | 18 | 46 | 24 | 1 |  |  | gapsize |
| `syslib/psx/libcd/stcdint` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 31 | 0 | 1 | 122 | 17 | 4 |  |  | gapsize |
| `syslib/psx/libcd/stream` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 15 | 0 | 0 | 17 | 1 | None |  |  | gapsize |
| `syslib/psx/libcd/streamhelp` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 15 | 0 | 1 | 25 | 3 | None |  |  | gapsize |
| `syslib/psx/libcd/toc` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 4 | 0 | 3 | 5 | 1 | None |  |  | - |
| `syslib/psx/libcd/type` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 2 | 1 | 1 | None |  |  | - |
| `syslib/psx/libds/dscb` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | gapsize |
| `syslib/psx/libetc/intr` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 12 | 0 | 5 | 40 | 2 | None |  |  | - |
| `syslib/psx/libetc/intr_dma` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 5 | 0 | 3 | 15 | 0 | None |  |  | - |
| `syslib/psx/libetc/intr_vb` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 3 | 0 | 1 | 9 | 0 | None |  |  | - |
| `syslib/psx/libetc/vmode` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 2 | 1 | None |  |  | - |
| `syslib/psx/libetc/vsync` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 6 | 0 | 1 | 16 | 1 | None |  |  | - |
| `syslib/psx/libgpu/ext` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/font` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 6 | 0 | 1 | 7 | 3 | 348 |  |  | - |
| `syslib/psx/libgpu/p00` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p01` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p06` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p09` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p10` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p11` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p12` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p16` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p17` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p18` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p19` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/p34` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgpu/sys` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 57 | 0 | 26 | 232 | 21 | 2 |  |  | gapsize |
| `syslib/psx/libgte/cor_01` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | None |  |  | - |
| `syslib/psx/libgte/cor_02` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgte/cor_03` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgte/fgo_01` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 6 | 16384 |  |  | - |
| `syslib/psx/libgte/fgo_06` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 2 | 16384 |  |  | - |
| `syslib/psx/libgte/fog_01` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgte/msc00` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 2 | 0 | None |  |  | - |
| `syslib/psx/libgte/msc02` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 396 |  |  | - |
| `syslib/psx/libgte/patchgte` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 6 | 0 | None |  |  | gapsize |
| `syslib/psx/libgte/reg03` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgte/reg11` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libgte/reg13` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/adddf3` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/addmant` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/dbshift` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/dbshiftu` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/divdf3` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/divsf3` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | None |  |  | - |
| `syslib/psx/libmath/extsfdf2` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/ferr` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 0 | 1 | 1 | 4 |  |  | - |
| `syslib/psx/libmath/fixdfsi` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/fixsfsi` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/fltsidf` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/fltsisf` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/gtdf2` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/ltdf2` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/mainasu` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/muldf3` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/mulsf3` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmath/trudfsf2` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libmcrd/bios` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 38 | 0 | 8 | 137 | 11 | 20 |  |  | gapsize |
| `syslib/psx/libmcrd/libmcrd` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 27 | 0 | 13 | 102 | 35 | 4 |  |  | gapsize |
| `syslib/psx/libmcrd/userfunc` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 5 | 0 | 3 | 8 | 4 | 16 |  |  | gapsize |
| `syslib/psx/libpad/mcxmain` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 17 | 0 | 1 | 38 | 2 | None |  |  | - |
| `syslib/psx/libpad/pad` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | None |  |  | - |
| `syslib/psx/libpad/padcmd` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 3 | 0 | 0 | 12 | 0 | None |  |  | gapsize |
| `syslib/psx/libpad/padentry` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 0 | 6 | 1 | None |  |  | - |
| `syslib/psx/libpad/padmain` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 23 | 0 | 4 | 79 | 6 | 16 |  |  | gapsize |
| `syslib/psx/libpad/padportd` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 16 | 0 | 1 | 34 | 2 | None |  |  | - |
| `syslib/psx/libpad/padseqd` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 4 | 0 | 0 | 9 | 1 | 4 |  |  | - |
| `syslib/psx/libpad/waitrc2` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 2 | 0 | 0 | 6 | 1 | None |  |  | gapsize |
| `syslib/psx/libpress/libpress` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 15 | 0 | 6 | 32 | 3 | None |  |  | - |
| `syslib/psx/libpress/vlc` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 5 | 0 | 5 | 8 | 0 | None |  |  | - |
| `syslib/psx/libsn/close` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libsn/creat` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libsn/fsinit` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libsn/lseek` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libsn/open` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libsn/purev` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libsn/read` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libsn/snread` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libsn/snwrite` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
| `syslib/psx/libsn/write` | `-` | **UNDET** | 0 | None | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | None |  |  | - |
