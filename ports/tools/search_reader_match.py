"""Ordinary-C reader/seed ABI probes under actual retail PsyQ C compilers.

No main source changes and no instruction rewriting. Failed sources remain
compiler scratch artifacts. An exact body still needs runtime/domain checks
before becoming an accepted variant.
"""
from pathlib import Path
import json
from search_psx_match import ROOT,PORTS,HEADERS,compile_candidate,bld

def main():
    work=PORTS/'build/reader_search';work.mkdir(parents=True,exist_ok=True)
    inc=work/'include';inc.mkdir(exist_ok=True)
    for name,text in HEADERS.items():(inc/name).write_text(text)
    compilers={'psyq40':Path('C:/Temp/nfs3-clean/psyq400/COMPILER/CC1PSX.EXE'),
               'psyq43':bld.CC1,'psyq44':Path('C:/Temp/psq44/pssn/bin/CC1PSX.EXE')}
    variants={}
    packed='typedef struct { uint32_t value; } __attribute__((packed)) Word;\n'
    for arg_type in ('uint32_t','unsigned char'):
        for mask in (False,True):
            for style in ('local_shift','mutate_count'):
                if style=='local_shift':
                    body='uint32_t word=((const Word *)p)->value; uint32_t shift=32u-count*8u;'
                    if mask:body+='shift &=31u;'
                    body+='return (word<<shift)>>shift;'
                else:
                    body='uint32_t word=((const Word *)p)->value; count=32u-count*8u;'
                    if mask:body+='count &=31u;'
                    body+='word <<= count; return word>>count;'
                key=f'geti_{arg_type.replace(" ","_")}_{mask}_{style}'
                variants[key]=('geti',packed+f'uint32_t nfs4_match_geti(const void *p,{arg_type} count){{{body}}}',{})
    variants['getm_split']=('getm','''uint32_t nfs4_match_getm(const unsigned char *p,int32_t n) {
      uint32_t first=p[0],result=first<<8; int32_t delta=(int32_t)((uint32_t)n-3u);
      if(delta>=0){uint32_t second=p[1]; result|=second;
        if(delta==0) return (result<<8)|p[2];
        return (result<<16)|((uint32_t)p[2]<<8)|p[3];
      }else{uint32_t second=p[1]; if((int32_t)((uint32_t)n-2u)<0)return first;
        return result|second;}}''',{})
    variants['getm_fallback']=('getm','''uint32_t nfs4_match_getm(const unsigned char *p,int32_t n){
      if((int32_t)((uint32_t)n-3u)<0){if((int32_t)((uint32_t)n-2u)>=0)
        return ((uint32_t)p[0]<<8)|p[1];return p[0];}
      if(n!=3)return ((uint32_t)p[0]<<24)|((uint32_t)p[1]<<16)|((uint32_t)p[2]<<8)|p[3];
      return ((uint32_t)p[0]<<16)|((uint32_t)p[1]<<8)|p[2];}''',{})
    for direction in ('one_first','two_first'):
        short_read=('if(delta<0)return first; result|=second; return result;'
                    if direction=='one_first' else
                    'if(delta>=0){result|=second;return result;}return first;')
        variants['getm_oracle_'+direction]=('getm','''uint32_t nfs4_match_getm(const unsigned char *p,int32_t n){
          uint32_t first,second,third,fourth,result;int32_t delta;
          first=p[0];delta=(int32_t)((uint32_t)n-3u);result=first<<8;
          if(delta<0)goto small;
          second=p[1];result|=second;
          if(delta==0)goto three;
          third=p[2];fourth=p[3];result<<=16;third<<=8;third|=fourth;
          result|=third;return result;
        three:third=p[2];result<<=8;result|=third;return result;
        small:second=p[1];delta=(int32_t)((uint32_t)n-2u);'''+short_read+'}',{})
    for result_style in ('early','funnel'):
        body='if(index<file[2]) return (const unsigned char *)file+file[5+index*2]; return 0;'
        if result_style=='funnel':body='const unsigned char *result=0;if(index<file[2]) result=(const unsigned char *)file+file[5+index*2];return result;'
        variants['shapepointer_'+result_style]=('shapepointer',
            'const unsigned char *nfs4_match_shapepointer(const uint32_t *file,uint32_t index){'+body+'}',{})
    variants['seedrandom_unrolled']=('seedrandom','''extern uint32_t match_seed[6];
      void nfs4_match_seedrandom(uint32_t value){uint32_t *state=match_seed;
        value+=0xF22D0E56U;state[0]=value;
        value+=0x96041893U;state[1]=value;
        value+=0x3DF3B646U;state[2]=value;
        value+=0x40DDE76DU;state[3]=value;
        value+=0x97327AE1U;state[4]=value;
        value+=0xD1A9FBE7U;state[5]=value;}''',{'match_seed':0x8012349C})
    results=[]
    for lane,compiler in compilers.items():
        if not compiler.is_file():continue
        for key,(retail,source,bindings) in variants.items():
            try:
                row=compile_candidate(work,lane+'_'+key,source,retail,
                                      compiler_path=compiler,extern_addresses=bindings)
                row['domain_note']='unmasked geti shift forms are restricted to byte counts 1..4' if retail=='geti' and '_False_' in key else 'normal valid RAM inputs'
                results.append(row)
            except RuntimeError as error:
                results.append({'probe':lane+'_'+key,'retail':retail,'compile_error':str(error)})
    path=PORTS/'verification/reader_search.json'
    path.write_text(json.dumps({'probes':results,'scope':'reader representations and original-ABI seeding; not a completed search or impossibility certificate'},indent=2)+'\n')
    for retail in sorted({r['retail'] for r in results}):
        candidates=[r for r in results if r['retail']==retail and 'compile_error' not in r]
        if candidates:print(json.dumps({'retail':retail,'probes':len(candidates),
                       'best':min(candidates,key=lambda r:r['word_edit_distance'])}))
    print(path)

if __name__=='__main__':main()
