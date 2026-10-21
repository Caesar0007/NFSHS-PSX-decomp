# Slice links: shortcuts and open areas on NFS3 / NFS2 tracks in NFS4

This note explains why cars glitch on converted NFS3 tracks where two roads share an open area or a shortcut, how NFS3 handles those places, and how to add the same feature to the NFS4 decomp (`C:\Tools\ClaudeAI\recon`). The retail asm version is `mod_test/code/NFS_SliceLinks.asm` (flag `patch_NFS_EXE_sliceLinks`); this document is about the decomp source and does not depend on retail addresses.

Status (2026-10-20): researched in both games' code. The retail asm version passes a simulation that runs the real retail code on the converted track. It has not been tested in game yet. The converter option `slice_links` is off by default.

---

## 1. The problem

Example: NFS3 Country Woods (`ZZZTR00B.TRK`), converted to NFS4 track 16 (`ExampleFiles/nfs3/Track_NFS3_CountryWoods`).

- The road loops back on itself: slices **659-667** (chunks 82/83) and slices **772-764** (chunks 95/96) run side by side, about **88 m** apart.
- Between them is one open field. Each leg's drivable rows (sim slices) reach far to the right of its center line:

  | Leg | Slices | Drivable rows reach (right of center) |
  |---|---|---|
  | A | 657-668 | 38.7 - 44.7 m |
  | B | 763-774 | 48.5 - 53.1 m |

  38.7-44.7 + 48.5-53.1 is about the 88 m between the legs: the two legs' rows **meet at a seam** in the middle of the field. They do not overlap and leave no gap.
- In NFS4 a car driving across the field from leg A onto leg B is still tracked on leg A after the seam. The game finds no quad under it, so it gets the off-edge treatment: pinned to leg A's edge quad (`offEdge` 2), with leg A's surface, height and normal, while it is driving on leg B. That is the "physics issue when crossing the chunks".

Measured with the real retail code (simulation, `mod_test/tools/slicelinks_sim.py`), a point moving from 20 m right of slice 662 to 20 m right of slice 769:

| Distance from slice 662 | Original NFS4 | With slice links |
|---|---|---|
| up to ~40 m (leg A's rows) | slice 662, offEdge 0 | slice 662, offEdge 0 |
| 42 m (just past the seam) | slice 662, **offEdge 2** | **slice 769**, offEdge 0 |
| 50-70 m (on leg B's road) | slice 661/662, **offEdge 2** | slice 769, offEdge 0 |

The reverse direction behaves the same.

---

## 2. Why NFS4 cannot follow the car (decomp, `game/common/bworldSm.cpp`)

The car's position on the track is a `BWorldSm_Pos` (slice, quad, sim slice / sim quad pointers, offEdge ...). Every frame `BWorldSm_FindClosestQuadRez(pt, slicePos, 1)` updates it:

1. **Fast path:** if the point is still inside the current quad (`PT_IN_QUAD`), nothing changes.
2. **`FindClosestQuad`:**
   1. `BWorldSm_FindClosestSlice`:
      - If the point is more than `0x800000` (128 m) from the current slice center, `FindAbsClosestSliceCrude` checks every 8th slice of the whole track.
      - Otherwise only `RawFindClosestSlice` runs. It walks from the current slice to the neighbouring slice (+1 / -1) while that one is closer in XZ. That is a local minimum search along the road. It never jumps to another leg of the track.
   2. `RawFindClosestQuad` looks for the quad containing the point in that slice, then in slices +1, -1, +2, -2 (`sliceOffs` table, `gMaxFindQuadSliceIterations` = 5).
   3. If no quad was found: `offEdge` (1 left, 2 right) keeps the car on the first or last quad of the found slice, and the point is pulled toward the slice center (`corrPt`, 1/32 per step, up to 10 steps) to find a quad.

In the field the car stays on leg A in step 2.1, because leg A's slices are the local minimum and leg B is less than 128 m away. Step 2.2 only checks leg A's slices, and step 2.3 then pins the car to leg A's edge.

`Trk_NewSimSlice` (5 bytes: `stripIndex, quadCount, simquadIndex, simquadCount, simquadStartIndex`) and `Trk_NewSlice` (32 bytes, fully used) have no room for anything else. NFS4 has no data saying "this road borders that other road".

---

## 3. How NFS3 does it

### 3.1 The data: TRK XBID 6

Each NFS3 TRK block (= one NFS4 chunk, 8 slices) has an XBID 6 extrablock with 8 records of 8 bytes, one per slice (`nfs3lib.py`):

```
u16 firstPolygon   first full-detail polygon of the slice's drivable row
u8  count          polygons in the row (left to right)
u8  flag
i16 link1          slice index of another road this row borders, -1 = none
i16 link2          a second one, -1 = none
```

Earlier notes described the last 4 bytes as "4 x FF" padding. They are only FF where there is no link. On the tracks with links, they hold slice indexes. The links come in mutual runs that mirror each other:

```
Country Woods (00B):  659 -> 772, 660 -> 771, ... 667 -> 764     (link2)
                      764 -> 667, 765 -> 666, ... 772 -> 659     (link2)
                      450 -> 517 ... 517 -> 450 (a hairpin; 483 / 484 have none)
Redrock Ridge (01A):  608 -> 640, 609 -> 639, ...                (link1, the dirt shortcut across the hairpin)
Atlantica (02A):      76 -> 32 (link1) and 76 -> 124 (link2): one slice can border two roads
```

| Track | Links | | Track | Links |
|---|---|---|---|---|
| NFS3 00A Hometown | 0 | | NFS3 04A Rocky Pass | 6 |
| NFS3 00B Country Woods | 84 | | NFS3 04B The Summit | 30 |
| NFS3 01A Redrock Ridge | 14 | | NFS3 05A-08A | 0 |
| NFS3 01B Lost Canyons | 6 | | NFS2 ZTR03 | 18 |
| NFS3 02A / 02B | 13 / 29 | | NFS2 ZTR05 | 20 |
| NFS3 03A / 03B | 8 / 4 | | NFS2 ZTR08 | 47 |

NFS2 TRKs use the same 8-byte rows (their links were checked as the same kind of mutual runs; NFS2's own use of them was not traced). EA's NFS4-era TRK export (`kindiakpark_trk/track12h.trk`) has none.

### 3.2 The code: NFS3's FindClosestQuad (`SLES_011.54`, PAL)

| Address | Function | Same as NFS4 |
|---|---|---|
| 0x800686EC | crude search, every 8th slice | `FindAbsClosestSliceCrude` |
| 0x8006879C | FindClosestSlice: **no 128 m check**, just the walk | `BWorldSm_FindClosestSlice` without the crude call |
| 0x8006880C | slice walk (`>> 9` squared XZ distances) | `RawFindClosestSlice` |
| 0x80068F48 | quad search, returns found | `RawFindClosestQuad` |
| 0x80068E68 | set the sim slice pointer | `BWorld_SetSimSlice` |
| 0x80066000 | point-to-slice distance | `Math_DistXZ` style |
| **0x80069E14** | **FindClosestQuad, with the link fallback** | `FindClosestQuad` |
| 0x800F7414 | offsets {0, 1, -2, ...}, 3 used | - |

NFS3's slice position keeps the slice at +0, the sim slice record pointer at +0x10 (the XBID 6 record: +0 first polygon, +2 count, **+4 link1, +6 link2**), the offEdge-like field at +0x6C, and the whole struct is 0x7C bytes.

Reconstructed from the disassembly:

```c
int FindClosestQuad(coorddef *pt, SlicePos *pos)
{
    int prevSlice = pos->slice;
    FindClosestSlice(pt, pos);
    int walkedSlice = pos->slice;
    if (RawFindClosestQuad(pt, pos))
        goto done;

    /* the link fallback: the previous slice, then +1, then -1 (offsets 0, +1, -2, applied in turn) */
    pos->slice = prevSlice;
    for (int i = 0; i < 3; i++) {
        step pos->slice by offs[i] (wrapping around the track);
        SetSimSlice(pos);
        short l1 = pos->simSlice->link1, l2 = pos->simSlice->link2;
        if (l1 == -1 && l2 == -1)
            continue;
        saved = *pos;                                   /* 0x7C bytes, to 0x80126FD8 */
        unsigned d1 = l1 != -1 ? Dist(&slices[l1], pt) : 0xFFFFFFFF;
        unsigned d2 = l2 != -1 ? Dist(&slices[l2], pt) : 0xFFFFFFFF;
        pos->slice = d1 < d2 ? l1 : l2;                 /* the closer link */
        if (RawFindClosestQuad(pt, pos)) {
            debug print;
            goto done;                                  /* the car is now on the other road */
        }
        *pos = saved;
        pos->simSlice = NULL;
    }

    /* no link helped: off-edge handling on the walked slice, as NFS4 */
    if (pos->offEdge) { pos->slice = walkedSlice; edge quad ... }
    if (Dist(&slices[pos->slice], pt) > 0x12544) {     /* NFS3's crude search lives here */
        debug print; FindAbsClosestSliceCrude(pt, pos); RawFindClosestSlice(pt, pos); RawFindClosestQuad(pt, pos);
    }
    pull the point toward the slice center until a quad is found (>> 5 per step);
done:
    pos->sliceChanged = pos->slice != prevSlice; ...
}
```

So NFS3 does not search the whole track for the car. Its slice walk is as local as NFS4's, but the track data tells it where the other road is.

---

## 4. Track data for NFS4: GRP group 0x10

NFS4 has no field for the links, so the converter writes them as an extra persistent group:

```
persistent group 0x21
  0x02 materials
  0x08 object definitions
  0x07 animated instances
  0x0F slices
  0x10 slice links     <- new, only when the track has links
  0x24 midground instances
  0x26 object definition sizes

group 0x10: u32 type 0x10, u32 size, u32 0xCDCDCDCD, u32 count
            count x (i16 slice, i16 linkedSlice)     sorted by slice; a slice with two links has two records
```

- **The original game ignores it.** `Track_InitPersistentData` switches on the child's type and has no `case 0x10`, so the group is never copied into `Track_mem`. A track with links loads and drives in an unpatched game exactly as one without them. The file is 4 x count + 16 bytes bigger (Country Woods: 352 bytes), and it only adds to the peak memory while loading.
- **With the patch** the group is copied into `Track_mem` (`CreateLiteGroup`: u32 count + the records), 4 x count + 4 bytes (Country Woods: 340 bytes resident).
- **Studio:**
  - `nfs3lib.TrkFile.slice_links(slice_count)` reads the links from XBID 6.
  - `grplib.SLICE_LINKS_TYPE` = 0x10, and `GrpFile.slice_links` is a list of (slice, link) written back by `store()`. Setting it on a GRP without the group inserts the group after 0x0F. `grplib.load_memory` counts the group.
  - `nfs3convert` option `slice_links` (off by default; `--set slice_links=1` on the command line) writes it. The links are NFS3's original data; nothing is computed.

---

## 5. Adding it to the decomp

The changes are in two translation units: `game/common/bworldSm.cpp` (the search) and `game/common/track.cpp` (the loader). Keep them behind a compile switch so the default build still matches retail byte for byte:

```c
/* e.g. in a shared config header, or on the compiler command line */
#define NFS4_SLICE_LINKS 1
```

### 5.1 The type and the global (`bworldSm.cpp`, `bworldSm_types.h`)

```c
/* bworldSm_types.h */
struct BWorldSm_SliceLink {
    short slice;      /* a slice whose drivable row borders another road */
    short link;       /* the bordering slice on that road */
};
```

```c
/* bworldSm.cpp, with the other bworldSm.obj globals */
#if NFS4_SLICE_LINKS
Group *BWorldSm_sliceLinks;   /* lite group: m_num_elements x BWorldSm_SliceLink, or 0 */
#endif
```

### 5.2 Setting it from the loader

Add a setter in `bworldSm.cpp`. The loader then does not touch bworldSm's globals directly; this follows the existing `BWorldSm_Init(Group *)` pattern:

```c
#if NFS4_SLICE_LINKS
/* ---- BWorldSm_SetSliceLinks: the track's slice links (persistent group 0x10), 0 = none ---- */
void BWorldSm_SetSliceLinks(Group *links)
{
  BWorldSm_sliceLinks = links;
  return;
}
#endif
```

Declare it in `bworldsm.h` and in `track_externs.h` (next to `extern void BWorldSm_Init(Group *);`):

```c
extern void BWorldSm_SetSliceLinks(Group *);
```

In `track.cpp`, `Track_InitPersistentData`, clear it before the loop and add the case. Clear it **before** the loop, not in `BWorldSm_Init`: the persistent children come in file order, so a group 0x10 placed before 0x0F would otherwise be wiped. The retail asm puts the clear where the unused `perGroup->LocateGroupType(8,0);` call is; in C, just add a line.

```c
  perGroup->LocateGroupType(8,0);
  count = perGroup->m_num_elements;
#if NFS4_SLICE_LINKS
  BWorldSm_SetSliceLinks((Group *)0x0);   /* tracks without links */
#endif

  {
    int i = 0;

    while (i < count) {
      switch (persistentGroups[i]->m_type) {
      ...
      case 0xf:
        BWorldSm_Init(persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem));
        break;
#if NFS4_SLICE_LINKS
      case 0x10:   /* slice links (nfs3convert, NFS3 / NFS2 TRK XBID 6) */
        BWorldSm_SetSliceLinks(
             persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem));
        break;
#endif
      ...
```

`CreateLiteGroup` copies the whole group (`m_length - 0xc` bytes: the count and the records) into `Track_mem`, which `ResizeToFit` keeps, so the pointer is valid until the next track load. Nothing needs freeing: `Track_mem` goes away as a whole.

### 5.3 The search (`bworldSm.cpp`)

A helper, placed before `FindClosestQuad`:

```c
#if NFS4_SLICE_LINKS
/* XZ distance as RawFindClosestSlice measures it (1/512 world units, squared) */
static inline int SliceLink_Dist(int slice,coorddef *pt)
{
  Trk_NewSlice *s = BWorldSm_slices + slice;
  int dx = (pt->x - s->center[0]) >> 9;
  int dz = (pt->z - s->center[2]) >> 9;
  return dx * dx + dz * dz;
}

/* ---- TrySliceLinks ----
 * NFS3's FindClosestQuad fallback (SLES_011.54 0x80069E14): after RawFindClosestQuad found no
 * quad, look at the links of fromSlice and its neighbours (-1 .. +1), take the link whose slice
 * center is the closest to pt and search the quads there.
 * 1: found, slicePos is on the linked road. 0: not, slicePos is exactly as it was. */
static int TrySliceLinks(coorddef *pt,BWorldSm_Pos *slicePos,int fromSlice)
{
  BWorldSm_SliceLink *links;
  BWorldSm_Pos saved;
  int numLinks;
  int bestLink;
  int bestDist;
  int i;

  if (BWorldSm_sliceLinks == (Group *)0x0) {
    return 0;
  }
  links = (BWorldSm_SliceLink *)BWorldSm_sliceLinks->GetData();
  numLinks = BWorldSm_sliceLinks->GetNumElements();
  bestLink = -1;
  bestDist = 0x7fffffff;
  for (i = 0; i < numLinks; i = i + 1) {
    int diff = links[i].slice - fromSlice;

    /* -1 .. +1, also across the start / finish line of a circuit */
    if (diff > gNumSlices / 2) diff -= gNumSlices;
    if (diff < -(gNumSlices / 2)) diff += gNumSlices;
    if ((diff < -1) || (1 < diff)) continue;
    if ((links[i].link < 0) || (gNumSlices <= links[i].link)) continue;

    int dist = SliceLink_Dist(links[i].link,pt);
    if (dist < bestDist) {
      bestDist = dist;
      bestLink = links[i].link;
    }
  }
  if (bestLink < 0) {
    return 0;
  }
  saved = *slicePos;
  slicePos->slice = (short)bestLink;
  if (RawFindClosestQuad(pt,slicePos) != 0) {
    return 1;
  }
  *slicePos = saved;   /* the failed search changed quad, offEdge, simSlice, strip ... */
  return 0;
}
#endif
```

The hook in `FindClosestQuad`. The new lines go right after the first failed `RawFindClosestQuad`, before the off-edge handling:

```c
int FindClosestQuad(coorddef *pt,BWorldSm_Pos *slicePos)
{
  ...
  startSlice = slicePos->slice;
  startQuad = (int)(signed char)slicePos->quad;
  BWorldSm_FindClosestSlice(pt,slicePos);
  foundSlice = slicePos->slice;
  if (RawFindClosestQuad(pt,slicePos) == 0
#if NFS4_SLICE_LINKS
      && TrySliceLinks(pt,slicePos,startSlice) == 0
#endif
     ) {
    if (*(signed char *)&slicePos->offEdge != 0) {
      ... unchanged ...
    }
    ... unchanged corrPt loop ...
  }
  sliceChanged = startSlice != slicePos->slice;
  ...
}
```

On success the function falls through to the common tail: `sliceChanged` / `quadChanged` are set, and the return value tells the caller the slice changed, as for any other slice change. From the next frame on, `RawFindClosestSlice` walks from the linked slice, so the car is tracked along the new road normally.

### 5.4 Notes on the choices

- **`startSlice`, not `foundSlice`.** NFS3 uses the slice from before this frame's walk (its `prevSlice`). In the field both are the same or neighbours; using `startSlice` keeps NFS3's behaviour.
- **One attempt, not three.** NFS3 tries up to three candidate slices (previous, +1, -1) and calls the quad search for each one that has links. The version above collects the links of all three, picks the closest one and searches once. `RawFindClosestQuad` also tries the linked slice +-1 and +-2. Neighbouring links point to neighbouring slices (660 -> 771, 661 -> 770), so the result is the same, with fewer searches.
- **Two links on one slice** (Atlantica 76 -> 32 and 124): both are candidates, and the closer one wins, as in NFS3.
- **Wrap-around.** The decomp version wraps the -1 .. +1 test around the start / finish line. The retail asm (`sltiu (slice - from + 1) < 3`) does not, which only matters for a link within one slice of slice 0 / the last slice (none in the known tracks).
- **Struct copy.** `saved = *slicePos;` is 0x84 bytes (`BWorldSm_Pos`). On PSX GCC a struct assignment may call `memcpy` / a block move. That is fine here, because it only runs when no quad was found and a link was nearby.
- **When it costs time.** The links are read only when the normal search failed (the car is off its road's rows). A track without the group returns at the first `if`. With the group, the scan is `numLinks` iterations (84 on Country Woods) of a compare. The extra `RawFindClosestQuad` only runs when there is a candidate link.
- **Who benefits.** Every caller of `BWorldSm_FindClosestQuadRez(..., 1)`: the car physics (`Newton_FindClosestQuad`), the camera (`camera.cpp`), the view (`bworld.cpp`) and the cops' tests (`aih_basiccop.cpp`). The AI's own slice tracking (`ai.cpp`, `BWorldSm_FindClosestSlice` only) is unchanged. The AI follows the racing line and does not take shortcuts.
- **The 128 m crude search stays.** It is still the last resort for a car far from its slice (respawns, a car thrown off the track).

### 5.5 What must stay the same

- Original NFS4 tracks have no group 0x10. `BWorldSm_sliceLinks` stays 0 and `TrySliceLinks` returns at once. With `NFS4_SLICE_LINKS 0` the build is unchanged.
- The track's geometry, sim slices, sim quads and slices are untouched: the feature only adds the group.
- Mirror / reverse races: `gNumSlices` and the slice numbering are the same in both directions, so the links need no change.

---

## 6. Testing

1. **Data:** convert with the option on. `grplib.GrpFile.load(...).slice_links` should list the pairs (Country Woods: 84, starting `(450, 517)`).
2. **Logic without the game:** `mod_test/tools/slicelinks_sim.py <NFS4.EXE> 1 [fromSlice toSlice fromMeters toMeters]` runs a built EXE's `FindClosestQuad` (retail addresses; for the decomp, adapt the addresses from the debug build's `NFS4.MAP`) on ZTR16.GRP and prints the slice / offEdge along the path. Expected with the feature: the slice changes legs at the seam (`662 -> 769` at about 42 m), `offEdge 0` throughout. Without it: stays on 661/662 with `offEdge 2`.
3. **In game** (Country Woods in slot 16):
   - Drive slowly across the field from chunks 82/83 to chunks 95/96, then back.
   - Expected: no snapping or bouncing at the seam, the car keeps its speed, and the HUD position / lap progress follows the road you are on.
   - Also check Redrock Ridge's dirt shortcut (slices 608-640), the case that was given up as an engine limit in September.
4. **Regression:** an original NFS4 track should play exactly as before (no group, no change).

---

## 7. File map

| What | Where |
|---|---|
| Retail asm patch | `mod_test/code/NFS_SliceLinks.asm`, flag `patch_NFS_EXE_sliceLinks` in `patches.inc` (0 = off); included by `MAIN.asm` after `NFS_ExTrackSlots.asm` |
| Converter option | `Scripts/nfs3convert.py`, `OPTIONS` key `slice_links` (default off) |
| TRK reader | `Scripts/nfs3lib.py`, `TrkFile.slice_links`, XBID 6 notes in the module docstring |
| GRP group | `Scripts/grplib.py`, `SLICE_LINKS_TYPE`, `GrpFile.slice_links`, group 0x10 in the docstring |
| Simulation | `mod_test/tools/slicelinks_sim.py` |
| Decomp functions | `recon/game/common/bworldSm.cpp` (`BWorldSm_FindClosestSlice`, `RawFindClosestSlice`, `RawFindClosestQuad`, `FindClosestQuad`), `recon/game/common/track.cpp` (`Track_InitPersistentData`), `recon/game/common/group.cpp` (`CreateLiteGroup`) |
| NFS3 functions | `SLES_011.54`: 0x80069E14 FindClosestQuad with links, 0x8006879C / 0x8006880C slice walk, 0x80068F48 quad search, table 0x800F7414 |
