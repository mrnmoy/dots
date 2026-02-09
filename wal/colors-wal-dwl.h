/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x170a15ff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc5c1c4ff, 0x170a15ff, 0x6d5969ff },
	[SchemeSel]  = { 0xc5c1c4ff, 0x69388Fff, 0xA6416Dff },
	[SchemeUrg]  = { 0xc5c1c4ff, 0xA6416Dff, 0x69388Fff },
};
