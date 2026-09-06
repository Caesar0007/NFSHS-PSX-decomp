# P883 independent FETextRender data-owner proof (read-only)

The existing source `.data` run is valid for explicit native ownership:

`recon/frontend/common/fetextrender.cpp`, `.data`, **0x800515B8..0x80051610 (88 bytes)**.

The source literal initializer, parsed `front_data_o00.data.s` directives, existing compiled object `.data`, and raw `rom/nfs4-f.exe` all agree byte-for-byte. Payload SHA256:

`82a7158d55efa9688e94d835ee9d71f3780c8a4d17881e69f4ce1edb5a605053`

There are **zero data relocations**, no alignment gap between the two native objects, and no extra terminal padding in this88-byte section.

## Real symbols and types

| Native object | SYM record | Section offset | Storage/type proof |
| --- | --- | ---: | --- |
| textDefinitions |52293b|0|ARY ARY CHAR, dimensions14x6,84bytes; actual source char[14][6] and debug `.dim14,6;.size84;.type0xf2` agree|
| gSemiTransText |522963|84|BOOL, native VA8005160C; actual source bool=false and compiler emits `.word0` (4bytes), debug `.type0x0`|

The records immediately precede the native FETextRender.obj boundary52297f, after FETextRender_SetABR. Both actual ELF symbols are GLOBAL in `.data` at0/+84. **They are STT_NOTYPE with size0**, as the current PsyQ/maspsx pipeline normally emits; size84/4 must not be asserted from ELF metadata. Native records, source/debug declarations, actual emitted directives and full section bytes independently establish the spans.

Existing object SHA256 at inspection: `fc573287922a2dc9949dd2cc97b5d714612ba489c1ea87a6a07c9e3fb0a62260`.

## Interior raw labels: aliases, not additional objects

| Raw label | Offset in textDefinitions | C array element | Value |
| --- | ---: | --- | ---: |
| D_800515D5 |29|[4][5]|9|
| D_800515E1 |41|[6][5]|9|
| D_800515EC |52|[8][4]|15|
| D_800515FD |69|[11][3]|6|
| D_800515FF |71|[11][5]|9|

These five labels are spimdisasm interior byte labels; they are not additional native storage declarations. Seven raw frontend oracle functions use them (listed individually in data_receipt.json). The source lane still needs those raw definitions, so **preserve front_data_o00 in the src/oracle lane**.

The existing compiled-production-object scan covered519 objects backed by current real recon sources (stale/probe/region-gate objects excluded). It found **12 consumer TUs /46 relocation sites**, all reaching native textDefinitions/gSemiTransText names. No compiled recon relocation targets any D_ interior label. Only fetextrender.cpp defines the two native symbols. Thus the current pure recon lane needs no new interior aliases. If a mixed raw consumer later requires them, use **storage-free linker aliases** `textDefinitions + offset`, never a second array/cell or another raw payload.

Compiled consumer TUs: fedialog, fefades, femenuoptions, fetextrender, screenaudio, screencarselect, screencongrats, screencontroller, screenmemcard, screenpost, screentrackrecords, screentrophyinfo. The JSON lists the exact containing functions, relocation offsets and types.

## Integration cautions for root

**Placement correction after checking the actual generator:** the historical front-data fragment lists fetextrender.cpp.o(.data), but tools/gen_ld.py:362-367 deliberately reads ONLY the main-data and small-data fragments, NOT that front-data fragment. Its contents therefore do not establish active placement. This owner requires **explicit placement at0x800515B8**, like fecredits; do NOT set placement=fragment, which would assert false membership or hide an omitted section. The explicit-source-owner loop is at gen_ld.py:467-476. Exclude only `front_data_o00.data.s.o` from the recon lane; leave src placement intact. My initial fragment-placement suggestion was incorrect and is superseded by this checked distinction.

The current source_data_owners optional global/static validation is fecredits-specific (global+0/local-static+4). Do not reuse that schema unchanged: FETextRender has **two globals** at0/+84. Root plans SHA/payload validation plus this independent receipt for the two real symbol offsets/bindings. If symbol sizes are later checked, permit the actual NOTYPE/size0 representation and establish types separately.

No production files, tools, linkers, objects or build outputs were edited. No compiler/full build was run. verify_data.py only reads inputs and prints the proof; data_receipt.json is its saved output. Root performs integration and final link/build gating independently.
