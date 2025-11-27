const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#06061a", /* black   */
  [1] = "#c4705d", /* red     */
  [2] = "#b25a73", /* green   */
  [3] = "#5fab62", /* yellow  */
  [4] = "#51a0b4", /* blue    */
  [5] = "#b29d60", /* magenta */
  [6] = "#b78067", /* cyan    */
  [7] = "#8d8d98", /* white   */

  /* 8 bright colors */
  [8]  = "#454580",  /* black   */
  [9]  = "#f6a18d",  /* red     */
  [10] = "#dc8ba2", /* green   */
  [11] = "#90d494", /* yellow  */
  [12] = "#7ecce0", /* blue    */
  [13] = "#ddc992", /* magenta */
  [14] = "#e3b29c", /* cyan    */
  [15] = "#c1c1c5", /* white   */

  /* special colors */
  [256] = "#06061a", /* background */
  [257] = "#c1c1c5", /* foreground */
  [258] = "#c1c1c5",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
