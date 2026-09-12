"""P881: explicit source-owned data windows and their oracle-only raw copies.

This is link-input/placement metadata, never an instruction rewrite. A native
local static needs one source backing cell, not an asm-labelled extern view or
a second raw copy in the reconstruction lane. The src lane retains its raw
oracle objects. Callers validate the compiler-emitted payload before excluding
the corresponding raw object; missing or stale source objects fail closed.
"""
from pathlib import Path
import hashlib
import json
import re
import struct

ROOT = Path(__file__).resolve().parents[1]
# P906: one complete native Replay run replaces one raw leaf. All eight
# members must be validated together; the only gap is three CPE-loaded zero
# alignment bytes after compressed_data. Backups/primary receipts:
# scratchpad/p906_checkpoint and scratchpad/p905_orphan_replay/audit_v2.json.
_REPLAY_DATA_RUN = (
    ('ReplayCameraList', '.data.replay_camera_list', 0x80117008, 36,
     '6ff7dd29e5ec2e65884bf75cd686810eb7b8f713adb5cbf05ae14106ddacd0f5', '32a985'),
    ('Replay_ReplayInterface', '.data.replay_interface', 0x8011702C, 32,
     '66687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925', '32a834'),
    ('Replay_ReplayCamera', '.data.replay_camera', 0x8011704C, 32,
     '66687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925', '32a86b'),
    ('controlData', '.data.replay_control_data', 0x8011706C, 256,
     '5341e6b2646979a70e57653007a1f310169421ec9bdd9f1a5648f75ade005af1', '32a8a5'),
    ('Replay_ReplayBuffer', '.data.replay_buffer', 0x8011716C, 27180,
     'f654d3c3dd102a4bbafd062596b1353d8181f701b9aa4ef0996b720c6ba10a8a', '32a8d4'),
    ('compressed_data', '.data.replay_compressed', 0x8011DB98, 33,
     '7f9c9e31ac8256ca2f258583df262dbc7d6f68f2a03043d5c99a4ae5a7396ce9', '32a905'),
    ('uncompressed_data', '.data.replay_uncompressed', 0x8011DBBC, 32,
     '66687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925', '32a929'),
    ('gReplayCameraSlots', '.data.replay_camera_slots', 0x8011DBDC, 1024,
     '5f70bf18a086007016e948b04aed3b82103a36bea41755b6cddfaf10ace3c6ef', '32a94f'),
)
SOURCE_DATA_OWNERS = (
    # P904: CPE-loaded five-cell primate run. The native semitrans initializer
    # is1; former private tentative cells were zero and disagreed with outside
    # consumers. Retire only this exact raw leaf, not .psh/shapeext after it.
    # Backup/native/raw-reference proofs: scratchpad/p904_checkpoint and
    # scratchpad/p904_primate_native. Remaining primate SBSS is separate debt.
    {
        'source': 'recon/eaclib/psx/eacpsxz/primate.c', 'section': '.sdata',
        'address': 0x8013DD04, 'size': 20, 'alignment': 4,
        'payload': bytes.fromhex('0000000000000000000000000000000001000000'),
        'oracle_source': 'asm/data/sdata_primate_legacy.sdata.s',
        'placement': 'fragment',
        'record': 'SYM0192d1..01930c names; MAP .sdata; CPE load3465 initialized words0,0,0,0,1',
        'symbols': tuple((name,4*i,4,1,'exact') for i,name in enumerate(
            ('otbuf','primbuf','linkmodeflag','drawpending','semitrans'))),
    },
    {
        'source': 'recon/frontend/common/fecredits.cpp',
        'section': '.data',
        'address': 0x80051AA0,
        'size': 8,
        'payload': bytes.fromhex('bc02000000000000'),
        'global': 'CREDFADETICKS',
        'static': 'lasttick',
        'oracle_source': 'asm/data/front_data_fecredits_legacy.data.s',
        'record': 'SYM5f1f9a: STAT INT lasttick, object-relative offset4',
    },
    # P882: independent raw GP/MAP anchors and complete relocation-free
    # payloads prove these native .sdata owners. The fragment selects their
    # source sections; its SUBALIGN(4) supplies the verified terminal padding.
    # Backups/evidence: scratchpad/p882_gprel, omitted_sections.json.
    {
        'source': 'recon/game/common/hudpmx.cpp', 'section': '.sdata',
        'address': 0x8013C84C, 'size': 0x535, 'oracle_size': 0x538,
        'payload_sha256': '3351804d144ffcc98ae338b917cea61b12696514f5f521a41548423b16ec36af',
        'oracle_source': 'asm/data/sdata_hudpmx_legacy.sdata.s',
        'placement': 'fragment', 'record': 'P882: two raw GP anchors; exact native payload',
    },
    {
        'source': 'recon/game/common/copspeak.cpp', 'section': '.sdata',
        'address': 0x8013D07C, 'size': 0x7E, 'oracle_size': 0x80,
        # P908: native typed cells; keep the full literal/padding payload and
        # the two-byte oracle tail unchanged. Proof: p908_owner_contracts.
        'alignment': 4, 'assert_native_symbols': True,
        'symbols': (
            ('cdsectorreseek',0,4,1,'exact'),
            ('CopSpeak_gHandleCount',4,1,1,'exact'),
            ('CopSpeak_gQueueHead',76,4,1,'exact'),
            ('CopSpeak_gQueuePlay',80,4,1,'exact'),
            ('CopSpeak_gSpchHandle',84,4,1,'exact'),
            ('CopSpeak_gNumTrackSfx',88,4,1,'exact'),
            ('CopSpeak_gQueueLoad',92,4,1,'exact'),
            ('CopSpeak_gQueueReady',96,4,1,'exact'),
            ('CopSpeak_gWrongWay',100,4,1,'exact'),
            ('CopSpeak_gBuffer',104,4,1,'exact'),
            ('CopSpeak_gBufferLow',108,2,1,'exact'),
            ('CopSpeak_gBufferStart',110,2,1,'exact'),
            ('CopSpeak_gBufferEnd',112,2,1,'exact'),
            ('CopSpeak_gBufferHigh',114,2,1,'exact'),
            ('CopSpeak_gStaticHandle',116,8,1,'exact'),
            ('CopSpeak_gStaticPatch',124,2,1,'exact'),
        ),
        'payload_sha256': '9916e2deea22d489a0ca65a78ff2ed67c7beb13ff564c1b52beea4cbe70767f1',
        'oracle_source': 'asm/data/sdata_copspeak_legacy.sdata.s',
        'placement': 'fragment', 'record': 'P882: 140 consistent native/raw anchors; exact payload',
    },
    {
        'source': 'recon/game/common/nfs3.cpp', 'section': '.sdata',
        'address': 0x8013D270, 'size': 0x58,
        # P908: sixteen native global declarations (the older seventeen
        # anchors counted references, not globals). BOOL storage is four bytes.
        'alignment': 4, 'assert_native_symbols': True,
        'symbols': (
            ('gMusicInSimIsOn',0,1,1,'exact'),
            ('gUseFrontend',4,4,1,'exact'),
            ('gFECheats',8,4,1,'exact'),
            ('gFEBonus',12,4,1,'exact'),
            ('gFEBigHandle',16,4,1,'exact'),
            ('MEMCARDFRONTENDISINITTED',20,4,1,'exact'),
            ('gCheckTotalTime',24,1,1,'exact'),
            ('gCheckLapTime',25,1,1,'exact'),
            ('gUpdateTournamentInfoFlag',26,1,1,'exact'),
            ('gUpdateKnockoutInfoFlag',27,1,1,'exact'),
            ('gKnockOutSpeechFlag',28,1,1,'exact'),
            ('gCalculateVictory',29,1,1,'exact'),
            ('gPlayerEnteredNameAlready',32,2,1,'exact'),
            ('nfs_sysInfo',68,4,1,'exact'),
            ('missionManager',72,8,1,'exact'),
            ('finishOrder',80,8,1,'exact'),
        ),
        'payload_sha256': '2d87c1156c33b9e238babab757c4501968dbe30f9d5b9a645429665ea21c068a',
        'oracle_source': 'asm/data/sdata_nfs3_legacy.sdata.s',
        'placement': 'fragment', 'record': 'P882: 17 consistent native/raw anchors; exact payload',
    },
    {
        'source': 'recon/game/common/r3dcar.cpp', 'section': '.sdata',
        'address': 0x8013D324, 'size': 0x9C,
        # P908: PTR STRUCT sizes36/12 describe pointees, not pointer storage.
        # These exact four-byte cells coexist with the untouched literal pool.
        'alignment': 4, 'assert_native_symbols': True,
        'symbols': (
            ('R3DCar_InMenu',0,4,1,'exact'),
            ('R3DCar_aSyncLoading',96,4,1,'exact'),
            ('R3DCar_orientMat',100,4,1,'exact'),
            ('R3DCar_position',104,4,1,'exact'),
            ('R3DCar_center',108,8,1,'exact'),
            ('R3DCar_shadowFlag',116,4,1,'exact'),
            ('R3DCar_shadowColour',120,4,1,'exact'),
            ('R3DCar_eMapColour',124,4,1,'exact'),
            ('R3DCar_yawCam',128,2,1,'exact'),
            ('R3DCar_Clock',132,4,1,'exact'),
            ('R3DCar_ClockLast',136,4,1,'exact'),
            ('R3DCar_BigFile',140,4,1,'exact'),
            ('R3DCar_LicenseShapeFile',144,4,1,'exact'),
            ('R3DCar_subOt',148,4,1,'exact'),
            ('R3DCar_rightHandDrive',152,4,1,'exact'),
        ),
        'payload_sha256': '8e3a0d3cbd549fdabdaf42d3c37494688098efef57ecf6410d273f468b77c9ca',
        'oracle_source': 'asm/data/sdata_r3dcar_legacy.sdata.s',
        'placement': 'fragment', 'record': 'P882: 112 consistent native/raw anchors; exact payload',
    },
    {
        'source': 'recon/game/common/sim.cpp', 'section': '.sdata',
        'address': 0x8013D40C, 'size': 0x28,
        'payload_sha256': '58eec09fc902fa59a719ff705a371adb51f37cf5bd2342194f9ff25f778af04d',
        'oracle_source': 'asm/data/sdata_sim_legacy.sdata.s',
        'placement': 'fragment', 'record': 'P882: 14 consistent native/raw anchors; exact payload',
    },
    # P883: canonical mutable CTYPE data belongs in the main data fragment,
    # not its stale .rodata selector. Only this raw table is oracle-only;
    # the surrounding r18 padding and other legacy tables stay intact.
    # Backups/proofs: scratchpad/p883_data_layout and scratchpad/p883_ctype.
    {
        'source': 'recon/syslib/psx/libc/CTYPE0.c', 'section': '.data',
        'address': 0x801371D0, 'size': 129,
        'payload_sha256': 'd3ca4007e97054deeb66d809e73c7b766c1156c598fb7b92d403aa7b71fbbb0a',
        'oracle_source': 'asm/data/data_ctype_legacy.data.s',
        'placement': 'fragment', 'record': 'SYM016504 and native MAP: _ctype_ at801371D0; PsyQ CTYPE0 mutable char[129]',
    },
    # The front_data fragment is not consumed by gen_ld. Like fecredits,
    # FETextRender needs an explicit native output section, not membership
    # in an inactive fragment. Native SYM52293b/522963 bound both globals.
    {
        'source': 'recon/frontend/common/fetextrender.cpp', 'section': '.data',
        'address': 0x800515B8, 'size': 88,
        'payload_sha256': '82a7158d55efa9688e94d835ee9d71f3780c8a4d17881e69f4ce1edb5a605053',
        'oracle_source': 'asm/data/front_data_o00.data.s',
        'record': 'SYM52293b CHAR[14][6] textDefinitions +84 BOOL gSemiTransText (522963)',
    },
    # P884: these typed table sections were already selected at native slots,
    # but a raw definition in r18 won their public symbol bindings at orphan
    # addresses. Separate oracle-only leaves retire exactly those duplicates.
    # Native SYM/MAP anchors and every initialized byte are independently
    # checked; no new table source, instruction patch or padding is introduced.
    # Backups and actual consumer-reference receipts: scratchpad/p884_tables.
    {
        'source': 'recon/eaclib/psx/eacpsxz/asintbl.c', 'section': '.data',
        'address': 0x80137260, 'size': 512,
        'payload_sha256': 'fff107aee0cc92ff9a79d1acb10342cae29db4449b41bdfc1a4a082e9d541e0c',
        'oracle_source': 'asm/data/data_asintbl_legacy.data.s',
        'placement': 'fragment', 'record': 'SYM016511 asintbl; archive member780f13/780f47; native MAP80137260',
    },
    {
        'source': 'recon/eaclib/psx/eacpsxz/sintbl.c', 'section': '.data',
        'address': 0x80137464, 'size': 1028,
        'payload_sha256': 'c3b03a2581960f9b22f2f29fb52f30bf36eb87c3896c8e4f62c708b3c247f880',
        'oracle_source': 'asm/data/data_sintbl_legacy.data.s',
        'placement': 'fragment', 'record': 'SYM01651e sintbl; archive member780f7b/780fae; native MAP80137464',
    },
    {
        'source': 'recon/eaclib/psx/eacpsxz/fatantbl.c', 'section': '.data',
        'address': 0x80137868, 'size': 1028,
        'payload_sha256': 'a3ab1c0b30ea38a25c2d7f7c7b13969a0e3448547b839c92b1ae5789c3942b64',
        'oracle_source': 'asm/data/data_fatantbl_legacy.data.s',
        'placement': 'fragment', 'record': 'SYM01652a fatantbl; archive member7810bd/7810f2; native MAP80137868',
    },
    {
        'source': 'recon/syslib/psx/libgte/CSTBL.c', 'section': '.data',
        'address': 0x80137D20, 'size': 16384,
        'payload_sha256': 'b40c47b014ca8650c539760fd4c519cabce6f091628566ca0dd22318bb2c5b7a',
        'oracle_source': 'asm/data/data_cstbl_legacy.data.s',
        'placement': 'fragment', 'record': 'SYM016713 rcossin_tbl; native MAP80137D20; PsyQ CSTBL data owner',
    },
    # P885: three more complete typed .data owners already occupy native
    # fragment slots. Retire only their isolated raw copies, preserving the
    # oracle lane, all seven public cell addresses and atantbl's three zeros.
    # Full source/raw/native payload and reference receipts: scratchpad/p885_owners.
    # Current tool/ELF/map backups are retained in its root_backups directory.
    {
        'source': 'recon/syslib/psx/libpress/TABLE.c', 'section': '.data',
        'address': 0x80123838, 'size': 69632,
        'payload_sha256': '49dc16eab652c0bb30a23a7652cccfd1423777e2e08e71e028904bd8e020841b',
        'oracle_source': 'asm/data/data_libpress_table_legacy.data.s',
        'placement': 'fragment', 'record': 'SYM016333..01635c four DVLC exports; TABLE.obj77a62c; native MAP80123838',
    },
    {
        'source': 'recon/syslib/psx/libsn/SNDEF.c', 'section': '.data',
        'address': 0x80136CD0, 'size': 8,
        'payload_sha256': 'aebf8fac801b6e902c89e83e809e3879ab4dbc5345df3482515205865aa79bb8',
        'oracle_source': 'asm/data/data_sndef_legacy.data.s',
        'placement': 'fragment', 'record': 'SNDEF.obj77fc26; native MAP _stacksize80136CD0/_ramsize80136CD4',
    },
    {
        'source': 'recon/eaclib/psx/eacpsxz/atantbl.c', 'section': '.data',
        'address': 0x80136CE8, 'size': 257, 'oracle_size': 260,
        'payload_sha256': '03ab75ced39a3c62580ab3e24c4e54867b63bbdd1135da55cdf6bd678f74f221',
        'oracle_source': 'asm/data/data_atantbl_legacy.data.s',
        'placement': 'fragment', 'record': 'atantbl.obj780289; native MAP80136CE8; 257 payload bytes plus3 alignment zeros',
    },
    # P886: TextureProcess's complete G8 run begins40 bytes before gZDepth.
    # Correct source literals restore the native string order; r21/o34 now
    # divide at the real TU start instead of counting those strings twice.
    # This also restores the following vars/native small-data addresses.
    # Source/tool/link backups and raw-reference proofs: scratchpad/p886_vars.
    {
        'source': 'recon/game/psx/textureprocess.cpp', 'section': '.sdata',
        'address': 0x8013DB4C, 'size': 68,
        'payload_sha256': 'bd5723cf969087815cbd950661ce680a0d843b81553c5a67ef6b0eac4bfecd1e',
        'oracle_source': 'asm/data/sdata_8013C54C_o34.sdata.s',
        'placement': 'fragment', 'record': 'SYM477004..4770b4 globals at+40; raw Fog_ReadFogKeys literal addresses8013DB4C/54/5C/64',
    },
    {
        'source': 'recon/eaclib/psx/eacpsxz/vars.c', 'section': '.sdata',
        'address': 0x8013DC64, 'size': 160,
        'payload_sha256': '2ee7b7ed73b946c772a7495b6ad5423aad6fcdc5aecbaeb6c5628478c7f62789',
        'oracle_source': 'asm/data/sdata_vars_legacy.sdata.s',
        'placement': 'fragment', 'record': 'SYM77a358 vars.obj; forty native name/address cells019083 onward, corroborated by NFS2 INT records',
    },
    # P887: G0 restores drawshp's actual scalar declaration/address schedule
    # and its native4-byte initialized data. The old r08 copy is src-only;
    # its following alignment word remains outside this variable. The front
    # fragment is inactive, so select this owner at an explicit native VA.
    # Backups/proofs: scratchpad/p887_checkpoint and scratchpad/p887_knocolor.
    {
        'source': 'recon/frontend/psx/drawshp.cpp', 'section': '.data',
        'address': 0x800529D0, 'size': 4,
        'payload_sha256': '91b1f236f5972384b2b07ecfc8da0a2b669b458c6a98170c34d36bc5f4e3a12e',
        'oracle_source': 'asm/data/front_data_knocolor_legacy.data.s',
        'record': 'SYM745326 EXT INT kNoColor at800529D0; raw four bytes80808000',
    },
    # P896: restore native CHAR firstTime=1 and its three following AI INTs
    # as one16-byte source run. Both old raw pieces are oracle-only. This is
    # source ownership/placement, not a compiled-instruction rewrite.
    # Backups and exact GP/global/raw proof: scratchpad/p896_checkpoint/backups
    # and scratchpad/p896_ai_storage (full_owner stage).
    {
        'source': 'recon/game/common/ai.cpp', 'section': '.sdata',
        'address': 0x8013C54C, 'size': 16,
        'payload_sha256': '4cbbd8ca5215b8d161aec181a74b694f4e24b001d5b081dc0030ed797a8973e0',
        'oracle_sources': ('asm/data/sdata_8013C54C_r00.sdata.s',
                           'asm/data/sdata_8013C54C_o00.sdata.s'),
        'placement': 'fragment',
        'record': 'SYM032c02 STAT CHAR firstTime; raw/CPE8013C54C=1; native AI_time/elapsedTime/iTime+4/+8/+12',
        'symbols': (('firstTime',0,1,0,'uid'), ('AI_time',4,4,1,'exact'),
                    ('AI_elapsedTime',8,4,1,'exact'), ('AI_iTime',12,4,1,'exact')),
    },
    # P906: exact FEI table and all108 native pointer fields, not a generic
    # relocation exemption. Target bases/extents come from typedSYM/MAP/CPE;
    # source field-expression and raw-pointer proofs: scratchpad/p906_fei_owner.
    {
        "source": "recon/game/common/fei.cpp",
        "section": ".data",
        "address": 2148607900,
        "size": 912,
        "alignment": 4,
        "placement": "fragment",
        "oracle_source": "asm/data/data_8010CCD4_o19.data.s",
        "record": "SYM27756d FEI_gList[114],275358 FEI_tList8; MAP/CPE load8011279C/912; native target records2874b5/2c746a",
        "symbols": (("FEI_gList", 0, 912, 1, "exact"),),
        "payload_sha256": "347d964de981ad180577b44e77c8a41164f4f60f9c6850adb9aaecf03dfcefdc",
        "relocations32": (
            (36, "gUseFrontend", 0),
            (44, "GameSetup_gData", 0),
            (52, "GameSetup_gData", 4),
            (60, "GameSetup_gData", 8),
            (68, "GameSetup_gData", 12),
            (76, "GameSetup_gData", 16),
            (84, "GameSetup_gData", 20),
            (92, "GameSetup_gData", 24),
            (100, "GameSetup_gData", 28),
            (108, "GameSetup_gData", 32),
            (116, "GameSetup_gData", 56),
            (124, "GameSetup_gData", 92),
            (132, "GameSetup_gData", 60),
            (140, "GameSetup_gData", 68),
            (148, "GameSetup_gData", 72),
            (156, "GameSetup_gData", 76),
            (164, "GameSetup_gData", 80),
            (172, "GameSetup_gData", 84),
            (180, "GameSetup_gData", 44),
            (188, "GameSetup_gData", 48),
            (196, "GameSetup_gData", 52),
            (204, "GameSetup_gData", 88),
            (212, "GameSetup_gData", 964),
            (220, "GameSetup_gData", 968),
            (228, "GameSetup_gData", 972),
            (236, "GameSetup_gData", 976),
            (244, "GameSetup_gData", 188),
            (252, "GameSetup_gData", 184),
            (260, "GameSetup_gData", 200),
            (268, "GameSetup_gData", 204),
            (276, "GameSetup_gData", 208),
            (284, "GameSetup_gData", 428),
            (292, "GameSetup_gData", 432),
            (300, "GameSetup_gData", 224),
            (308, "GameSetup_gData", 228),
            (316, "GameSetup_gData", 232),
            (324, "GameSetup_gData", 236),
            (332, "GameSetup_gData", 240),
            (340, "GameSetup_gData", 244),
            (348, "GameSetup_gData", 248),
            (356, "GameSetup_gData", 252),
            (364, "GameSetup_gData", 256),
            (372, "GameSetup_gData", 264),
            (380, "GameSetup_gData", 260),
            (388, "GameSetup_gData", 192),
            (396, "GameSetup_gData", 196),
            (404, "GameSetup_gData", 96),
            (412, "GameSetup_gData", 104),
            (420, "GameSetup_gData", 112),
            (428, "GameSetup_gData", 120),
            (436, "GameSetup_gData", 128),
            (444, "GameSetup_gData", 144),
            (452, "GameSetup_gData", 136),
            (460, "GameSetup_gData", 160),
            (468, "GameSetup_gData", 152),
            (476, "GameSetup_gData", 168),
            (484, "GameSetup_gData", 176),
            (492, "GameSetup_gData", 100),
            (500, "GameSetup_gData", 108),
            (508, "GameSetup_gData", 116),
            (516, "GameSetup_gData", 124),
            (524, "GameSetup_gData", 132),
            (532, "GameSetup_gData", 148),
            (540, "GameSetup_gData", 140),
            (548, "GameSetup_gData", 164),
            (556, "GameSetup_gData", 156),
            (564, "GameSetup_gData", 172),
            (572, "GameSetup_gData", 180),
            (580, "GameSetup_gData", 36),
            (588, "GameSetup_gData", 268),
            (604, "GameSetup_gData", 980),
            (612, "GameSetup_gData", 984),
            (620, "GameSetup_gData", 988),
            (628, "GameSetup_gData", 1004),
            (636, "GameSetup_gData", 1008),
            (644, "GameSetup_gData", 1012),
            (652, "GameSetup_gData", 992),
            (660, "GameSetup_gData", 996),
            (668, "GameSetup_gData", 1000),
            (676, "GameSetup_gData", 1048),
            (684, "GameSetup_gData", 1016),
            (692, "GameSetup_gData", 1020),
            (700, "GameSetup_gData", 1040),
            (708, "GameSetup_gData", 1052),
            (716, "GameSetup_gData", 1044),
            (724, "GameSetup_gData", 1036),
            (732, "GameSetup_gData", 1068),
            (740, "GameSetup_gData", 1028),
            (748, "GameSetup_gData", 1032),
            (756, "GameSetup_gData", 1056),
            (764, "GameSetup_gData", 1060),
            (772, "GameSetup_gData", 1064),
            (780, "GameSetup_gData", 1092),
            (788, "GameSetup_gData", 1100),
            (796, "GameSetup_gData", 1104),
            (804, "GameSetup_gData", 1108),
            (812, "GameSetup_gData", 1112),
            (820, "GameSetup_gData", 1116),
            (828, "GameSetup_gData", 1120),
            (836, "GameSetup_gData", 1124),
            (844, "GameSetup_gData", 1128),
            (852, "GameSetup_gData", 1132),
            (860, "GameSetup_gData", 1136),
            (868, "GameSetup_gData", 1140),
            (876, "GameSetup_gData", 1144),
            (884, "GameSetup_gData", 1148),
            (892, "GameSetup_gData", 1152),
            (900, "GameSetup_gData", 1156),
        ),
        "relocation_targets": (("gUseFrontend", 2148782708, 4), ("GameSetup_gData", 2148610540, 2600)),
        "masked_payload_sha256": "9cfbd7290ff1042a7e69d9f87034a2cdb49bcc697147217c7c5c40c57a4572e1",
        "resolved_payload_sha256": "e6122a2fad6a680c74ef583d39eb4ad4608a208b1d386bc0614fb989f90c25be",
        "assert_native_symbols": True,
        "assert_native_relocation_targets": True,
    },
    # P906 actual-target follow-up: complete AudioCmn initialized run and
    # TrackSpec's already-native three-word run. Keep the two real Audio
    # function statics LOCAL; ten existing string carriers are not claimed
    # to be original declaration names. Source/raw/CPE and58/3 symbol proof:
    # scratchpad/p906_native_name_conflicts/ownership; backups:p906_checkpoint.
    {
        "source": "recon/game/common/audiocmn.cpp",
        "section": ".sdata",
        "address": 2148779560,
        "size": 248,
        "alignment": 4,
        "payload_sha256": "aa90d91e4d051ff001d5ce5092d70c2e66a995137a8ccec411f31b351d306e44",
        "oracle_source": "asm/data/sdata_8013C54C_r05.sdata.s",
        "placement": "fragment",
        "symbols": (
            ("trackMusicState", 0, 1, 1, "exact"),
            ("audioBackwardsDirection", 4, 4, 1, "exact"),
            ("intensityFalseLapCounter", 8, 4, 1, "exact"),
            ("falseLapCounter", 12, 4, 1, "exact"),
            ("gMusicStyle", 16, 4, 1, "exact"),
            ("countdown", 20, 1, 1, "exact"),
            ("FadingMusic", 21, 1, 1, "exact"),
            ("StartedNewMusic", 22, 1, 1, "exact"),
            ("recordLapTime", 24, 4, 1, "exact"),
            ("AudioCmn_kAudioOn", 28, 4, 1, "exact"),
            ("AudioCmn_kAudioStreamingOn", 32, 4, 1, "exact"),
            ("SgameSFXvol", 36, 4, 1, "exact"),
            ("gMasterMusicLevel", 40, 4, 1, "exact"),
            ("gMasterSFXLevel", 44, 4, 1, "exact"),
            ("gMasterEngineLevel", 48, 4, 1, "exact"),
            ("gMasterFENarrationLevel", 52, 4, 1, "exact"),
            ("gMasterAmbientLevel", 56, 4, 1, "exact"),
            ("previousSFXLevel", 60, 4, 1, "exact"),
            ("AudioCmn_musicInteractive", 64, 4, 1, "exact"),
            ("gFEmusicON", 68, 4, 1, "exact"),
            ("NumSFXOn", 72, 4, 1, "exact"),
            ("gStereoMode", 76, 4, 1, "exact"),
            ("fReverbOn", 80, 1, 1, "exact"),
            ("fReverbLevel", 81, 1, 1, "exact"),
            ("lastImpactSample", 132, 4, 0, "uid"),
            ("cobbleCount", 136, 1, 0, "uid"),
            ("falseLapTrigCur", 140, 4, 1, "exact"),
            ("flaseLapTrigTrack", 144, 4, 1, "exact"),
            ("currentLap", 148, 2, 1, "exact"),
            ("bestLapTime", 152, 8, 1, "exact"),
            ("gtotallaptimes", 160, 8, 1, "exact"),
            ("AudioCmn_gPlayerArrested", 168, 8, 1, "exact"),
            ("AudioCmn_gCursorSndHandle", 176, 4, 1, "exact"),
            ("AudioCmn_gLastFade", 180, 4, 1, "exact"),
            ("AudioCmn_gLoadTables", 184, 4, 1, "exact"),
            ("AudioCmn_gCruiseTables", 188, 4, 1, "exact"),
            ("AudioCmn_gResume", 192, 4, 1, "exact"),
            ("AudioCmn_gStreamRestartTimer", 196, 4, 1, "exact"),
            ("fMysticWindON", 200, 2, 1, "exact"),
            ("fAmbientRangeON", 204, 2, 1, "exact"),
            ("currentWindVal", 208, 8, 1, "exact"),
            ("nextWindVal", 216, 8, 1, "exact"),
            ("currentWindPan", 224, 4, 1, "exact"),
            ("nextWindPan", 228, 4, 1, "exact"),
            ("gQuickSirenCount", 232, 4, 1, "exact"),
            ("AudioCmn_ThunderAmp", 236, 4, 1, "exact"),
            ("AudioCmn_ThunderAzi", 240, 4, 1, "exact"),
            ("AudioCmn_ThunderDel", 244, 4, 1, "exact"),
        ),
        "record": "P907 SYM46globals and2LOCALstatics; ordinary literals replace ten synthetic globals; native pooling and248bytes exact",
        "assert_native_symbols": ("trackMusicState", "audioBackwardsDirection", "intensityFalseLapCounter", "falseLapCounter", "gMusicStyle", "countdown", "FadingMusic", "StartedNewMusic", "recordLapTime", "AudioCmn_kAudioOn", "AudioCmn_kAudioStreamingOn", "SgameSFXvol", "gMasterMusicLevel", "gMasterSFXLevel", "gMasterEngineLevel", "gMasterFENarrationLevel", "gMasterAmbientLevel", "previousSFXLevel", "AudioCmn_musicInteractive", "gFEmusicON", "NumSFXOn", "gStereoMode", "fReverbOn", "fReverbLevel", "falseLapTrigCur", "flaseLapTrigTrack", "currentLap", "bestLapTime", "gtotallaptimes", "AudioCmn_gPlayerArrested", "AudioCmn_gCursorSndHandle", "AudioCmn_gLastFade", "AudioCmn_gLoadTables", "AudioCmn_gCruiseTables", "AudioCmn_gResume", "AudioCmn_gStreamRestartTimer", "fMysticWindON", "fAmbientRangeON", "currentWindVal", "nextWindVal", "currentWindPan", "nextWindPan", "gQuickSirenCount", "AudioCmn_ThunderAmp", "AudioCmn_ThunderAzi", "AudioCmn_ThunderDel"),
    },
    # P907: full native data owner plus a non-owning readonly template check.
    # Same-TU .sdata section relocations require an already validated owner;
    # the GLOBAL-UNDEF FEI mode remains separate and unchanged.
    {
        "source": "recon/game/common/audiocmn.cpp",
        "section": ".data",
        "size": 2416,
        "alignment": 4,
        "oracle_source": "asm/data/data_8010CCD4_r04.data.s",
        "symbols": (
            ("gBankNumLookupTable", 0, 284, 1, "exact"),
            ("falseLapTrigNumsForward", 284, 80, 1, "exact"),
            ("falseLapTrigNumsBackward", 364, 80, 1, "exact"),
            ("Xfade", 444, 129, 1, "exact"),
            ("SkidInitMaxFreq", 576, 71, 0, "exact"),
            ("compareTimes", 648, 25, 0, "uid"),
            ("AudioCmn_LanguageName", 676, 28, 1, "exact"),
            ("bSirenOn", 704, 24, 1, "exact"),
            ("bSirenPitchingUp", 728, 24, 1, "exact"),
            ("quickSirenActive", 752, 24, 1, "exact"),
            ("sirenPitchWidth", 776, 24, 1, "exact"),
            ("sirenCurrentPitch", 800, 24, 1, "exact"),
            ("slowSirenReps", 824, 24, 1, "exact"),
            ("sirenCount", 848, 24, 1, "exact"),
            ("reachedSirenMin", 872, 24, 1, "exact"),
            ("quickSirenTimeCount", 896, 24, 1, "exact"),
            ("AudioCmn_gReTrig", 920, 64, 1, "exact"),
            ("gSndBnk", 984, 84, 1, "exact"),
            ("gaChannel", 1068, 568, 1, "exact"),
            ("AudioCmn_gSfxSlot", 1636, 768, 1, "exact"),
            ("carbankname", 2404, 12, 1, "exact"),
        ),
        "record": "P907 complete21 native data records; original19publics and2LOCALstatics;CPE/raw2416exact after7literal pointer relocations",
        "address": 2148590800,
        "placement": "fragment",
        "assert_native_symbols": ("gBankNumLookupTable", "falseLapTrigNumsForward", "falseLapTrigNumsBackward", "Xfade", "AudioCmn_LanguageName", "bSirenOn", "bSirenPitchingUp", "quickSirenActive", "sirenPitchWidth", "sirenCurrentPitch", "slowSirenReps", "sirenCount", "reachedSirenMin", "quickSirenTimeCount", "AudioCmn_gReTrig", "gSndBnk", "gaChannel", "AudioCmn_gSfxSlot", "carbankname"),
        "relocation_target_mode": "validated_same_tu_section",
        "local_section_targets": (
            (".sdata", 2148779560, 248, "aa90d91e4d051ff001d5ce5092d70c2e66a995137a8ccec411f31b351d306e44"),
        ),
        "relocations32": (
            (676, ".sdata", 100),
            (680, ".sdata", 104),
            (684, ".sdata", 108),
            (688, ".sdata", 112),
            (692, ".sdata", 116),
            (696, ".sdata", 100),
            (700, ".sdata", 100),
        ),
        "payload_sha256": "e1a744bf6e880be5b91fae54ad8dc601d96e451a3ede856e8e0e5f7cccd1263e",
        "masked_payload_sha256": "380b5ae78f6eb40583a169024c54a61354702926725788fa72f3ec77f41c2d3a",
        "resolved_payload_sha256": "f9115b7910d5f733ab43dc31c3f1218e77c039892ed2bc19ae72ad581e66f494",
        "auxiliary_windows": (
            {
                "source": "recon/game/common/audiocmn.cpp",
                "section": ".rodata",
                "address": 2147833612,
                "section_address": 2147833552,
                "section_size": 152,
                "offset": 60,
                "size": 44,
                "alignment": 8,
                "auxiliary_readonly_window": True,
                "oracle_source": "asm/data/rdata_audiocmn_trackgenbank_legacy.rodata.s",
                "record": "SYM1923e1 AUTO TrackGenBank ARY PTR CHAR44;raw11pointers;readonly compiler template",
                "relocation_target_mode": "validated_same_tu_section",
                "local_section_targets": (
                    (".sdata", 2148779560, 248, "aa90d91e4d051ff001d5ce5092d70c2e66a995137a8ccec411f31b351d306e44"),
                ),
                "relocations32": (
                    (0, ".sdata", 100),
                    (4, ".sdata", 124),
                    (8, ".sdata", 100),
                    (12, ".sdata", 128),
                    (16, ".sdata", 100),
                    (20, ".sdata", 124),
                    (24, ".sdata", 104),
                    (28, ".sdata", 124),
                    (32, ".sdata", 100),
                    (36, ".sdata", 100),
                    (40, ".sdata", 100),
                ),
                "payload_sha256": "4928a4a18f0461cb88491ca9716df8ac93fc30d61086a617ad02084cd3b44970",
                "masked_payload_sha256": "85759b3811ff7dc47b03792ac85317be51431a3f9e01dcafce317ed736a391b0",
                "resolved_payload_sha256": "8931ccfbea881cbc68cdd994ee5d5b62e3f0200e60c04f700d45edb6db61ea1b",
                "retained_raw_padding": {
                    "source": "asm/data/rdata_audiocmn_trackgenbank_padding.rodata.s",
                    "section": ".rodata",
                    "address": 2147833656,
                    "size": 4,
                    "payload_hex": "00000000",
                },
            },
        ),
    },
    {
        "source": "recon/game/psx/trackspec.cpp",
        "section": ".sdata",
        "address": 2148785040,
        "size": 12,
        "alignment": 4,
        "payload_sha256": "15ec7bf0b50732b49f8228e07d24365338f9e3ab994b00af08e5a3bffe55fd8b",
        "oracle_source": "asm/data/sdata_8013C54C_o35.sdata.s",
        "placement": "fragment",
        "symbols": (
            ("TrackSpec_gPrevSpec", 0, 4, 1, "exact"),
            ("TrackSpec_gCurrentSpec", 4, 4, 1, "exact"),
            ("TrackSpec_gMaxSpec", 8, 4, 1, "exact"),
        ),
        "assert_native_symbols": True,
        "record": "SYM47a9ed/47aa0e/47aa32 EXTINT;compact018d42/018d5b;threeCPE4-bytezero loads",
    },
    # P907: complete native GameSetup owner, including all three fixed-width
    # name arrays, one real alignment byte and the2600-byte aggregate. Both
    # exact raw copies remain src-only; the unrelated r09 prefix stays live.
    # One existing AIDataRecord field alias is explicit compatibility debt
    # in retail_data_symbols.ld, not an invented original C declaration.
    # Backups/full primary proof: scratchpad/p907_checkpoint / p907_gmesetup_owner.
    {
        "source": "recon/game/common/gmesetup.cpp",
        "section": ".data",
        "address": 2148610116,
        "size": 3024,
        "alignment": 4,
        "payload_sha256": "74365f5a02f2c685dfa2c2654cf4d357fab0003223a0b663ea299c6b839c06f4",
        "placement": "fragment",
        "symbols": (
            ("GameSetup_gCarNames", 0, 255, 1, "exact"),
            ("GameSetup_gTrackNames", 256, 48, 1, "exact"),
            ("GameSetup_gPersonalityNames", 304, 120, 1, "exact"),
            ("GameSetup_gData", 424, 2600, 1, "exact"),
        ),
        "oracle_sources": ("asm/data/data_8010CCD4_o20.data.s", "asm/data/data_gmesetup_names_legacy.data.s"),
        "assert_native_symbols": True,
        "record": "SYM2874b5/2874e4/287518/287544: 2600-byte GameSetup_tData and native CHAR[51][5]/[12][4]/[15][8]; full3024-byte source/raw/CPE/ROM run with1alignmentbyte",
    },
    # P910: whole HUD .data, including two real file-static needle tables.
    # Typed SYM names/widths and all668 source/ROM/CPE bytes are independently
    # verified. No initializer or compiler change. Backups: p910_hud_data.
    {
        'source': 'recon/game/psx/hud.cpp', 'section': '.data',
        'address': 0x80120924, 'size': 668, 'alignment': 4, 'section_flags': 3,
        'payload_sha256': '538ed944e8c319d72bd13437a4bdf939a5a667a16e4f481a35f49a1dff8ada26',
        'oracle_source': 'asm/data/data_hud_legacy.data.s', 'placement': 'fragment',
        'symbols': (
            ('Hud_gElementPositions',0,152,1,'exact'),
            ('day_needle',152,120,0,'exact'),
            ('night_needle',272,120,0,'exact'),
            ('Hud_Character',392,20,1,'exact'),
            ('fMapScaleX',412,44,1,'exact'),
            ('fMapScaleY',456,44,1,'exact'),
            ('fMapOffX',500,22,1,'exact'),
            ('fMapOffY',524,22,1,'exact'),
            ('fMapRotate',548,22,1,'exact'),
            ('Hud_gMarkerColor',572,48,1,'exact'),
            ('Hud_gCopMarkerColor',620,48,1,'exact'),
        ),
        'assert_native_symbols': ('Hud_gElementPositions','Hud_Character','fMapScaleX','fMapScaleY','fMapOffX','fMapOffY','fMapRotate','Hud_gMarkerColor','Hud_gCopMarkerColor'),
        'record': 'SYM424c6c..424ddc;9EXT+2STAT,662named+6alignment bytes; native668ROM/CPE80120924..80120BC0',
    },
    # P909: the complete native HUD initialized run, including four genuine
    # function statics and one file static. Preserve LOCAL storage; public
    # anchors place the whole240-byte source owner. Proof/backups: p909_hud_owner.
    {
        'source': 'recon/game/psx/hud.cpp', 'section': '.sdata',
        'address': 0x8013D89C, 'size': 240, 'alignment': 4,
        'section_flags': 0x10000003,
        'payload_sha256': '405c4c7605bf8fbe0ac36e35c5b066b50547750df6a49592b1311752e1232a81',
        'oracle_source': 'asm/data/sdata_hud_legacy.sdata.s', 'placement': 'fragment',
        'symbols': (
            ('HudminChar',0,6,1,'exact'),
            ('HudsecChar',8,6,1,'exact'),
            ('BTC_playedsoundalready',16,4,0,'exact'),
            ('Hud_gWingmanInterface',20,2,1,'exact'),
            ('Hud_gWingmanFlashIcon',24,2,1,'exact'),
            ('Hud_gWingmanFlashTicks',28,8,1,'exact'),
            ('Hud_gDebugInfo',36,4,1,'exact'),
            ('keepup',100,4,0,'uid'),
            ('oldCountdown',129,1,0,'uid'),
            ('lastsec',132,4,0,'uid'),
            ('lastsectick',136,4,0,'uid'),
            ('HudBustedOverlay',140,4,1,'exact'),
            ('Hud_gCdActive',144,4,1,'exact'),
            ('Hud_ActivateCDPlayer',148,4,1,'exact'),
            ('BTC_Countdown',152,4,1,'exact'),
            ('FinalBTC_Countdown',156,4,1,'exact'),
            ('Hud_BeTheCop',160,4,1,'exact'),
            ('Hud_kTurnSongOffNext',164,4,1,'exact'),
            ('HudBustedOverlayPlayer',168,2,1,'exact'),
            ('mapMarkerMCos',172,4,1,'exact'),
            ('mapMarkerMSin',176,4,1,'exact'),
            ('Hud_gHudView',180,8,1,'exact'),
            ('Hud_gMapView',188,8,1,'exact'),
            ('Hud_gTacView',196,8,1,'exact'),
            ('Hud_gStatsView',204,4,1,'exact'),
            ('HudMapOffsetY',208,4,1,'exact'),
            ('gMapRotate',212,4,1,'exact'),
            ('gMapScaleX',216,4,1,'exact'),
            ('gMapScaleY',220,4,1,'exact'),
            ('gMapOffX',224,4,1,'exact'),
            ('gMapOffY',228,4,1,'exact'),
            ('Hud_gCdLastTick',232,4,1,'exact'),
            ('Hud_gCdScrollTitle',236,4,1,'exact'),
        ),
        'assert_native_symbols': ('HudminChar', 'HudsecChar', 'Hud_gWingmanInterface', 'Hud_gWingmanFlashIcon', 'Hud_gWingmanFlashTicks', 'Hud_gDebugInfo', 'HudBustedOverlay', 'Hud_gCdActive', 'Hud_ActivateCDPlayer', 'BTC_Countdown', 'FinalBTC_Countdown', 'Hud_BeTheCop', 'Hud_kTurnSongOffNext', 'HudBustedOverlayPlayer', 'mapMarkerMCos', 'mapMarkerMSin', 'Hud_gHudView', 'Hud_gMapView', 'Hud_gTacView', 'Hud_gStatsView', 'HudMapOffsetY', 'gMapRotate', 'gMapScaleX', 'gMapScaleY', 'gMapOffX', 'gMapOffY', 'Hud_gCdLastTick', 'Hud_gCdScrollTitle'),
        'record': 'SYM424dfb..425153 +423264/423d18/423e8c/423ea1:28public+5LOCAL; full240ROM/CPE bytes8013D89C..8013D98C',
    },
    *(dict(source='recon/game/common/replay.cpp', section=section,
           address=address, size=size, alignment=4, payload_sha256=digest,
           oracle_source='asm/data/data_replay_legacy.data.s', placement='fragment',
           owner_group='replay_main', assert_native_symbols=True,
           record='SYM'+record+' typed EXT; exact native MAP/CPE initialized payload',
           symbols=((name,0,size,1,'exact'),))
      for name,section,address,size,digest,record in _REPLAY_DATA_RUN),
    # P912: complete CPE-loaded Collide registry array, not a BSS inference.
    # Native EXT21e793 is BO_tNewtonObj *[16] at 80110C30, 64 bytes.
    # Append to preserve every prior generated source_data_N output identity.
    # Protected backup, raw/type/reference and malformed controls: p912_collide_owner.
    {
        'source': 'recon/game/common/collide.cpp', 'section': '.data',
        'address': 0x80110C30, 'size': 64, 'alignment': 4, 'section_flags': 3,
        'payload': bytes(64),
        'symbols': (('Collide_gRegistry',0,64,1,'exact'),),
        'assert_native_symbols': True,
        'oracle_source': 'asm/data/data_8010CCD4_r07.data.s',
        'placement': 'fragment',
        'record': 'SYM21e793 EXT ARY PTR BO_tNewtonObj dims16; CPE-loaded64 bytes at80110C30..80110C70',
    },
    # P912: native Camera arrays after source initializer/order recovery.
    # Append without renumbering old source_data_N outputs. Five file-static
    # arrays remain LOCAL; only the five real public names get linker ASSERTs.
    # Complete SYM/CPE/source/relocation proof: p912_camera_data/p912_camera_peer.
    {
        'source': 'recon/game/common/camera.cpp', 'section': '.data',
        'address': 0x8010F2AC, 'size': 1404, 'alignment': 4, 'section_flags': 3,
        'payload_sha256': '1453efd48c72c8be4e6d894d70781d25cc389d00e43a124dd64f1100c040644e',
        'symbols': (
            ('Camera_gInfo',0,544,1,'exact'),
            ('gTunnelCamHeight',544,52,0,'exact'),
            ('gSplitCameras',596,12,0,'exact'),
            ('gAnimMode',608,13,0,'exact'),
            ('gAnimCams',624,52,0,'exact'),
            ('Camera_gFlags',676,304,1,'exact'),
            ('gDriverCam',980,336,0,'exact'),
            ('camSpeedTable',1316,28,1,'exact'),
            ('feeler3',1344,36,1,'exact'),
            ('Camera_gCopDist',1380,24,1,'exact'),
        ),
        'assert_native_symbols': ('Camera_gInfo','Camera_gFlags','camSpeedTable','feeler3','Camera_gCopDist'),
        'oracle_source': 'asm/data/data_8010CCD4_r06.data.s',
        'placement': 'fragment',
        'record': 'SYM1e97cc..1e991a; 10 typed arrays, full CPE-loaded 1404-byte run at8010F2AC..8010F828',
    },
    # P912: GenericPMX pointer arrays must have native declaration order;
    # zero payload alone cannot prove their identities. Preserve all seven
    # offsets/bindings after source recovery. Receipt: p912_genericpmx_order.
    {
        'source': 'recon/game/common/genericpmx.cpp', 'section': '.data',
        'address': 0x80112B2C, 'size': 1304, 'alignment': 4, 'section_flags': 3,
        'payload': bytes(1304),
        'symbols': (
            ('gDLPixmap',0,40,1,'exact'),('gSparkHPixmap',40,24,1,'exact'),
            ('gStartUpPixmap',64,16,1,'exact'),('gWeatherPixmap',80,12,1,'exact'),
            ('gFlarePixmap',92,12,1,'exact'),('gLightningPixmap',104,64,1,'exact'),
            ('gPixmaps',168,1136,1,'exact'),
        ),
        'assert_native_symbols': True,
        'oracle_source': 'asm/data/data_8010CCD4_r09.data.s',
        'placement': 'fragment',
        'record': 'SYM27bd72..27be86; seven native EXT arrays at80112B2C..80113044, 1304 CPE-loaded zero bytes',
    },
    # P913: complete native HrzSku arrays/struct, already correctly ordered
    # in source. Preserve the adjacent HUD/Night data and raw src oracle.
    # Typed records, CPE, references and protected backup: p913_hrzsku_owner.
    {
        'source': 'recon/game/psx/hrzsku.cpp', 'section': '.data',
        'address': 0x801202F8, 'size': 1580, 'alignment': 4, 'section_flags': 3,
        'payload': bytes(1580),
        'symbols': (
            ('gHorizonPixmap',0,64,1,'exact'),
            ('gHorizonExtraSkyPixmaps',64,64,1,'exact'),
            ('gSkyMesh',128,680,1,'exact'),
            ('gSkyColor',808,340,1,'exact'),
            ('gSkyPixmapIndex',1148,64,1,'exact'),
            ('gpPmx',1212,64,1,'exact'),
            ('gHrzRingColor',1276,136,1,'exact'),
            ('gfxPmxHeightPercentage',1412,64,1,'exact'),
            ('gHrz_Lightning',1476,104,1,'exact'),
        ),
        'assert_native_symbols': True,
        'oracle_source': 'asm/data/data_hrzsku_legacy.data.s',
        'placement': 'fragment',
        'record': 'SYM40f50b..40f65d; nine native EXT objects, 1580 CPE-loaded bytes at801202F8..80120924',
    },
    # P914: source/native declarations and default-threshold recovery restore
    # the complete DrawW data runs; no per-symbol padding or asm views.
    # Backups, SYM/CPE, reference and full-TU proofs: p914_draww_storage.
    {
        'source': 'recon/game/psx/draww.cpp', 'section': '.data',
        'address': 0x8011F570, 'size': 1776, 'alignment': 4, 'section_flags': 3,
        'payload_sha256': '256d50ad0b68b6f2a0d0396714f2d1c7422caf2a93bcbe0d73ef042e79d16088',
        'symbols': (
            ('gIdentTemplate',0,32,1,'exact'),('trk0',32,72,1,'exact'),
            ('trk4',104,80,1,'exact'),('gDiv',184,240,1,'exact'),
            ('animation_timer',424,48,1,'exact'),('gChunkObjInfo',472,24,1,'exact'),
            ('gVertex3d',496,1280,1,'exact'),
        ),
        'assert_native_symbols': True,
        'oracle_source': 'asm/data/data_draww_legacy.data.s',
        'placement': 'fragment',
        'record': 'SYM3e648e..3e656d; seven EXT objects at8011F570..8011FC60, full1776 CPE bytes',
    },
    {
        'source': 'recon/game/psx/draww.cpp', 'section': '.sdata',
        'address': 0x8013D81C, 'size': 36, 'alignment': 4, 'section_flags': 0x10000003,
        'payload_sha256': 'ce6ebb2bf328b7e3f170da7ef033fe4b3a004b166e60560ff63a7b499068bbdc',
        'symbols': (
            ('stackSpeedUpEnbabledFlag',0,4,1,'exact'),('goffsets',4,8,0,'exact'),
            ('offsets',12,8,0,'uid'),('gWSavePtr',20,4,1,'exact'),
            ('gSD_gt4counter',24,4,1,'exact'),('gSD_gt3counter',28,4,1,'exact'),
            ('gVi',32,4,1,'exact'),
        ),
        'assert_native_symbols': ('stackSpeedUpEnbabledFlag','gWSavePtr','gSD_gt4counter','gSD_gt3counter','gVi'),
        'oracle_source': 'asm/data/sdata_8013C54C_r18.sdata.s',
        'placement': 'fragment',
        'record': 'SYM3e6620 file STAT goffsets;3e42a2 function STAT offsets at+12; five EXT cells, full36 CPE bytes',
    },
)


def object_path(source, object_root=None):
    return (object_root or ROOT/'build') / (source+'.o')


def oracle_only_objects(object_root=None):
    # P896: one complete source owner may replace several explicitly named
    # raw pieces. Preserve every old single-source row; never use a wildcard.
    result = set()
    for row in SOURCE_DATA_OWNERS:
        sources = row.get('oracle_sources')
        if sources is None:
            sources = (row['oracle_source'],)
        assert sources and len(sources) == len(set(sources)), row
        result.update(object_path(source, object_root).resolve() for source in sources)
        # P907: auxiliary compiler-data windows are checks, never extra source
        # selectors. Exclude their exact raw copies only after full validation.
        for window in row.get('auxiliary_windows', ()):
            result.add(object_path(window['oracle_source'], object_root).resolve())
    return result


def source_auxiliary_windows():
    """P907 explicit non-owning windows; caller must validate owners first."""
    return tuple(window for row in SOURCE_DATA_OWNERS for window in row.get('auxiliary_windows', ()))


def _validate_exact_rel32_owner(data, headers, labels, index, payload, row, obj):
    """P906 exact symbolic pointer map, never a generic relocation waiver.

    Frozen native SYM/MAP/CPE/ROM records establish target bases and each
    field's symbol/addend. A private verifier buffer is resolved solely to
    compare hashes; no object, relocation or linked output is rewritten.
    """
    from collections import Counter
    assert struct.unpack_from('<HHI',data,16) == (1,8,1), (obj,'R_MIPS_32 contract requires a MIPS ET_REL object')
    assert headers[index][1] == 1 and headers[index][2] == 3
    expected = tuple(tuple(x) for x in row['relocations32'])
    assert expected and len({x[0] for x in expected}) == len(expected)
    assert all(len(x) == 3 and x[0] % 4 == 0 and 0 <= x[0] <= len(payload)-4 for x in expected)
    target_rows = tuple(tuple(x) for x in row['relocation_targets'])
    assert target_rows and len({x[0] for x in target_rows}) == len(target_rows)
    targets = {name:(address,size) for name,address,size in target_rows}
    assert all(name in targets and 0 <= addend and addend+4 <= targets[name][1]
               for _,name,addend in expected)
    symindex = labels.index('.symtab'); symtab = headers[symindex]
    assert symtab[1] == 2 and symtab[9] == 16 and symtab[5] % 16 == 0
    strings_header = headers[symtab[6]]
    assert strings_header[1] == 3
    strings = data[strings_header[4]:strings_header[4]+strings_header[5]]
    symbols = []
    for at in range(symtab[4],symtab[4]+symtab[5],16):
        n,v,z,info,other,section = struct.unpack_from('<IIIBBH',data,at)
        assert n < len(strings)
        symbols.append((strings[n:].split(b'\0')[0].decode(),v,z,info,other,section))
    # P906 negative control: a byte-identical table with hidden owner
    # visibility is not the same public source declaration. Preserve st_other
    # here; the older generic symbol tuples do not retain that field.
    assert row.get('symbols'), (obj,'pointer owner requires an exact storage-symbol contract')
    for name,value,size,bind,mode in row['symbols']:
        assert mode == 'exact'
        matches = [s for s in symbols if s[0] == name]
        assert len(matches) == 1
        n,v,z,info,other,section = matches[0]
        assert v == value and z in (0,size) and info>>4 == bind and info&15 in (0,1) and other == 0 and section == index, (obj,'pointer owner symbol mismatch')
    for name in targets:
        matches = [s for s in symbols if s[0] == name]
        assert matches == [(name,0,0,16,0,0)], (obj,name,'pointer target must be exact GLOBAL undefined data')
    relsections = [h for h in headers if h[1] in (4,9) and h[7] == index]
    assert relsections, (obj,'missing required data relocations')
    actual = []; seen = set()
    for h in relsections:
        assert h[1] == 9 and h[9] == 8 and h[5] % 8 == 0 and h[6] == symindex, (obj,'unsupported relocation section')
        for at in range(h[4],h[4]+h[5],8):
            offset,info = struct.unpack_from('<II',data,at)
            assert info & 255 == 2, (obj,'only exact R_MIPS_32 pointers are accepted')
            assert offset % 4 == 0 and 0 <= offset <= len(payload)-4 and offset not in seen, (obj,'duplicate/invalid relocation position')
            seen.add(offset)
            assert info >> 8 < len(symbols)
            name = symbols[info >> 8][0]
            addend = struct.unpack_from('<I',payload,offset)[0]
            actual.append((offset,name,addend))
    assert Counter(actual) == Counter(expected), (obj,'native per-field pointer target/addend mismatch')
    masked = bytearray(payload); resolved = bytearray(payload)
    for offset,name,addend in actual:
        masked[offset:offset+4] = b'\0'*4
        value = targets[name][0] + addend
        assert 0 <= value <= 0xffffffff
        struct.pack_into('<I',resolved,offset,value)
    assert hashlib.sha256(masked).hexdigest() == row['masked_payload_sha256'], (obj,'nonpointer/null payload mismatch')
    assert hashlib.sha256(resolved).hexdigest() == row['resolved_payload_sha256'], (obj,'resolved payload differs from native CPE/ROM')


def validate_source_data_owners(object_root=None):
    """Check exact owner data and real global/local symbols, not only filenames."""
    # P906: never retire the entire raw Replay leaf after checking only a
    # subset of its eight typed members. Guard native continuity, exact
    # membership, and the documented three alignment bytes separately.
    replay = [r for r in SOURCE_DATA_OWNERS if r.get('owner_group') == 'replay_main']
    assert len(replay) == len(_REPLAY_DATA_RUN) == 8, 'incomplete Replay data owner group'
    cursor, padding = 0x80117008, 0
    for row,(name,section,address,size,digest,record) in zip(replay,_REPLAY_DATA_RUN):
        aligned = (cursor + 3) & ~3
        padding += aligned - cursor
        assert row['source'] == 'recon/game/common/replay.cpp'
        assert (row['section'],row['address'],row['size'],row['payload_sha256']) == (section,address,size,digest)
        assert row['symbols'] == ((name,0,size,1,'exact'),) and address == aligned
        assert row['oracle_source'] == 'asm/data/data_replay_legacy.data.s'
        assert row['placement'] == 'fragment' and row['assert_native_symbols'] and row['alignment'] == 4
        cursor = address + size
    assert cursor == 0x8011DFDC and padding == 3, 'Replay native extent/alignment drift'
    # P907: same-TU section pointers have a separate strict opt-in validator.
    # Their relocation-free target sections must validate before those rows;
    # FEI's existing GLOBAL-UNDEF helper is not relaxed or reused for them.
    keys=[(r['source'],r['section']) for r in SOURCE_DATA_OWNERS]
    assert len(keys)==len(set(keys)), 'duplicate source owner section'
    assert all(r.get('relocation_target_mode') in (None,'validated_same_tu_section') for r in SOURCE_DATA_OWNERS)
    for row in SOURCE_DATA_OWNERS:
        if row.get('relocation_target_mode') == 'validated_same_tu_section':
            continue
        obj = object_path(row['source'], object_root)
        assert obj.is_file(), f'{obj}: rebuild the source-data owner before linking'
        data = obj.read_bytes()
        assert data[:6] == b'\x7fELF\x01\x01', f'{obj}: expected little-endian ELF32'
        off = struct.unpack_from('<I', data, 32)[0]
        width, count, names_index = struct.unpack_from('<HHH', data, 46)
        headers = [struct.unpack_from('<10I', data, off+i*width) for i in range(count)]
        sh = headers[names_index]
        names = data[sh[4]:sh[4]+sh[5]]
        labels = [names[h[0]:].split(b'\0')[0].decode() for h in headers]
        # P896 negative controls: do not silently select the first of two
        # same-named sections and ignore another storage contribution.
        assert len(labels) == len(set(labels)), (obj, 'duplicate section names')
        index = labels.index(row['section'])
        section = headers[index]
        # P909: optional exact flags close the HUD GPREL/MERGE metadata gaps.
        # Existing owners without this key keep their established contracts.
        # Backups and adversarial controls: scratchpad/p909_hud_owner.
        if 'section_flags' in row:
            assert section[2] == row['section_flags'], (obj, 'source owner exact section flags')
        # P904: an opted-in input alignment contract, independent of the
        # linker's SUBALIGN. No legacy owner is silently exempted or relaxed.
        if 'alignment' in row:
            assert section[8] == row['alignment'], (obj, 'source owner input alignment')
        payload = data[section[4]:section[4]+section[5]]
        payload_ok = (payload == row['payload'] if 'payload' in row
                      else hashlib.sha256(payload).hexdigest() == row['payload_sha256'])
        assert section[5] == row['size'] and payload_ok, (
            obj, 'source-owned data layout/payload is stale or not native', row['record'])
        if 'relocations32' in row:
            # P906: pin unresolved bytes/addends above, then every exact
            # pointer and the fully native resolved payload. Not an exemption.
            _validate_exact_rel32_owner(data,headers,labels,index,payload,row,obj)
        else:
            # The default remains relocation-free. Pointer-bearing data can
            # opt in only with a nonempty, complete native per-field contract.
            assert section[1] == 1 and all(h[5] == 0 for h in headers
                                         if h[1] in (4,9) and h[7] == index), (
                obj, 'unexpected data relocation in exact raw owner')
        if 'global' not in row and 'symbols' not in row:
            continue
        symtab = headers[labels.index('.symtab')]
        strings_header = headers[symtab[6]]
        strings = data[strings_header[4]:strings_header[4]+strings_header[5]]
        syms = []
        for at in range(symtab[4], symtab[4]+symtab[5], symtab[9]):
            name, value, size, info, other, owner = struct.unpack_from('<IIIBBH', data, at)
            # P907: retain visibility in exact owner checks, not merely in
            # the special pointer-table helper. Hidden/protected storage is
            # not the same public/file-local declaration even if bytes match.
            if owner == index and ('symbols' in row or 'global' in row):
                assert other == 0, (obj, 'source owner storage visibility mismatch')
            syms.append((strings[name:].split(b'\0')[0].decode(), value, size, info, owner))
        # PsyQ data labels normally reach ELF as NOTYPE/size0; the exact
        # eight-byte payload plus offsets bound both cells. Size4 is accepted
        # too when an assembler preserves object-size metadata. Source/-g
        # declaration checks establish INT separately, not this layout check.
        if 'global' in row:
            assert any(n == row['global'] and v == 0 and s in (0,4) and info>>4 == 1 and own == index
                       for n,v,s,info,own in syms), (obj, 'missing native global at data+0')
            assert sum(n.startswith(row['static']+'.') and v == 4 and s in (0,4) and info>>4 == 0 and own == index
                       for n,v,s,info,own in syms) == 1, (obj, 'missing unique function-local static at data+4')
        if 'symbols' in row:
            # Check every storage symbol, including duplicate local names.
            # A numeric UID is compiler metadata, not the source identity.
            # This allowance is restricted to explicit LOCAL data contracts.
            assert section[2]&7 == 3, (obj, 'mutable owner must be allocated/writable/non-executable')
            storage = [s for s in syms if s[4] == index and s[3]&15 != 3]
            assert all(s[3]&15 in (0,1) for s in storage), (obj, 'non-data symbol in exact data owner')
            assert len(storage) == len(row['symbols']), (obj, 'unexpected owner storage symbols')
            for name,value,size,bind,mode in row['symbols']:
                assert mode in ('exact','uid') and (mode != 'uid' or bind == 0)
                matched = [s for s in storage if
                           (s[0] == name if mode == 'exact' else
                            re.fullmatch(re.escape(name)+r'\.\d+',s[0])) and
                           s[1] == value and s[2] in (0,size) and s[3]>>4 == bind]
                assert len(matched) == 1, (obj,name,'missing exact source offset/size/binding')
    local_rows=[r for r in SOURCE_DATA_OWNERS if r.get('relocation_target_mode')=='validated_same_tu_section']
    if local_rows:
        from source_section_owners import read_owner_image,validate_target_owner,validate_same_tu_section_owner
        placement=json.loads((ROOT/'linkers/nfs4_recon.rodata_placement.json').read_text())
        lookup={(r['source'],r['section']):r for r in SOURCE_DATA_OWNERS}
        for row in local_rows:
            image=read_owner_image(object_path(row['source'],object_root))
            validated=[]
            for section,address,size,digest in row['local_section_targets']:
                target=lookup.get((row['source'],section))
                assert target is not None and not target.get('relocation_target_mode') and 'relocations32' not in target, 'unvalidated/cyclic local section target'
                validate_target_owner(image,target,validated)
            validate_same_tu_section_owner(image,row,validated,placement)
            for window in row.get('auxiliary_windows',()):
                assert window['source']==row['source'] and window['auxiliary_readonly_window']
                assert tuple(window['local_section_targets'])==tuple(row['local_section_targets'])
                validate_same_tu_section_owner(image,window,validated,placement)
                padding=window.get('retained_raw_padding')
                if padding:
                    assert padding['address']==window['address']+window['size']
                    raw=read_owner_image(object_path(padding['source'],object_root))
                    h=raw['sections'][padding['section']]
                    assert h[1]==1 and h[2]==2 and h[5]==padding['size'] and h[8]==4
                    assert raw['data'][h[4]:h[4]+h[5]]==bytes.fromhex(padding['payload_hex'])
                    assert not raw['relocations']
