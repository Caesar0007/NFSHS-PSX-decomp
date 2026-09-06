/* P875 member APIs: compile-only pointers and constructor/destructor calls. */
#include "C:/Temp/nfs4-decomp/recon/game/common/anim.h"
AnimScript *p875_common2_member_anim_0(int num) { return new AnimScript(num); }
AnimScript *p875_common2_member_anim_1(int num,int numParts) { return new AnimScript(num,numParts); }
AnimScript *p875_common2_member_anim_2(Group *instanceGroup,int type,int boomIndex,int numParts) { return new AnimScript(instanceGroup,type,boomIndex,numParts); }
void (AnimScript::*p875_common2_member_anim_3)(int) = (void (AnimScript::*)(int))&AnimScript::SetAnimAttrib;
void (AnimScript::*p875_common2_member_anim_4)(int *,int *) = (void (AnimScript::*)(int *,int *))&AnimScript::GetAnimFrameInfo;
int (AnimScript::*p875_common2_member_anim_5)(coorddef *,matrixtdef *) = (int (AnimScript::*)(coorddef *,matrixtdef *))&AnimScript::GetTimedAnimPosRot;
int (AnimScript::*p875_common2_member_anim_6)(int,coorddef *,matrixtdef *) = (int (AnimScript::*)(int,coorddef *,matrixtdef *))&AnimScript::GetTimedAnimPosRot;
int (AnimScript::*p875_common2_member_anim_7)(void) = (int (AnimScript::*)(void))&AnimScript::GetStatus;
