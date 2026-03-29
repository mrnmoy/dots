const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#170a15", /* black   */
  [1] = "#A6416D", /* red     */
  [2] = "#69388F", /* green   */
  [3] = "#993B8C", /* yellow  */
  [4] = "#AC4798", /* blue    */
  [5] = "#D154A5", /* magenta */
  [6] = "#DA69D2", /* cyan    */
  [7] = "#c5c1c4", /* white   */

  /* 8 bright colors */
  [8]  = "#6d5969",  /* black   */
  [9]  = "#A6416D",  /* red     */
  [10] = "#69388F", /* green   */
  [11] = "#993B8C", /* yellow  */
  [12] = "#AC4798", /* blue    */
  [13] = "#D154A5", /* magenta */
  [14] = "#DA69D2", /* cyan    */
  [15] = "#c5c1c4", /* white   */

  /* special colors */
  [256] = "#170a15", /* background */
  [257] = "#c5c1c4", /* foreground */
  [258] = "#c5c1c4",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
