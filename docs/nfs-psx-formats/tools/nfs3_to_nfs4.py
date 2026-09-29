#!/usr/bin/env python3
"""Convert one NFS3 PSX track layout into an NFS4 PSX GRP track slot.

This converter follows the retail-loader formats documented in:
  formats/NFS3_TRACK_FILES.md
  formats/NFS4_TRACK_GRP.md

It intentionally does not use the older LibOpenNFS-based converter model.  In
particular, there is no X-axis flip, no custom UV-table group and no invented
collision raster.  NFS3 TRK/COL records are translated through their direct
NFS4 lineage.

Review 2026-09-29 (against the loader/renderer specs): vertex colours split as the
NFS3 renderers do (r = bits 10-14, << 3), flare types mapped onto NFS4 `Flare_gType`
kinds, strip vertex rows shared between slices (the old copy-per-strip doubled the
vertex count and merged ~9 % of 00A's road quads), visibility rows trimmed to the 32
nearest neighbours, light table trimmed to the used colours.

Example:
  python tools/nfs3_to_nfs4.py C:/Temp/nfs3_disc 00A output --target 00
"""

from __future__ import annotations

import argparse
import collections
import re
import shutil
import struct
import sys
from dataclasses import dataclass
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import nfs3_trk as N3
import nfs4_grp as N4


DUMMY = 0xCDCDCDCD


def align4(value: int) -> int:
    return (value + 3) & ~3


def clamp16(value: int) -> int:
    return max(-32768, min(32767, value))


def as_signed16(value: int) -> int:
    return value if value < 0x8000 else value - 0x10000


def group(group_type: int, payload: bytes = b"", count: int = 1) -> bytes:
    raw_length = 16 + len(payload)
    length = align4(raw_length)
    return (
        struct.pack("<iiIi", group_type, length, DUMMY, count)
        + payload
        + bytes(length - raw_length)
    )


def container(group_type: int, children: list[bytes]) -> bytes:
    return group(group_type, b"".join(children), len(children))


def rgb555(value: int) -> tuple[int, int, int]:
    """NFS3 vertex colour word -> CVECTOR r, g, b, exactly as the NFS3 renderers split it
    (`func_800B16D4`, `func_800AFB5C`: bits 10-14 -> r, 5-9 -> g, 0-4 -> b, each << 3,
    loaded into the GTE as {r, g, b}). Retail NFS4 light tables are multiples of 8 too."""
    return ((value >> 10) & 31) << 3, ((value >> 5) & 31) << 3, (value & 31) << 3


# NFS3 flare type (17-entry colour/size table at 0x8010B250) -> NFS4 `Flare_gType` kind
# (flare.cpp, 34 entries; retail tracks use 25, 29, 31, 32). Chosen by halo colour among
# the track-style kinds (flags 8/12, non-zero scale): 1 orange streetlight (168,144,80,
# size 3264) -> 27 (144,104,32, scale 3594); 5/6 red -> 29; 7 green -> 32 teal;
# 0xC/0xF blue -> 33; 2/4/0x10 yellow -> 28; 0/3 grey -> 30 white; others -> 25.
FLARE_KIND = {0: 30, 1: 27, 2: 28, 3: 30, 4: 28, 5: 29, 6: 29, 7: 32, 0xC: 33, 0xF: 33, 0x10: 28}

# NFS4 keeps 36 visibility entries per chunk but reads and writes the rows at a 64-byte
# stride (Track_Init `i << 6`), so entries 32-35 are overwritten by the next chunk's row.
VIS_LIMIT = 32


def build_palette(colors: collections.Counter[int]) -> tuple[bytes, dict[int, int]]:
    """Build an at-most-256-entry weighted median-cut palette."""
    entries = [(value, count, rgb555(value)) for value, count in colors.items()]
    if not entries:
        entries = [(0, 1, (0, 0, 0))]

    boxes = [entries]
    while len(boxes) < 256:
        candidates = []
        for index, box in enumerate(boxes):
            if len(box) < 2:
                continue
            ranges = [max(x[2][c] for x in box) - min(x[2][c] for x in box) for c in range(3)]
            candidates.append((max(ranges) * sum(x[1] for x in box), index, ranges.index(max(ranges))))
        if not candidates:
            break
        _score, index, channel = max(candidates)
        box = sorted(boxes.pop(index), key=lambda x: x[2][channel])
        half = sum(x[1] for x in box) / 2
        running = 0
        split = 1
        for split, item in enumerate(box, 1):
            running += item[1]
            if running >= half:
                break
        split = min(max(1, split), len(box) - 1)
        boxes.extend((box[:split], box[split:]))

    palette = []
    for box in boxes:
        weight = sum(x[1] for x in box)
        palette.append(tuple(sum(x[2][c] * x[1] for x in box) // weight for c in range(3)))

    mapping = {}
    for value, _count, rgb in entries:
        mapping[value] = min(
            range(len(palette)),
            key=lambda i: sum((rgb[c] - palette[i][c]) ** 2 for c in range(3)),
        )
    # No padding: `Chunk_numLight` is the payload size / 4 (retail 20-212 entries) and the
    # spike-belt colour search scans every entry, so only real colours are emitted.
    return b"".join(bytes((r, g, b, 0)) for r, g, b in palette), mapping


@dataclass
class StripRun:
    first_quad: int
    materials: list[int]
    surfaces: list[int]
    top: tuple[int, ...]
    bottom: tuple[int, ...]

    @property
    def quad_count(self) -> int:
        return len(self.materials)


@dataclass
class SourceObjectDef:
    data: bytes
    offset: int
    vertex_count: int
    quad_count: int


@dataclass
class ObjectCatalog:
    definitions: list[SourceObjectDef]
    chunk_bases: dict[int, int]
    persistent_base: int


def parse_object_definitions(data: bytes, block_offset: int, count: int) -> list[SourceObjectDef]:
    definitions = []
    cursor = block_offset + 8
    for index in range(count):
        size, vertex_count, quad_count = struct.unpack_from("<IHH", data, cursor)
        minimum = 8 + 8 * vertex_count + 6 * quad_count
        if size < minimum or cursor + size > len(data):
            raise ValueError(f"object definition {index}: invalid size {size}")
        definitions.append(SourceObjectDef(data, cursor, vertex_count, quad_count))
        cursor += align4(size)
    return definitions


def collect_object_catalog(
    trk: N3.Trk,
    chunk_records: list[tuple[int, int, int, int, list[tuple[int, int, int, int]]]],
    col_data: bytes,
    collections_: list[tuple[int, int, int, int]],
) -> ObjectCatalog:
    definitions = []
    chunk_bases = {}
    persistent = next((entry for entry in collections_ if entry[2] == 8), None)
    persistent_base = 0
    if persistent is not None:
        persistent_base = len(definitions)
        definitions.extend(parse_object_definitions(col_data, persistent[0], persistent[3]))
    for chunk_index, chunk, _size1, _size2, blocks in chunk_records:
        by = block_map(blocks)
        chunk_bases[chunk_index] = len(definitions)
        if 8 in by:
            offset, _length, count = by[8]
            definitions.extend(parse_object_definitions(trk.d, chunk + offset, count))
    return ObjectCatalog(definitions, chunk_bases, persistent_base)


def object_colors(definitions: list[SourceObjectDef]) -> collections.Counter[int]:
    colors: collections.Counter[int] = collections.Counter()
    for definition in definitions:
        vertices = definition.offset + 8
        for index in range(definition.vertex_count):
            colors[struct.unpack_from("<H", definition.data, vertices + 8 * index + 6)[0]] += 1
    return colors


def convert_object_definitions(
    definitions: list[SourceObjectDef], palette_map: dict[int, int], material_count: int
) -> tuple[bytes, bytes]:
    encoded = []
    for index, definition in enumerate(definitions):
        if definition.vertex_count > 255 or definition.quad_count > 255:
            raise ValueError(f"object definition {index}: NFS4 u8 count overflow")
        vertices = bytearray()
        source_vertices = definition.offset + 8
        for vertex in range(definition.vertex_count):
            x, y, z, color = struct.unpack_from("<hhhH", definition.data, source_vertices + 8 * vertex)
            vertices += struct.pack(
                "<hhhh", clamp16(x >> 2), clamp16(y >> 2), clamp16(z >> 2), palette_map[color]
            )
        quads = bytearray()
        source_quads = source_vertices + 8 * definition.vertex_count
        for quad_index in range(definition.quad_count):
            material, points = N3.quad(definition.data, source_quads + 6 * quad_index)
            if material >= material_count or max(points) >= definition.vertex_count:
                raise ValueError(f"object definition {index}: invalid quad {quad_index}")
            quads += struct.pack("<h4B", material, *points)
        record = struct.pack("<hBB", -1, definition.vertex_count, definition.quad_count) + vertices + quads
        encoded.append(record + bytes(align4(len(record)) - len(record)))
    offsets = [0]
    offsets.extend(len(record) for record in encoded[:-1])
    return b"".join(encoded), struct.pack("<%di" % len(offsets), *offsets)


def chain_for_run(quads: list[tuple[int, int, int, int]]) -> tuple[tuple[int, ...], tuple[int, ...]]:
    if len(quads) == 1:
        a, b, c, d = quads[0]
        return (b, a), (c, d)

    edges: list[tuple[int, int]] = []
    first = [v for v in quads[0] if v not in set(quads[1])]
    if len(first) != 2:
        raise ValueError("first quad has no distinct outer edge")
    edges.append(tuple(first))
    for left, right in zip(quads, quads[1:]):
        shared = []
        for value in left:
            if value in right and value not in shared:
                shared.append(value)
        if len(shared) != 2:
            raise ValueError("adjacent quads do not share one edge")
        edges.append(tuple(shared))
    last = [v for v in quads[-1] if v not in set(quads[-2])]
    if len(last) != 2:
        raise ValueError("last quad has no distinct outer edge")
    edges.append(tuple(last))

    top = bottom = None
    for edge0 in (edges[0], edges[0][::-1]):
        for edge1 in (edges[1], edges[1][::-1]):
            if quads[0] == (edge1[0], edge0[0], edge0[1], edge1[1]):
                top = [edge0[0], edge1[0]]
                bottom = [edge0[1], edge1[1]]
                break
        if top is not None:
            break
    if top is None or bottom is None:
        raise ValueError("first quad winding is not a strip winding")

    for index in range(1, len(quads)):
        for edge in (edges[index + 1], edges[index + 1][::-1]):
            if quads[index] == (edge[0], top[-1], bottom[-1], edge[1]):
                top.append(edge[0])
                bottom.append(edge[1])
                break
        else:
            raise ValueError("quad winding changes inside strip")
    return tuple(top), tuple(bottom)


def split_strip_runs(
    first_quad: int,
    quads: list[tuple[int, int, int, int]],
    materials: list[int],
    surfaces: list[int],
) -> list[StripRun]:
    """Split degenerate/disconnected NFS3 slice geometry into valid NFS4 strips."""
    result = []
    start = 0
    while start < len(quads):
        best = 1
        for end in range(start + 2, len(quads) + 1):
            try:
                chain_for_run(quads[start:end])
                best = end - start
            except ValueError:
                break
        top, bottom = chain_for_run(quads[start : start + best])
        result.append(
            StripRun(
                first_quad + start,
                materials[start : start + best],
                surfaces[start : start + best],
                top,
                bottom,
            )
        )
        start += best
    return result


def sample_boundaries(count: int, target: int) -> list[int]:
    return [(i * count) // target for i in range(target)] + [count]


def emit_strips(
    slice_runs: list[list[StripRun]],
    targets: list[int],
    vertices: list[tuple[int, int, int, int]],
    extra_vertices: set[int],
):
    """Emit one chunk's NFS4 strips; None when the vertex buffer would exceed 256.

    A strip is a band of quads between two vertex rows (`DrawW_StripDraw_High`:
    quad i = {top+i+1, top+i, bot+i, bot+i+1}). Rows are cached by their source-vertex
    run, so a slice's bottom row is reused as the next slice's top row instead of being
    copied: the chunk keeps the NFS3 vertex count instead of doubling it."""
    output_vertices: list[tuple[int, int, int, int]] = []
    source_to_output: dict[int, int] = {}
    rows: dict[tuple[int, ...], int] = {}
    strip_data = bytearray()
    strip_count = 0
    sim_quads = bytearray()
    sim_slices = bytearray()
    target_index = 0

    class Overflow(Exception):
        pass

    def emit_row(row: tuple[int, ...]) -> int:
        start = rows.get(row)
        if start is None:
            start = len(output_vertices)
            if start + len(row) > 256:
                raise Overflow
            for source_index in row:
                source_to_output.setdefault(source_index, len(output_vertices))
                output_vertices.append(vertices[source_index])
            rows[row] = start
        return start

    for runs in slice_runs:
        first_strip = strip_count
        first_sim_quad = len(sim_quads)
        converted_quad_count = 0
        for run in runs:
            target = targets[target_index]
            target_index += 1
            boundaries = sample_boundaries(run.quad_count, target)
            try:
                top_start = emit_row(tuple(run.top[i] for i in boundaries))
                bottom_start = emit_row(tuple(run.bottom[i] for i in boundaries))
            except Overflow:
                return None
            chosen_materials = []
            for left, right in zip(boundaries, boundaries[1:]):
                source_quad = min(run.quad_count - 1, (left + right - 1) // 2)
                chosen_materials.append(run.materials[source_quad])
                sim_quads.append(run.surfaces[source_quad])
            strip_data += struct.pack("<4B", top_start, bottom_start, target, 4 + 2 * target)
            strip_data += struct.pack("<%dh" % target, *chosen_materials)
            strip_count += 1
            converted_quad_count += target
        if first_strip > 255 or converted_quad_count > 255 or first_sim_quad > 255:
            raise ValueError("NFS4 u8 strip/sim index overflow")
        sim_slices += struct.pack(
            "<5B", first_strip, converted_quad_count, first_sim_quad, converted_quad_count, 0
        )

    for source_index in sorted(extra_vertices):
        if source_index not in source_to_output:
            source_to_output[source_index] = len(output_vertices)
            output_vertices.append(vertices[source_index])
    if len(output_vertices) > 256:
        return None
    return output_vertices, source_to_output, bytes(strip_data), strip_count, bytes(sim_quads), bytes(sim_slices)


def transform_vertices(
    data: bytes,
    geometry: dict,
    center: tuple[int, int, int],
    next_center: tuple[int, int, int],
) -> list[tuple[int, int, int, int]]:
    n0 = geometry["n"][0]
    delta = tuple(next_center[i] - center[i] for i in range(3))
    seam_adjust = tuple((d + (d >> 7)) >> 10 for d in delta)
    result = []
    for index in range(geometry["nv"]):
        x, y, z, color = struct.unpack_from("<hhhH", data, geometry["vbase"] + 8 * index)
        xyz = [x >> 2, y >> 2, z >> 2]
        if index < n0:
            xyz = [xyz[i] + seam_adjust[i] for i in range(3)]
        result.append((clamp16(xyz[0]), clamp16(xyz[1]), clamp16(xyz[2]), color))
    return result


def convert_materials(col_data: bytes, collections_: list[tuple[int, int, int, int]]) -> tuple[bytes, int]:
    offset, _length, _type, count = next(c for c in collections_ if c[2] == 2)
    source = col_data[offset + 8 : offset + 8 + 10 * count]
    out = bytearray()
    for index in range(count):
        shape, flags, uv, r, g, b, frames, interval, pad = struct.unpack_from(
            "<H7Bb", source, 10 * index
        )
        # 0x04 is animated in both games. NFS3's 0x10/0x20/0x40 flags have
        # different NFS4 meanings and must not leak across the format boundary.
        out += struct.pack("<H7Bb", shape, flags & 0x04, uv, r, g, b, frames, interval, pad)
    return bytes(out), count


def convert_slices(col_data: bytes, collections_: list[tuple[int, int, int, int]]) -> tuple[bytes, int]:
    offset, _length, _type, count = next(c for c in collections_ if c[2] == 0x0F)
    source = col_data[offset + 8 : offset + 8 + 36 * count]
    out = bytearray()
    for index in range(count):
        p = 36 * index
        out += source[p : p + 22]
        chunk, paved, left, right = struct.unpack_from("<4H", source, p + 22)
        if chunk > 255:
            raise ValueError(f"slice {index}: chunk index {chunk} exceeds NFS4 u8")
        lane_count = source[p + 31]
        out += struct.pack(
            "<hhhBBBB",
            as_signed16(paved),
            as_signed16(left),
            as_signed16(right),
            chunk,
            lane_count,
            source[p + 32],
            source[p + 33],
        )
    return bytes(out), count


def convert_env(dpq_path: Path, output_path: Path) -> bool:
    if not dpq_path.exists():
        return False
    text = re.sub(r"/\*.*?\*/", " ", dpq_path.read_text(errors="replace"), flags=re.S)
    values = [int(x) for x in re.findall(r"-?\d+", text)]
    if len(values) < 8:
        return False
    cursor = 4  # depth distance + RGB; TrackSpec owns those in NFS4
    lists = []
    for _ in range(2):
        entries = []
        while cursor + 4 <= len(values):
            entry = values[cursor : cursor + 4]
            cursor += 4
            entries.append(entry)
            if entry[0] < 0:
                break
        lists.append(entries)
    lines = [str(len(lists[0]))]
    lines.extend("%d, %d, %d, %d" % tuple(entry) for entry in lists[0])
    lines.append(str(len(lists[1])))
    lines.extend("%d, %d, %d, %d" % tuple(entry) for entry in lists[1])
    output_path.write_text("\n".join(lines) + "\n", newline="\n")
    return True


def block_map(blocks: list[tuple[int, int, int, int]]) -> dict[int, tuple[int, int, int]]:
    return {group_type: (offset, length, count) for offset, length, group_type, count in blocks}


def convert_instance_blocks(
    data: bytes,
    block_specs: list[tuple[int, int]],
    definition_base: int,
    definition_count: int,
    zoffset: int,
    approximations: collections.Counter[str],
) -> tuple[bytes, int, dict[int, int]]:
    """Convert NFS3 kind 1/3/4 records to NFS4 type 1/3 instances."""
    output = bytearray()
    output_count = 0
    sim_to_instance = {}
    for block_offset, count in block_specs:
        cursor = block_offset + 8
        for record_index in range(count):
            size, kind, local_definition = struct.unpack_from("<HBB", data, cursor)
            if size < 4 or cursor + size > len(data):
                raise ValueError(f"instance {record_index}: invalid size {size}")
            if local_definition >= definition_count:
                raise ValueError(f"instance {record_index}: definition {local_definition} out of range")
            definition = definition_base + local_definition
            if kind in (1, 4):
                if size < 16:
                    raise ValueError(f"instance {record_index}: short kind-{kind} record")
                output += struct.pack("<hBBBBh", 20, 1, 0, zoffset, 0, definition)
                output += data[cursor + 4 : cursor + 16]
                if kind == 4:
                    if size < 20:
                        raise ValueError(f"instance {record_index}: short kind-4 record")
                    sim_index = struct.unpack_from("<i", data, cursor + 16)[0]
                    sim_to_instance[sim_index] = output_count
                    approximations["kind-4 objects flattened to static type 1"] += 1
            elif kind == 3:
                if size < 8:
                    raise ValueError(f"instance {record_index}: short animated record")
                frame_count, interval = struct.unpack_from("<HH", data, cursor + 4)
                if size != 8 + 20 * frame_count:
                    raise ValueError(f"instance {record_index}: animated size mismatch")
                output_size = 12 + 20 * frame_count
                output += struct.pack("<hBBBBhHH", output_size, 3, 0, zoffset, 0, definition, frame_count, interval)
                output += data[cursor + 8 : cursor + size]
            else:
                raise ValueError(f"instance {record_index}: unsupported NFS3 kind {kind}")
            output_count += 1
            cursor += size
    return bytes(output), output_count, sim_to_instance


def build_aud(emitters: list[tuple[int, int, int, int, int]], file_id: int) -> bytes:
    records = bytearray()
    for x, y, z, sound_id, mode in emitters:
        if sound_id > 127:
            raise ValueError(f"ambient sound id {sound_id} exceeds NFS4 signed byte")
        min_delay = 30 if mode else 0
        random_delay = 30 if mode else 0
        records += struct.pack(
            "<3iHbbhbbbbbb",
            x,
            y,
            z,
            0,          # nextDelay is reset by AudioTrk_Reset
            sound_id,
            0,          # fadeIn
            100,        # common retail NFS4 audible range
            min_delay,
            random_delay,
            0,          # fixed spatial emitter, not animation-linked
            -1,         # runtime channel
            0,
            0,
        )
    return struct.pack("<4i", file_id, len(emitters), 0, 1) + records


def refpack_literal(payload: bytes) -> bytes:
    """EA RefPack stream using only literal runs (valid type-0x10 Q wrapper)."""
    body = bytearray()
    cursor = 0
    while len(payload) - cursor >= 4:
        take = min(112, ((len(payload) - cursor) // 4) * 4)
        body.append(0xDF + take // 4)
        body += payload[cursor : cursor + take]
        cursor += take
    tail = len(payload) - cursor
    body.append(0xFC | tail)
    body += payload[cursor:]
    size = len(payload)
    return bytes((0x10, 0xFB, size >> 16, (size >> 8) & 0xFF, size & 0xFF)) + body


def build_ai_files(slice_count: int) -> tuple[bytes, bytes]:
    # Zero best-line displacement means road centre. Zero curvature selects
    # the straight-line speed bucket. QCR carries one trailing sentinel byte.
    return refpack_literal(bytes(slice_count)), refpack_literal(bytes(slice_count + 1))


def read_numbers(path: Path) -> list[int]:
    text = re.sub(r"/\*.*?\*/", " ", path.read_text(errors="replace"), flags=re.S)
    return [int(value) for value in re.findall(r"-?\d+", text)]


def put_color(buffer: bytearray, offset: int, rgb: list[int] | tuple[int, int, int]) -> None:
    buffer[offset : offset + 4] = bytes(max(0, min(255, value)) for value in rgb) + b"\0"


def gradient(start: list[int], end: list[int]) -> list[tuple[int, int, int]]:
    return [tuple((start[c] * (4 - i) + end[c] * i) // 4 for c in range(3)) for i in range(5)]


def build_trackspec(hrz_path: Path, dpq_path: Path) -> bytes | None:
    if not hrz_path.exists() or not dpq_path.exists():
        return None
    hrz = read_numbers(hrz_path)
    dpq = read_numbers(dpq_path)
    if len(hrz) < 40 or len(dpq) < 4:
        return None

    background = hrz[6:9]
    day_front, day_back, day_top = hrz[9:12], hrz[12:15], hrz[15:18]
    wet_front, wet_back, wet_top = hrz[18:21], hrz[21:24], hrz[24:27]
    night_sky, night_horizon, night_world = hrz[27:30], hrz[30:33], hrz[33:36]
    weather_world = hrz[36:39]
    # Three bonus-track HRZ files omit the contrast value; their index 39 is
    # already the 123456789 cookie.
    weather_contrast = (hrz[39] << 7) if len(hrz) >= 41 else 0
    depth_color = dpq[1:4]

    specs = []
    for weather, night in ((0, 0), (0, 1), (1, 0), (1, 1)):
        record = bytearray(264)
        states = (0, weather, 0, 1, night, 1, weather or night, 0)
        struct.pack_into("<8h", record, 0, *states)

        # Fog block remains disabled; preserve its colour/start as useful metadata.
        struct.pack_into("<i", record, 16, 0)
        put_color(record, 20, depth_color)
        struct.pack_into("<2i", record, 24, dpq[0], 10)
        struct.pack_into("<2i", record, 32, 1 if weather else 0, 2)

        # Horizon is disabled because NFS3 and NFS4 texture-ring indices differ.
        angle = (hrz[3] * 4096) // 360
        struct.pack_into("<4i", record, 40, hrz[0], angle, hrz[4] << 5, hrz[5] << 5)
        put_color(record, 56, night_horizon if night else (wet_front if weather else day_front))
        put_color(record, 60, night_horizon if night else (wet_back if weather else day_back))
        put_color(record, 64, background)
        put_color(record, 68, background)

        # Gouraud sky is independent of NFS4-specific PMX/ring texture indices.
        if night:
            front = back = top = night_sky
        elif weather:
            front, back, top = wet_front, wet_back, wet_top
        else:
            front, back, top = day_front, day_back, day_top
        struct.pack_into("<2i", record, 88, 0, hrz[1])
        for index, color in enumerate(gradient(front, top)):
            put_color(record, 96 + 4 * index, color)
        for index, color in enumerate(gradient(back, top)):
            put_color(record, 116 + 4 * index, color)
        put_color(record, 136, background)
        struct.pack_into("<i", record, 192, hrz[4] << 5)

        put_color(record, 236, night_world if night else background)
        put_color(record, 240, depth_color)
        struct.pack_into("<i", record, 244, dpq[0])
        struct.pack_into("<i", record, 248, weather_contrast if weather else 0)
        put_color(record, 252, weather_world if weather else (night_world if night else (128, 128, 128)))
        world = weather_world if weather else (night_world if night else (128, 128, 128))
        struct.pack_into("<4h", record, 256, world[0], world[1], world[2], 0)
        specs.append(bytes(record))
    return struct.pack("<2i", 108, 4) + b"".join(specs)


def convert_chunk(
    trk: N3.Trk,
    chunk_record: tuple[int, int, int, int, list[tuple[int, int, int, int]]],
    palette_map: dict[int, int],
    material_count: int,
    object_catalog: ObjectCatalog,
    ambient_emitters: list[tuple[int, int, int, int, int]],
    losses: collections.Counter[str],
) -> bytes:
    chunk_index, chunk, source_size, _source_size2, blocks = chunk_record
    data = trk.d
    by = block_map(blocks)
    geom = N3.geometry(data, chunk)
    center = trk.centers[chunk_index]
    next_center = trk.centers[(chunk_index + 1) % trk.chunkCount]
    vertices = transform_vertices(data, geom, center, next_center)

    q4_offset, q4_count = geom["arrays"][4]
    type5_offset, _type5_length, type5_count = by[5]
    if type5_count != q4_count:
        raise ValueError(f"chunk {chunk_index}: type 5 does not match q4")
    type5 = data[chunk + type5_offset + 8 : chunk + type5_offset + 8 + 2 * type5_count]

    sim_offset, _sim_length, sim_count = by[6]
    slice_runs: list[list[StripRun]] = []
    for slice_index in range(sim_count):
        first_quad, quad_count, _event, link0, link1 = struct.unpack_from(
            "<HBBhh", data, chunk + sim_offset + 8 + 8 * slice_index
        )
        # NFS4 slices have no alternative-route links and no per-slice music events.
        losses["alternative-route slice links dropped"] += (link0 != -1) + (link1 != -1)
        quads = []
        materials = []
        surfaces = []
        for local in range(quad_count):
            material, points = N3.quad(data, q4_offset + 6 * (first_quad + local))
            if material >= material_count:
                raise ValueError(f"chunk {chunk_index}: material {material} out of range")
            quads.append(points)
            materials.append(material)
            surfaces.append(type5[2 * (first_quad + local) + 1] & 0x3F)
        slice_runs.append(split_strip_runs(first_quad, quads, materials, surfaces))

    q5_offset, q5_count = geom["arrays"][5]
    extra_vertices = set()
    q5_source = []
    for index in range(q5_count):
        material, points = N3.quad(data, q5_offset + 6 * index)
        q5_source.append((material, points))
        extra_vertices.update(points)
    if 9 in by:
        line_offset, _line_length, line_count = by[9]
        for index in range(line_count):
            extra_vertices.add(data[chunk + line_offset + 8 + 4 * index])

    all_runs = [run for runs in slice_runs for run in runs]
    targets = [run.quad_count for run in all_runs]
    while True:
        built = emit_strips(slice_runs, targets, vertices, extra_vertices)
        if built is not None:
            break
        # Merge one lateral quad of the widest strip and retry (deterministic).
        candidates = [i for i, count in enumerate(targets) if count > 1]
        if not candidates:
            raise ValueError(f"chunk {chunk_index}: cannot fit strip vertices")
        index = max(candidates, key=lambda i: targets[i])
        targets[index] -= 1
    output_vertices, source_to_output, strip_data, strip_count, sim_quads, sim_slices = built
    dropped = sum(run.quad_count for run in all_runs) - sum(targets)
    if dropped:
        losses["road quads merged to fit 256 vertices per chunk"] += dropped

    vertex_data = b"".join(
        struct.pack("<hhhh", x, y, z, palette_map[color]) for x, y, z, color in output_vertices
    )
    q5_data = bytearray()
    for material, points in q5_source:
        q5_data += struct.pack("<h4B", material, *(source_to_output[p] for p in points))

    counts = (0, 0, 0, 0, 0, q5_count)
    quad_header = struct.pack(
        "<I10H",
        geom["rel"],
        0,
        0,
        0,
        len(output_vertices),
        *counts,
    )
    geometry_group = container(
        0x17,
        [
            group(0x1B, quad_header),
            group(0x18, vertex_data),
            group(0x19, bytes(q5_data)),
            group(0x1A, strip_data, strip_count),
            group(0x25, strip_data, strip_count),
        ],
    )

    definition_count = by[8][2] if 8 in by else 0
    instance_specs = []
    for object_type in (7, 0x12, 0x13, 0x14):
        if object_type in by:
            offset, _length, count = by[object_type]
            instance_specs.append((chunk + offset, count))
    instances, instance_count, sim_to_instance = convert_instance_blocks(
        data,
        instance_specs,
        object_catalog.chunk_bases[chunk_index],
        definition_count,
        1,
        losses,
    )

    children_after_meta = [geometry_group]
    if instance_count:
        children_after_meta.append(group(0x03, instances, instance_count))
    if 0x0A in by:
        offset, _length, count = by[0x0A]
        flares = bytearray()
        for index in range(count):
            x, y, z, flare_type, _pad = struct.unpack_from("<3iHH", data, chunk + offset + 8 + 16 * index)
            # `Flare_Halo` indexes `Flare_gType[type]`; NFS3's own type numbers would pick
            # car-light kinds, so map them by colour (table above). pad 0 = single halo.
            flares += struct.pack("<3ihh", x, y, z, FLARE_KIND.get(flare_type, 25), 0)
        children_after_meta.append(group(0x0A, bytes(flares), count))
    children_after_meta.append(group(0x05, sim_quads, len(sim_quads)))
    children_after_meta.append(group(0x06, sim_slices, sim_count))
    if 0x0B in by:
        offset, _length, count = by[0x0B]
        sim_objects = bytearray(data[chunk + offset + 8 : chunk + offset + 8 + 20 * count])
        for sim_index in range(count):
            sim_objects[20 * sim_index + 18] = sim_to_instance.get(sim_index, 0x7F)
        children_after_meta.append(group(0x0B, bytes(sim_objects), count))
    if 4 in by:
        offset, _length, count = by[4]
        source_vis = struct.unpack_from("<%dH" % count, data, chunk + offset + 8)
        visible = []
        for entry in source_vis:
            # NFS3 prints an error and truncates its list at the first out-of-range chunk.
            if (entry & 0x3FF) >= trk.chunkCount:
                break
            visible.append(entry)
        if len(visible) > VIS_LIMIT:
            # NFS3 lists reach 45 entries; keep the nearest neighbours (flag bits intact).
            def distance(entry: int) -> int:
                other = trk.centers[entry & 0x3FF]
                return (other[0] - center[0]) ** 2 + (other[2] - center[2]) ** 2

            keep = set(sorted(range(len(visible)), key=lambda i: distance(visible[i]))[:VIS_LIMIT])
            losses["far visibility entries dropped (NFS4 row limit)"] += len(visible) - VIS_LIMIT
            visible = [entry for i, entry in enumerate(visible) if i in keep]
        children_after_meta.append(
            group(0x04, struct.pack("<%dH" % len(visible), *visible), len(visible))
        )
    if 9 in by:
        offset, _length, count = by[9]
        lines = bytearray(data[chunk + offset + 8 : chunk + offset + 8 + 4 * count])
        for index in range(count):
            lines[4 * index] = source_to_output[lines[4 * index]]
        children_after_meta.append(group(0x09, bytes(lines), count))
    if 0x11 in by:
        offset, _length, count = by[0x11]
        for index in range(count):
            x, y, z, sound_id, mode = struct.unpack_from(
                "<3iHH", data, chunk + offset + 8 + 16 * index
            )
            ambient_emitters.append((x, y, z, sound_id, mode))
        losses["ambient emitter timing/range synthesized"] += count

    bounds = []
    for index in range(4):
        x, _y, z = struct.unpack_from("<3i", data, chunk + 0x10 + 12 * index)
        bounds.extend((clamp16((x - center[0]) >> 10), clamp16((z - center[2]) >> 10)))
    first_slice, source_chunk_index, pad = struct.unpack_from("<hhh", data, chunk + 10)
    meta = struct.pack(
        "<IIhhhh16h",
        source_size,
        source_size,
        len(children_after_meta) + 1,
        first_slice,
        source_chunk_index,
        pad,
        *(bounds + bounds),
    )
    return container(0x1D, [group(0x1C, meta)] + children_after_meta)


def find_source(source_dir: Path, layout: str, extension: str, streamed: bool = False) -> Path:
    prefix = "ZZZTR" if streamed else "ZTR"
    path = source_dir / f"{prefix}{layout}.{extension}"
    if not path.exists():
        raise FileNotFoundError(path)
    return path


def convert(
    source_dir: Path,
    layout: str,
    output_dir: Path,
    target: int,
    variants: bool,
    cop_difficulty: str = "BEG",
) -> Path:
    layout = layout.upper()
    if not re.fullmatch(r"\d\d[A-B]", layout):
        raise ValueError("layout must look like 00A or 04B")
    if not 0 <= target <= 10:
        raise ValueError("target must be an NFS4 slot from 00 through 10")

    trk_path = find_source(source_dir, layout, "TRK", streamed=True)
    col_path = find_source(source_dir, layout, "COL")
    trk_data = trk_path.read_bytes()
    col_data = col_path.read_bytes()
    trk = N3.Trk(trk_data)
    magic, version, size, collections_ = N3.parse_col(col_data)
    if trk.magic != b"TRAC" or trk.version != 0x16:
        raise ValueError("not an NFS3 TRAC v22 file")
    if magic != b"COLL" or version != 11 or size != len(col_data):
        raise ValueError("not an NFS3 COLL v11 file")

    colors: collections.Counter[int] = collections.Counter()
    chunk_records = list(trk.chunks())
    object_catalog = collect_object_catalog(trk, chunk_records, col_data, collections_)
    for _index, chunk, _size1, _size2, _blocks in chunk_records:
        geom = N3.geometry(trk_data, chunk)
        for vertex in range(geom["nv"]):
            colors[struct.unpack_from("<H", trk_data, geom["vbase"] + 8 * vertex + 6)[0]] += 1
    colors.update(object_colors(object_catalog.definitions))
    light_table, palette_map = build_palette(colors)
    materials, material_count = convert_materials(col_data, collections_)
    slices, slice_count = convert_slices(col_data, collections_)
    object_definitions, object_offsets = convert_object_definitions(
        object_catalog.definitions, palette_map, material_count
    )

    losses: collections.Counter[str] = collections.Counter()
    ambient_emitters: list[tuple[int, int, int, int, int]] = []
    chunks = [
        convert_chunk(
            trk, record, palette_map, material_count, object_catalog, ambient_emitters, losses
        )
        for record in chunk_records
    ]

    persistent_definition_count = next((c[3] for c in collections_ if c[2] == 8), 0)
    persistent_specs = [(c[0], c[3]) for c in collections_ if c[2] in (7, 0x12)]
    persistent_instances, persistent_instance_count, _unused = convert_instance_blocks(
        col_data,
        persistent_specs,
        object_catalog.persistent_base,
        persistent_definition_count,
        2,
        losses,
    )

    persistent_children = [group(0x02, materials)]
    if object_catalog.definitions:
        persistent_children.append(
            group(0x08, object_definitions, len(object_catalog.definitions))
        )
    if persistent_instance_count:
        persistent_children.append(group(0x07, persistent_instances, persistent_instance_count))
    persistent_children.append(group(0x0F, slices, slice_count))
    if object_catalog.definitions:
        persistent_children.append(group(0x26, object_offsets))
    persistent = container(0x21, persistent_children)
    track_header = struct.pack(
        "<8i", 666, 13, trk.maxMetaChunkSize, trk.maxChunkSize, trk.h10, trk.h14,
        (trk.chunkCount + 7) // 8, trk.chunkCount,
    )
    centers = b"".join(struct.pack("<3i", *center) for center in trk.centers)
    root = container(
        0x1E,
        [group(0x1F, track_header), group(0x20, centers)] + chunks + [persistent, group(0x23, light_table)],
    )

    output_dir.mkdir(parents=True, exist_ok=True)
    target_stem = f"ZTR{target:02d}"
    grp_path = output_dir / f"{target_stem}.GRP"
    grp_path.write_bytes(root)

    source_psh = source_dir / f"ZTR{layout}0.PSH"
    if source_psh.exists():
        shutil.copyfile(source_psh, output_dir / f"{target_stem}0.PSH")
    source_reflection = source_dir / f"ZTR{layout}R.PSH"
    if source_reflection.exists():
        shutil.copyfile(source_reflection, output_dir / f"{target_stem}R.PSH")
    convert_env(source_dir / f"ZTR{layout}.DPQ", output_dir / f"{target_stem}.ENV")
    for file_id in range(4):
        (output_dir / f"{target_stem}{file_id:02d}.AUD").write_bytes(
            build_aud(ambient_emitters, file_id)
        )
    qbe, qcr = build_ai_files(slice_count)
    (output_dir / f"{target_stem}.QBE").write_bytes(qbe)
    (output_dir / f"{target_stem}.QCR").write_bytes(qcr)
    trackspec = build_trackspec(
        source_dir / f"ZTR{layout}.HRZ", source_dir / f"ZTR{layout}.DPQ"
    )
    if trackspec is not None:
        (output_dir / f"{target_stem}.BIN").write_bytes(trackspec)
    cop_id = int(layout[:2]) + (16 if layout[2] == "B" else 0)
    source_cop = source_dir / f"ZTR{cop_id:02d}{cop_difficulty}.COP"
    (output_dir / f"{target_stem}.COP").write_bytes(
        source_cop.read_bytes() if source_cop.exists() else struct.pack("<i", 0)
    )

    if variants:
        for suffix in ("N", "S", "W"):
            shutil.copyfile(grp_path, output_dir / f"{target_stem}{suffix}.GRP")
            psh = output_dir / f"{target_stem}0.PSH"
            if psh.exists():
                shutil.copyfile(psh, output_dir / f"{target_stem}{suffix}0.PSH")

    parsed_bytes, parsed = N4.parse(grp_path)
    if parsed["errors"] or parsed_bytes != root:
        raise ValueError("generated GRP failed its structural parse")
    print(f"converted NFS3 {layout} -> NFS4 slot {target:02d}: {trk.chunkCount} chunks, {slice_count} slices")
    print(
        f"output: {grp_path} ({len(root)} bytes), materials={material_count}, "
        f"objects={len(object_catalog.definitions)}, lights={len(set(palette_map.values()))}"
    )
    if losses:
        print("explicit conversion losses:")
        for name, count in losses.items():
            print(f"  {name}: {count}")
    return grp_path


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source_dir", type=Path, help="directory containing extracted NFS3 track files")
    parser.add_argument("layout", help="NFS3 layout, for example 00A or 04B")
    parser.add_argument("output_dir", type=Path)
    parser.add_argument("--target", required=True, type=int, help="NFS4 track slot (0..10)")
    parser.add_argument("--variants", action="store_true", help="also emit identical N/S/W GRP and PSH variants")
    parser.add_argument("--cop", choices=("beg", "exp"), default="beg", help="NFS3 cop-trigger difficulty")
    args = parser.parse_args()
    convert(args.source_dir, args.layout, args.output_dir, args.target, args.variants, args.cop.upper())


if __name__ == "__main__":
    main()
