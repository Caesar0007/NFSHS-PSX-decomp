"""P887 native zero-storage owners, distinct from initialized data payloads.

No bytes are read at a NOBITS file offset and no ROM-zero hash is invented.
Source section type/extent, actual local/global symbol offsets and independently
proved native addresses establish these reservations. Only linker placement is
generated; no source instruction, object or relocation is rewritten.
Backups/primary archive/raw-reference receipts: scratchpad/p887_iso.
"""
from pathlib import Path
import re
import struct

ROOT=Path(__file__).resolve().parents[1]
SOURCE_ZERO_OWNERS=(
    dict(source='recon/syslib/psx/libcd/C_005.c',section='.bss.st_80144874',
         address=0x80144874,size=8,output='.cd_stream_a',
         symbols=(('StFunc1',0,4,1),('StFunc2',4,4,1)),
         evidence='PsyQ4.3 C_005 XBSS4+4, native SYM/MAP and raw stream references'),
    dict(source='recon/syslib/psx/libcd/iso9660.c',section='.bss',
         address=0x8014487C,size=9216,output='.iso9660_bss',
         symbols=(('file',0,1536,0),('dire',1536,5632,0),('load_buf',7168,2048,0)),
         evidence='PsyQ4.3 BSS9216; SDK4.0 local names/offsets; all21 raw HI/LO pairs'),
    dict(source='recon/syslib/psx/libcd/CDROM.c',section='.bss.st_80146C7C',
         address=0x80146C7C,size=72,output='.cd_stream_b',
         symbols=tuple((name,4*i,2 if name=='Stsector_offset' else 4,1)
                       for i,name in enumerate(('StEmu_Addr','StCdIntrFlag','CChannel','StCHANNEL',
                           'Stframe_no','StRgb24','StEndFrame','StSTART_FLAG','StEmu_Idx',
                           'Stsector_offset','StFinalSector','StRingBase','StRingAddr','StRingIdx1',
                           'StRingIdx2','StRingIdx3','StRingSize','StStartFrame'))),
         evidence='PsyQ4.3 CDROM XBSS set; native SYM/MAP;70 reserved bytes plus2 alignment bytes'),
    # P896: AI's real local BWorldSm_Pos, not an invented reservation at its
    # former catch-all address. Source/static/compact SYM and all six raw
    # reference words prove the exact native132-byte span. Backups and linker
    # nonregression: scratchpad/p896_checkpoint/backups, p896_ai_storage.
    dict(source='recon/game/common/ai.cpp',section='.bss',
         address=0x8013DEE0,size=132,output='.ai_spos',
         symbols=(('spos',0,132,0),),local_uid_stems=('spos',),exact_symbols=True,
         evidence='SYM032be1 STAT BWorldSm_Pos; compact019911 spos.118 at8013DEE0; next native global8013DF64'),
)


def validate_source_zero_owners(object_root=None):
    """Fail closed on absent, resized, initialized, relocated or renamed BSS."""
    object_root=object_root or ROOT/'build'
    for row in SOURCE_ZERO_OWNERS:
        obj=object_root/(row['source']+'.o')
        assert obj.is_file(),f'{obj}: rebuild zero-data owner before linking'
        data=obj.read_bytes()
        assert data[:6]==b'\x7fELF\x01\x01',obj
        offset=struct.unpack_from('<I',data,32)[0]
        stride,count,names_index=struct.unpack_from('<HHH',data,46)
        headers=[struct.unpack_from('<10I',data,offset+i*stride) for i in range(count)]
        sh=headers[names_index]; names=data[sh[4]:sh[4]+sh[5]]
        labels=[names[h[0]:].split(b'\0')[0].decode() for h in headers]
        # P896 negative control: a duplicate .bss must not be ignored by index().
        assert len(labels)==len(set(labels)),(obj,'duplicate section names')
        index=labels.index(row['section']);section=headers[index]
        assert section[1]==8 and section[5]==row['size'],(obj,row['section'],'expected exact NOBITS extent')
        assert section[2]&7==3,(obj,'BSS must be allocated/writable/non-executable')
        assert all(h[5]==0 for h in headers if h[1] in (4,9) and h[7]==index),(obj,'unexpected BSS relocation')
        st=headers[labels.index('.symtab')]; sh=headers[st[6]]
        strings=data[sh[4]:sh[4]+sh[5]];symbols=[]
        for at in range(st[4],st[4]+st[5],st[9]):
            n,v,z,info,other,si=struct.unpack_from('<IIIBBH',data,at)
            symbols.append((strings[n:].split(b'\0')[0].decode(),v,z,info>>4,si,info&15))
        for name,value,size,bind in row['symbols']:
            uid=name in row.get('local_uid_stems',())
            assert not uid or bind==0,(obj,name,'UID stem must be LOCAL')
            assert sum((bool(re.fullmatch(re.escape(name)+r'\.\d+',n)) if uid else n==name)
                       and v==value and z in (0,size) and b==bind and si==index and typ in (0,1)
                       for n,v,z,b,si,typ in symbols)==1,(obj,name,'missing native source offset/binding')
        if row.get('exact_symbols'):
            defined=[s for s in symbols if s[4]==index and s[5]!=3]
            assert all(s[5] in (0,1) for s in defined),(obj,'non-data symbol in exact zero owner')
            assert len(defined)==len(row['symbols']),(
                obj,'unexpected additional zero-owner storage symbol')
