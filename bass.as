
#ifndef __BASS__
#define __BASS__
#uselib "bass.dll"

	#cfunc BASS_GetVersion "BASS_GetVersion"
	#func  BASS_Init "BASS_Init" int, int, int ,int, int
	#func  BASS_Free onexit "BASS_Free"
	#cfunc BASS_StreamCreateFile "BASS_StreamCreateFile" int, sptr, int,int, int,int, int
	#func  BASS_StreamFree "BASS_StreamFree" int
	#func  BASS_ChannelPlay "BASS_ChannelPlay" int, int
	#func  BASS_FXSetParameters "BASS_FXSetParameters" int, var
	#cfunc BASS_ChannelSetFX "BASS_ChannelSetFX" int, int, int
	#func BASS_FXReset "BASS_FXReset" int
	#func BASS_ChannelRemoveFX "BASS_ChannelRemoveFX" int,int

	#cfunc BASS_ErrorGetCode "BASS_ErrorGetCode"

	#func BASS_GetCPU "BASS_GetCPU"
	#func BASS_Pause "BASS_Pause"
	#func BASS_Start "BASS_Start"
	#cfunc BASS_GetVolume "BASS_GetVolume"
	#func BASS_SetVolume "BASS_SetVolume" int

	#cfunc BASS_SampleLoad "BASS_SampleLoad" int, sptr, int, int, int, int, int
	#cfunc BASS_SampleGetChannel "BASS_SampleGetChannel" int, int
	#func BASS_SampleStop "BASS_SampleStop" int
	#func BASS_SampleFree "BASS_SampleFree" int
	#func BASS_ChannelPause "BASS_ChannelPause" int
	#func BASS_ChannelStop "BASS_ChannelStop" int
	#func BASS_ChannelSetAttribute "BASS_ChannelSetAttribute" sptr,sptr,sptr
	#func BASS_ChannelGetLength "BASS_ChannelGetLength" sptr,sptr
	#cfunc BASS_ChannelBytes2Seconds "BASS_ChannelBytes2Seconds" sptr, sptr
	#func BASS_ChannelIsActive "BASS_ChannelIsActive" int
	#cfunc BASS_ChannelGetPosition "BASS_ChannelGetPosition" sptr,sptr
	#func BASS_ChannelSetPosition "BASS_ChannelSetPosition" sptr,sptr,sptr,sptr
	#cfunc BASS_ChannelSeconds2Bytes "BASS_ChannelSeconds2Bytes" sptr,double
	#func BASS_ChannelGetData "BASS_ChannelGetData" sptr,sptr,sptr

	#define BASS_SAMPLE_8BITS		1		// 8 bit
	#define BASS_SAMPLE_FLOAT		256		// 32 bit floating-point
	#define BASS_SAMPLE_MONO			2		// mono
	#define BASS_SAMPLE_LOOP			4		// looped
	#define BASS_SAMPLE_3D			8		// 3D functionality
	#define BASS_SAMPLE_SOFTWARE		16		// not using hardware mixing
	#define BASS_SAMPLE_MUTEMAX		32		// mute at max distance (3D only)
	#define BASS_SAMPLE_VAM			64		// DX7 voice allocation & management
	#define BASS_SAMPLE_FX			128		// old implementation of DX8 effects
	#define BASS_SAMPLE_OVER_VOL		0x10000	// override lowest volume
	#define BASS_SAMPLE_OVER_POS		0x20000	// override longest playing
	#define BASS_SAMPLE_OVER_DIST		0x30000	// override furthest from listener (3D only)

	// BASS_ChannelSetFX effect types
	#define BASS_FX_DX8_CHORUS			0
	#define BASS_FX_DX8_COMPRESSOR		1
	#define BASS_FX_DX8_DISTORTION		2
	#define BASS_FX_DX8_ECHO				3
	#define BASS_FX_DX8_FLANGER			4
	#define BASS_FX_DX8_GARGLE			5
	#define BASS_FX_DX8_I3DL2REVERB		6
	#define BASS_FX_DX8_PARAMEQ			7
	#define BASS_FX_DX8_REVERB			8
	#define BASS_FX_VOLUME				9

	#define BASS_DX8_PHASE_NEG_180		0
	#define BASS_DX8_PHASE_NEG_90			1
	#define BASS_DX8_PHASE_ZERO			2
	#define BASS_DX8_PHASE_90			3
	#define BASS_DX8_PHASE_180			4

	//Channel Attributes
	#define BASS_ATTRIB_FREQ				1
	#define BASS_ATTRIB_VOL				2
	#define BASS_ATTRIB_PAN				3
	#define BASS_ATTRIB_EAXMIX			4
	#define BASS_ATTRIB_NOBUFFER			5
	#define BASS_ATTRIB_VBR				6
	#define BASS_ATTRIB_CPU				7
	#define BASS_ATTRIB_SRC				8
	#define BASS_ATTRIB_NET_RESUME		9
	#define BASS_ATTRIB_SCANINFO			10
	#define BASS_ATTRIB_NORAMP			11
	#define BASS_ATTRIB_BITRATE			12
	#define BASS_ATTRIB_BUFFER			13
	#define BASS_ATTRIB_GRANULE			14
	#define BASS_ATTRIB_MUSIC_AMPLIFY		0x100
	#define BASS_ATTRIB_MUSIC_PANSEP		0x101
	#define BASS_ATTRIB_MUSIC_PSCALER		0x102
	#define BASS_ATTRIB_MUSIC_BPM			0x103
	#define BASS_ATTRIB_MUSIC_SPEED		0x104
	#define BASS_ATTRIB_MUSIC_VOL_GLOBAL	0x105
	#define BASS_ATTRIB_MUSIC_ACTIVE		0x106
	#define BASS_ATTRIB_MUSIC_VOL_CHAN		0x200
	#define BASS_ATTRIB_MUSIC_VOL_INST		0x300

	#define BASS_DATA_FFT4096	0x80000004	// 4096 FFT
	#define BASS_DATA_FFT8192	0x80000005	// 8192 FFT
	#define BASS_DATA_FFT16384	0x80000006	// 16384 FFT

	#module

		#defcfunc d2f double d
			t = d
			return ((d<0)<<31) | (lpeek(t,4)-0x38000000<<3) * (d!0) | (lpeek(t)>>29&7)

		#defcfunc tofloat double p1
			temp = p1
			return lpeek(temp)>>29&7|(p1<0)<<31|lpeek(temp,4)-(p1!0)*0x38000000<<3

		/*
		#defcfunc todouble int p1
			temp = 0.0
			lpoke temp, 4, (p1 & 0x80000000) | (((p1 & 0x7fffffff) >> 3) + ((p1 & 0x7fffffff) ! 0) * 0x38000000)
			lpoke temp, 0, p1 << 29
			return temp*/

	#global

#endif