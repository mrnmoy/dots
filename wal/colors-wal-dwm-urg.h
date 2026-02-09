static const char norm_fg[] = "#c5c1c4";
static const char norm_bg[] = "#170a15";
static const char norm_border[] = "#6d5969";

static const char sel_fg[] = "#c5c1c4";
static const char sel_bg[] = "#69388F";
static const char sel_border[] = "#c5c1c4";

static const char urg_fg[] = "#c5c1c4";
static const char urg_bg[] = "#A6416D";
static const char urg_border[] = "#A6416D";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
