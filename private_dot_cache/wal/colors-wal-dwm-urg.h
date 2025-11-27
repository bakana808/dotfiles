static const char norm_fg[] = "#c1c1c5";
static const char norm_bg[] = "#06061a";
static const char norm_border[] = "#454580";

static const char sel_fg[] = "#c1c1c5";
static const char sel_bg[] = "#b25a73";
static const char sel_border[] = "#c1c1c5";

static const char urg_fg[] = "#c1c1c5";
static const char urg_bg[] = "#c4705d";
static const char urg_border[] = "#c4705d";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
