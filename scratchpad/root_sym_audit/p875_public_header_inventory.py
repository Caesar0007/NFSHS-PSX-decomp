"""Read-only P875 snapshot of the unchanged, deliberately limited P874 scan.

Only this new report is generated. No source, oracle or historical report is
rewritten. A zero count does not cover members, multiline declarations, macros,
full signatures, original include structure or the remaining local/SLD backlog.
"""
from pathlib import Path
import p874_public_header_inventory as inventory


if __name__ == "__main__":
    inventory.main(
        out=Path(__file__).with_name("public_header_prototype_queue_p875_20260906.md"),
        phase="P875",
        completion_note=(
            "P875 disposition of the historical 1,130-row / 79-header queue: "
            "1,119 native EXT prototypes corrected and 11 proven native STAT "
            "prototypes removed from the public API. Independent typed-reference "
            "probes and native/source/export receipts accompany the repairs. "
            "A further 122 redundant non-member declarations were removed only "
            "after verifying their real class APIs. See the P875 section of "
            "ORIGINAL_SOURCE_NAME_BACKLOG_20260903.md for evidence and limits. "
            "The earlier P872/P874 corrections are also preserved. "
            "Zero rows below is closure of this scan shape only, not a claim "
            "of complete public-header or project source restoration."
        ),
    )
