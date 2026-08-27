#!/usr/bin/env python3
"""Compare canonical named type sets between retail SYM object owners."""

from __future__ import annotations

from collections import defaultdict
import argparse

import audit_sym_canonical_types as canon


def owner_stem(owner: str) -> str:
    normalized = owner.replace("\\", "/")
    if normalized.endswith(")") and "(" in normalized:
        normalized = normalized.rsplit("(", 1)[1][:-1]
    return normalized.rsplit("/", 1)[-1].rsplit(".", 1)[0].casefold()


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("target", help="retail owner stem, for example hud")
    parser.add_argument("--show", default="", help="candidate owner stem whose delta to print")
    args = parser.parse_args()

    by_owner = defaultdict(list)
    for item in canon.parse_retail(canon.RETAIL_LEDGER):
        by_owner[item.owner].append(item)

    owners = defaultdict(list)
    for owner in by_owner:
        owners[owner_stem(owner)].append(owner)
    target_owners = owners[args.target.casefold()]
    if len(target_owners) != 1:
        raise SystemExit(f"target is ambiguous or absent: {target_owners}")
    target_owner = target_owners[0]

    def named(owner: str):
        blocks, _, issues = canon.blocks(by_owner[owner])
        if issues:
            raise RuntimeError((owner, issues))
        return {
            block.semantic(): block.name
            for block in blocks if not block.name.startswith("._")
        }

    target = named(target_owner)
    rows = []
    for stem, candidates in owners.items():
        if len(candidates) != 1 or candidates[0] == target_owner:
            continue
        candidate_owner = candidates[0]
        candidate = named(candidate_owner)
        overlap = set(candidate) & set(target)
        extras = set(candidate) - set(target)
        rows.append((len(overlap), len(extras), stem, candidate_owner, candidate))

    print(f"target: {target_owner} named={len(target)}")
    print("largest canonical overlaps (overlap/extras/candidate-total):")
    for overlap, extras, stem, owner, candidate in sorted(rows, reverse=True)[:30]:
        subset = " SUBSET" if not extras else ""
        print(f"  {stem:24s} {overlap:3d}/{extras:3d}/{len(candidate):3d}{subset}  {owner}")
    print("\nstrict subsets:")
    for overlap, extras, stem, owner, candidate in sorted(rows, reverse=True):
        if not extras:
            print(f"  {stem:24s} {overlap:3d}/{len(candidate):3d}  {owner}")

    if args.show:
        chosen = [row for row in rows if row[2] == args.show.casefold()]
        if len(chosen) != 1:
            raise SystemExit(f"candidate is ambiguous or absent: {chosen}")
        candidate = chosen[0][4]
        print(f"\ntarget delta after {args.show}:")
        for semantic in sorted(set(target) - set(candidate), key=lambda item: target[item].casefold()):
            print(f"  {target[semantic]}")
        print(f"\ncandidate extras outside target:")
        for semantic in sorted(set(candidate) - set(target), key=lambda item: candidate[item].casefold()):
            print(f"  {candidate[semantic]}")


if __name__ == "__main__":
    main()
