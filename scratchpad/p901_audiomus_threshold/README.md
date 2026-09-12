# P901 AudioMus_Threshold: remove the unproved pointer and source labels

2026-09-12. Actual source applied; no invented replacement name, helper, macro,
asm/volatile device, flag change or compiler-output rewriting.

The native block19ee87..19ee90, VA80079F58..80079FD4, is one empty root scope.
It has no locals or source-label records. The old reconstruction declared
`music` and four goto labels; a previous direct-substitution failure had been
treated as a reason to retain the pointer. That failed form is not proof that
an original pointer variable existed.

## Verified result

- `music` and its generic SYM-CODEGEN-CARRIER exemption removed, without a
  new identifier. All four reconstructed labels are also removed.
- Plain separate early-return guards read AudioMus_g directly. The compiler
  naturally keeps its shared address in a0 and generates both backward return
  branches, exactly as retail.
- **33/33 raw words**, including the one native GP reference, are exact.
- Native SLD **0 merges /4 splits ->0/0**. One exact native empty scope;
  zero extra emitted local or source-label declarations.
- **23/23 functions PASS**, all **206 branches exact**. Whole actual normal
  object literally unchanged from the P900 checkpoint. All22 neighbors retain
  their complete local/type/home, source-label PC, scope, line partition and
  debug instruction graph.

`landed_verified.json` checks the actual source/include graph and object;
`landed_inspection.json` contains every instruction-line group and neighboring
scope; `landed_raw_target_receipt.json` verifies raw bytes. The full campaign
regression is under ../p901_checkpoint.

## The paired source path matters

| Stage | Instructions/diff | Branch result | Native SLD |
|---|---|---|---|
| before |33/PASS |exact |0/4 |
| natural_guards |33/4 |outstanding-request edge +8 instead of-15 |not accepted |
| split_guards |33/PASS |exact |16/0; initial null/header tests wrongly grouped |
| separate_null |33/PASS |exact |0/0 |
| candidate/landed |33/PASS |exact |0/0 |

The first rewrite combined the final request/time guards and changed the
return join. Splitting them restores byte code. Then separating the initial
null and header guards restores native148 and150 as distinct source statements.
All intermediate sources and outputs remain frozen. No candidate with a new
SLD conflict was landed. The old measured direct-substitution failure is not
claimed reproduced here; this is a different structured source path.

Native SYM: C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt,
function start19ee36, records19ee87..19ee99. Split M2C:
C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_80079F58.c. The independent M2C
body agrees on the guards, field offsets, zero/threshold results and call-free
control flow. Raw assembly is the byte/branch authority.

## Verification qualifications

Later unchanged music functions contain source labels whose compiler IDs
renumber when Threshold's old labels disappear. The comparison resolves each
SCL6 label to its exact native PC and preserves its name/type/storage; it never
ignores source-label identity or changes compiler output. Complete neighboring
debug graphs remain equal after consistent compiler-ID comparison. GAS-L only
retains existing anchors; assembly hashes and all payloads are unchanged.

Private-to-actual normal objects differ only by the exact checked STT_FILE
path. Actual-to-P900 normal objects are literally identical. Original macro/
token spelling and physical line numbers are not uniquely established by
equal statement partitions. The project-wide goal remains open.

Hashes:

- actual source before: cfb0a115c53537d2e38a0aa65397e71e0f64e80b1d30f0abbcc3ad1c5f45bdb6
- actual source after: ece741259dcb13d2f7f320d8e3f0464d42397061121b16dd9d9bbabf07635607
- actual normal object: f6e556413410b4b0d3879ed8ae420b67df328f82cdf1e37add8e3ae6eee4a87b
- raw33-word target: 5ceaed51976e88a17fa115e1bc27cacb7b13d5fe12055dbb9a13b7b35956dc59
