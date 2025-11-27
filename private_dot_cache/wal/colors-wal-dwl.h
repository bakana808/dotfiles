/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x06061aff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc1c1c5ff, 0x06061aff, 0x454580ff },
	[SchemeSel]  = { 0xc1c1c5ff, 0xb25a73ff, 0xc4705dff },
	[SchemeUrg]  = { 0xc1c1c5ff, 0xc4705dff, 0xb25a73ff },
};
