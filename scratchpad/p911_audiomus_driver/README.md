# P911 AudioMus_DriverStartUp — verified native source scopes

Proposal only; production source, headers, tools, flags and normal outputs remain
untouched. Existing SwitchSong/Playlist/Pattern/PlaySong/Threshold recoveries are
preserved.

The final ordinary-source correction is:

1. Move the four existing chunks/size/sndlimits/opts declarations into the stream
   creation body where native SYM owns them.
2. Restore separate nested streamhandle and streambuffer tests, preserving their
   original short-circuit evaluation order.
3. Use implicit void exit, so the final serveractive assignment shares the native
   closing SLD group with the epilogue.

No names, helpers, macros, qualifiers, asm, volatile or pins are added, and no
compiler output is rewritten.

## Primary native contract

SYM19f683..19f7ed: function8007AAD4..8007AC18,81 words, frame88, mask80070000.
The seven native scopes are reproduced exactly:

| Depth | Start | End |
|---:|---|---|
|0|8007AAD4|8007AC00|
|1|8007AAD4|8007AC00|
|2|8007AAF8|8007AC00|
|3|8007AB10|8007ABC4|
|4|8007AB28|8007ABC4|
|5|8007AB28|8007ABC4|
|6|8007AB38|8007ABC4|

Only depth6 owns the four locals. Native parameter/local records match exactly:

| Name | Native home/type |
|---|---|
|buffersize|REGPARM s2, INT (`19f6d9`)|
|spusize|REGPARM s0, INT (`19f6f1`)|
|chunks|REG s1, INT (`19f745`)|
|size|REG s2, INT (`19f759`)|
|sndlimits|AUTO-64, SNDLIMITS20 (`19f76b`)|
|opts|AUTO-40, SNDPLAYOPTS20 (`19f78e`)|

The separate native scope starts atAB28 support two nested if statements rather
than the reconstruction's compound&&. Raw/M2C independently verify the same
tests and call order. Native SLD693 groups the final serveractive store with the
epilogue; implicit exit reproduces this without instruction changes.

## Frozen progression

| Stage | TU gates / branches | SLD merges/splits | Scopes |
|---|---|---|---|
|before|23 PASS /206|12/18|one root, four locals hoisted|
|narrow declarations|23 PASS /206|12/18|five, missing two native scopes|
|nested tests|23 PASS /206|0/18|all seven exact|
|implicit exit|23 PASS /206|0/0|all seven exact|
|candidate (indentation cleaned)|23 PASS /206|0/0|all seven exact|

Complete normal object code/data/symbol/relocation metadata is unchanged except
the exact checked scratch STT_FILE pathname. All22 neighboring complete local,
SLD, lexical and compiler-label graphs are unchanged. Full81 raw words match after
resolving20 native references: seven GP, nine calls and four HI/LO words. The
current69a16 linked image independently has the same exact81 words. Preprocessor
header streams remain identical.

## Exact proposal

- Production input SHA256:
  `5c06264c49606cc571e7ba2a968f4bd82491cd0f84d5fc3ce3f402842cc76080`.
- Final `inputs/candidate.cpp` SHA256:
  `34f9013264d15abd6f7c6e0cb6e2b36a8aa6910aba5b3a857054970f9856cbe3`.
- Apply-ready `proposed.patch` targets the absolute production path.
- Native81-word SHA256:
  `8cb94ce42ea3fd02ab14b178098403ffd824587becd347f551c9f763a26b78e5`.

`final_receipt.json`, `candidate_inspection.json` and all intermediate inputs and
outputs are preserved. Parent must validate actual landed paths before publication.
The recovered scope/home/statement contracts do not prove exact original physical
whitespace, macro tokens or every surrounding declaration/header identity.
