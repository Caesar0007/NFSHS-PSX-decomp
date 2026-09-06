# P875 public-header prototype review inventory

This is an explicit remaining-work queue, not proof that every row can be renamed.
The inventory covers one-line, free-function-shaped prototypes in headers with a
paired .cpp. It does not validate full signatures, namespace/C-linkage context,
macro expansion, overloads or all indirect include paths. Member ABI bridges and
multi-line declarations need a separate pass. No source was changed by this scan.

Candidates: **0** across **0 headers**.

P875 disposition of the historical 1,130-row / 79-header queue: 1,119 native EXT prototypes corrected and 11 proven native STAT prototypes removed from the public API. Independent typed-reference probes and native/source/export receipts accompany the repairs. A further 122 redundant non-member declarations were removed only after verifying their real class APIs. See the P875 section of ORIGINAL_SOURCE_NAME_BACKLOG_20260903.md for evidence and limits. The earlier P872/P874 corrections are also preserved. Zero rows below is closure of this scan shape only, not a claim of complete public-header or project source restoration.

| Header:line | Encoded identifier | Source-name candidate | Evidence class | Literal include hits |
| --- | --- | --- | --- | --- |
