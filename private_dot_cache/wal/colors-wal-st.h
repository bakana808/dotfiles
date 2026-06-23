const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0a0a17", /* black   */
  [1] = "#eaa99a", /* red     */
  [2] = "#8ec3d0", /* green   */
  [3] = "#d7b7a9", /* yellow  */
  [4] = "#a0c5a2", /* blue    */
  [5] = "#cfc3a1", /* magenta */
  [6] = "#ce9aa9", /* cyan    */
  [7] = "#c1c1c5", /* white   */

  /* 8 bright colors */
  [8]  = "#59596d",  /* black   */
  [9]  = "#eaa99a",  /* red     */
  [10] = "#8ec3d0", /* green   */
  [11] = "#d7b7a9", /* yellow  */
  [12] = "#a0c5a2", /* blue    */
  [13] = "#cfc3a1", /* magenta */
  [14] = "#ce9aa9", /* cyan    */
  [15] = "#c1c1c5", /* white   */

  /* special colors */
  [256] = "#0a0a17", /* background */
  [257] = "#c1c1c5", /* foreground */
  [258] = "#c1c1c5",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
