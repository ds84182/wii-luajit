require 'ffi.wiiuse.wiiuse'
local ffi = require 'ffi'

ffi.cdef[[

enum { WPAD_MAX_IR_DOTS = 4 };
											
enum {
	WPAD_CHAN_ALL = -1,
	WPAD_CHAN_0,
	WPAD_CHAN_1,
	WPAD_CHAN_2,
	WPAD_CHAN_3,
	WPAD_BALANCE_BOARD,
	WPAD_MAX_WIIMOTES,
};
											
enum { WPAD_BUTTON_2 = 0x0001 };
enum { WPAD_BUTTON_1 = 0x0002 };
enum { WPAD_BUTTON_B = 0x0004 };
enum { WPAD_BUTTON_A = 0x0008 };
enum { WPAD_BUTTON_MINUS = 0x0010 };
enum { WPAD_BUTTON_HOME = 0x0080 };
enum { WPAD_BUTTON_LEFT = 0x0100 };
enum { WPAD_BUTTON_RIGHT = 0x0200 };
enum { WPAD_BUTTON_DOWN = 0x0400 };
enum { WPAD_BUTTON_UP = 0x0800 };
enum { WPAD_BUTTON_PLUS = 0x1000 };
											
enum { WPAD_NUNCHUK_BUTTON_Z = (0x0001<<16) };
enum { WPAD_NUNCHUK_BUTTON_C = (0x0002<<16) };
											
enum { WPAD_CLASSIC_BUTTON_UP = (0x0001<<16) };
enum { WPAD_CLASSIC_BUTTON_LEFT = (0x0002<<16) };
enum { WPAD_CLASSIC_BUTTON_ZR = (0x0004<<16) };
enum { WPAD_CLASSIC_BUTTON_X = (0x0008<<16) };
enum { WPAD_CLASSIC_BUTTON_A = (0x0010<<16) };
enum { WPAD_CLASSIC_BUTTON_Y = (0x0020<<16) };
enum { WPAD_CLASSIC_BUTTON_B = (0x0040<<16) };
enum { WPAD_CLASSIC_BUTTON_ZL = (0x0080<<16) };
enum { WPAD_CLASSIC_BUTTON_FULL_R = (0x0200<<16) };
enum { WPAD_CLASSIC_BUTTON_PLUS = (0x0400<<16) };
enum { WPAD_CLASSIC_BUTTON_HOME = (0x0800<<16) };
enum { WPAD_CLASSIC_BUTTON_MINUS = (0x1000<<16) };
enum { WPAD_CLASSIC_BUTTON_FULL_L = (0x2000<<16) };
enum { WPAD_CLASSIC_BUTTON_DOWN = (0x4000<<16) };
enum { WPAD_CLASSIC_BUTTON_RIGHT = (0x8000<<16) };

enum { WPAD_GUITAR_HERO_3_BUTTON_STRUM_UP = (0x0001<<16) };
enum { WPAD_GUITAR_HERO_3_BUTTON_YELLOW = (0x0008<<16) };
enum { WPAD_GUITAR_HERO_3_BUTTON_GREEN = (0x0010<<16) };
enum { WPAD_GUITAR_HERO_3_BUTTON_BLUE = (0x0020<<16) };
enum { WPAD_GUITAR_HERO_3_BUTTON_RED = (0x0040<<16) };
enum { WPAD_GUITAR_HERO_3_BUTTON_ORANGE = (0x0080<<16) };
enum { WPAD_GUITAR_HERO_3_BUTTON_PLUS = (0x0400<<16) };
enum { WPAD_GUITAR_HERO_3_BUTTON_MINUS = (0x1000<<16) };
enum { WPAD_GUITAR_HERO_3_BUTTON_STRUM_DOWN = (0x4000<<16) };

enum {
	WPAD_EXP_NONE = 0,
	WPAD_EXP_NUNCHUK,
	WPAD_EXP_CLASSIC,
	WPAD_EXP_GUITARHERO3,
 	WPAD_EXP_WIIBOARD,
	WPAD_EXP_UNKNOWN = 255
};

enum {
	WPAD_FMT_BTNS = 0,
	WPAD_FMT_BTNS_ACC,
	WPAD_FMT_BTNS_ACC_IR
};

enum {
	WPAD_STATE_DISABLED,
	WPAD_STATE_ENABLING,
	WPAD_STATE_ENABLED
};

enum { WPAD_ERR_NONE = 0 };
enum { WPAD_ERR_NO_CONTROLLER = -1 };
enum { WPAD_ERR_NOT_READY = -2 };
enum { WPAD_ERR_TRANSFER = -3 };
enum { WPAD_ERR_NONEREGISTERED = -4 };
enum { WPAD_ERR_UNKNOWN = -5 };
enum { WPAD_ERR_BAD_CHANNEL = -6 };
enum { WPAD_ERR_QUEUE_EMPTY = -7 };
enum { WPAD_ERR_BADVALUE = -8 };
enum { WPAD_ERR_BADCONF = -9 };

enum { WPAD_DATA_BUTTONS = 0x01 };
enum { WPAD_DATA_ACCEL = 0x02 };
enum { WPAD_DATA_EXPANSION = 0x04 };
enum { WPAD_DATA_IR = 0x08 };

enum { WPAD_ENC_FIRST = 0x00 };
enum { WPAD_ENC_CONT = 0x01 };

enum { WPAD_THRESH_IGNORE = -1 };
enum { WPAD_THRESH_ANY = 0 };
enum { WPAD_THRESH_DEFAULT_BUTTONS = 0 };
enum { WPAD_THRESH_DEFAULT_IR = WPAD_THRESH_IGNORE };
enum { WPAD_THRESH_DEFAULT_ACCEL = 20 };
enum { WPAD_THRESH_DEFAULT_JOYSTICK = 2 };
enum { WPAD_THRESH_DEFAULT_BALANCEBOARD = 60 };
enum { WPAD_THRESH_DEFAULT_MOTION_PLUS = 100 };

typedef struct _wpad_data
{
	s16 err;

	u32 data_present;
	u8 battery_level;

	u32 btns_h;
	u32 btns_l;
	u32 btns_d;
	u32 btns_u;

	struct ir_t ir;
	struct vec3w_t accel;
	struct orient_t orient;
	struct gforce_t gforce;
	struct expansion_t exp;
} WPADData;

typedef struct _wpad_encstatus
{
	u8 data[32];
}WPADEncStatus;

typedef void (*WPADDataCallback)(s32 chan, const WPADData *data);
typedef void (*WPADShutdownCallback)(s32 chan);

s32 WPAD_Init();
s32 WPAD_ControlSpeaker(s32 chan,s32 enable);
s32 WPAD_ReadEvent(s32 chan, WPADData *data);
s32 WPAD_DroppedEvents(s32 chan);
s32 WPAD_Flush(s32 chan);
s32 WPAD_ReadPending(s32 chan, WPADDataCallback datacb);
s32 WPAD_SetDataFormat(s32 chan, s32 fmt);
s32 WPAD_SetMotionPlus(s32 chan, u8 enable);
s32 WPAD_SetVRes(s32 chan,u32 xres,u32 yres);
s32 WPAD_GetStatus();
s32 WPAD_Probe(s32 chan,u32 *type);
s32 WPAD_SetEventBufs(s32 chan, WPADData *bufs, u32 cnt);
s32 WPAD_Disconnect(s32 chan);
s32 WPAD_IsSpeakerEnabled(s32 chan);
s32 WPAD_SendStreamData(s32 chan,void *buf,u32 len);
void WPAD_Shutdown();
void WPAD_SetIdleTimeout(u32 seconds);
void WPAD_SetPowerButtonCallback(WPADShutdownCallback cb);
void WPAD_SetBatteryDeadCallback(WPADShutdownCallback cb);
s32 WPAD_ScanPads();
s32 WPAD_Rumble(s32 chan, int status);
s32 WPAD_SetIdleThresholds(s32 chan, s32 btns, s32 ir, s32 accel, s32 js, s32 wb, s32 mp);
void WPAD_EncodeData(WPADEncStatus *info,u32 flag,const s16 *pcmSamples,s32 numSamples,u8 *encData);
WPADData *WPAD_Data(int chan);
u8 WPAD_BatteryLevel(int chan);
u32 WPAD_ButtonsUp(int chan);
u32 WPAD_ButtonsDown(int chan);
u32 WPAD_ButtonsHeld(int chan);
void WPAD_IR(int chan, struct ir_t *ir);
void WPAD_Orientation(int chan, struct orient_t *orient);
void WPAD_GForce(int chan, struct gforce_t *gforce);
void WPAD_Accel(int chan, struct vec3w_t *accel);
void WPAD_Expansion(int chan, struct expansion_t *exp);

]]

return ffi.C