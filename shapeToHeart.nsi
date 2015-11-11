SetCompressor /SOLID lzma
SetCompressorDictSize 32

XPStyle on
SilentInstall silent
;Icon "heart.ico"

;!include "nsDialogs_CommCtrl.nsh"
;!include "Win\WinDef.nsh"

OutFile "heart.exe"
Caption "提示"

Var x
Var y

!macro CountItemPos io na
	${If} ${na} < 5
		Math::Script "r=140; x=205; y=240; n=${io}+0.1; \
					  NS=x+r*cos(n); NS=y-r*sin(n)"
	${ElseIf} ${na} > 4
	${AndIf} ${na} < 9
		Math::Script "r=290; x=340; y=245; n=7.8+${io}*0.5; \
				  	  NS=x+r*cos(n); NS=y-r*sin(n)"
	${ElseIf} ${na} = 9
	    Push 348
	    Push 555
	${ElseIf} ${na} > 9
	${AndIf} ${na} < 14
		Math::Script "r=290; x=360; y=242; n=14.01+${io}*0.5; \
				      NS=x+r*cos(n); NS=y-r*sin(n)"
	${ElseIf} ${na} > 13
	${AndIf} ${na} < 18
		Math::Script "r=140; x=500; y=240; n=2.75+${io}; \
				      NS=x+r*cos(n); NS=y-r*sin(n)"
	${ElseIf} ${na} > 17
		Math::Script "x=0; y=0; nc=${na}*70-16*70; \
				      NS=x+nc; NS=y"
	${EndIf}
	Sleep 500
!macroend


Section
	FindWindow $0 "Progman" "Program Manager"
	FindWindow $0 "SHELLDLL_DefView" "" $0
	GetDlgItem $1 $0 1
	SendMessage $1 ${LVM_GETITEMCOUNT} 0 0 $2
	IntCmp $2 18 +3 0 +3
	MessageBox MB_ICONINFORMATION|MB_OK "桌面图标过少，不能实现！"
	Quit
	SendMessage $1 ${LVM_SETEXTENDEDLISTVIEWSTYLE} ${LVS_EX_SNAPTOGRID} 0
	${NSD_RemoveStyle} $1 ${LVS_AUTOARRANGE}
	IntOp $2 $2 - 1
	${For} $0 0 $2
	    Math::Script /NOUNLOAD "r3=r0/1.4"
		!insertmacro CountItemPos $3 $0
		Pop $y
		Pop $x
		${MAKELPARAM} $3 $x $x $y
	    SendMessage $1 ${LVM_SETITEMPOSITION} $0 $3
	${Next}
SectionEnd
