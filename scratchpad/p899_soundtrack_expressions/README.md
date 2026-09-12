# P899 follow-up: native distance expression groups

The P89922/120 scope candidate remains frozen in p899_soundtrack_scope.
This isolated follow-up restores only the x/z/d selections as three related
conditional expressions:

```cpp
x = (se->cp.x - vx > 0) ? se->cp.x - vx : vx - se->cp.x;
z = (se->cp.z - vz > 0) ? se->cp.z - vz : vz - se->cp.z;
d = (z < x) ? x + (z >> 2) : z + (x >> 2);
```

Native SLD405 covers8007D008..D024,406 coversD024..D040, and407 covers
D040..D05C. Each is one complete selection in the native record. These are
genuine expression changes, not independent statements placed on one line.

Result:22 merges/120 splits ->22 merges/76 splits;44 false split pairs
removed and ZERO new bad pairs. All25 native local owners remain exact and
all19 emitted block records retain their exact ordered native projection.
Only the two previously unproved zero-width CE40 inline records remain absent.

All six functions PASS;159 branch checks and358 raw SoundTrack words are
exact, including26 relocation words. Entire normal object is literally
identical before/after (SHA256
`b66e585e34d843786dc919fade640f65be62e8c36266b7cf2ec6f4ee6d4cb2c1`).
Both debug twins reproduce normal text exactly. All five neighbors preserve
their local/scope/SLD/code contracts; PreLoad remains2/5 with five exact owners.

No vector comma grouping was warranted: the native velocity components are
separate lines449/450/451 in the fixed-step arm and456/457/458 in the divided
arm. Grouping those would create incorrect native-line merges. The initial
zero vector already uses one chained assignment corresponding to native381.

`proposed.patch` contains the full SoundTrack change from actual P898 source;
`incremental_to_scope.patch` contains only this follow-up against the frozen
P899 scope proposal. `candidate.cpp` is the combined retained candidate.
`final_receipt.json`, `candidate_verification.json`, and
`candidate_raw_target_receipt.json` hold the exact gates. Remaining22/76 pairs
are enumerated in `remaining_SLD_pairs.json` and remain open; there is no full
source/SLD seal or newly invented name, macro, helper, asm, volatile or flag.

Production and all prior scratch receipts were untouched. Parent must
revalidate the combined actual file after its separately owned Reset patch.
