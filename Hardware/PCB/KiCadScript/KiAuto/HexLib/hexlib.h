/** \file
 * Functions for Hexagonal Grid coordinate handling.
 * Refer to http://www.redblobgames.com/grids/hexagons/
 * for definitions and additional information.
 *
 * We use the flat-topped grid placement orientation.
 * In the cube coordinate,
 * +x(q) runs horizontally to the right,
 * +y(r) runs at 120deg to the upper left,
 * +z(s) runs at 240deg to the lower left.
 *
 * \verbatim
 * +y(r)  (q r s)
 *    \    ____
 *        /    \\
 *   ____/0 1 -1\\____
 *       \      //    \
 * -1 1 0 \____//1 0 -1\___
 *        /    \\      /
 *   ____/ 0 0 0\\____/ 2 -1 -1 -- +x(q)
 *       \      //    \
 * -1 0 1 \____//1 -1 0\__
 *        /    \\      /
 *   ____/0 -1 1\\____/
 *       \      //    \
 *        \____//      \
 *   /
 * +z(s)
 * \endverbatim
 *
 * In the program we reserve (x,y) for Cartesian coordinates and use
 * (q,r,s) to denote the cube coordinates.  q+r+s==0.  Since z(s) is
 * redundant, (q,r) alone are called axial (trapezoidal) coordinates.
 * l running from 0 to inf denotes the spiral coordinate.
 */
#ifndef __HEXLIB_H__
#define __HEXLIB_H__

/** Map axial coordinates (q,r) to Cartesian coordinates (x,y).
 */
void hex_qr2xy(double p, int q, int r, double *x, double *y);

/** Map axial coordinates (q,r) to spiral coordinates l.
 *
 * Spiral coordinates are defined as follows:
 * \verbatim
 *
 *        7
 *     8    18
 *  9     1     17
 *     2     6
 * 10     0     16
 *     3     5
 * 11     4     15
 *    12    14
 *       13
 * \endverbatim
 *
 * @param[out] q
 * @param[out] r
 * @return spiral coordinate l
 */
int hex_qr2l(int q, int r);

/** Map spiral coordinate to axial coordinates (q,r)
 */
void hex_l2qr(int l, int *q, int *r);

/** Map Cartesian coordinates (x,y) to hex axial coordinates (q,r).
 *
 * The plane is pixelated with flat-topped hexagons with pixel pitch p.
 * The diameter of the hexagon d=2/sqrt(3)*p.
 *
 * CAUTION: uses rounding on cube coordinates.  May not be accurate at
 * hex pixel boundaries.
 *
 * @param[in] p pixel pitch, defined as the center-center distance
 * @param[in] x
 * @param[in] y
 * @param[out] q
 * @param[out] r
 * @return spiral coordinate l
 */
int hex_xy2qr(double p, double x, double y, int *q, int *r);

/** Map Cartesian coordinates (x,y) to hex pixel offset coordinates (nx,my).
 *
 * We adopt the flat-topped convension and (nx,my) is defined in the
 * `offset coordinate' system with vertical layout.
 *
 * The hexagonal pixel (nx,my) encloses the point (x,y).  Hexagonal
 * pixels are places in a way such that the long axis (diameter) is
 * horizontal.  Point (x0,y0) is assumed to be at the center of pixel
 * (0,0).  Pixels (-1,0) and (1,0) are geometrically half a pitch
 * higher in vertical direction than pixel (0,0).
 *
 * @param[in] p pixel pitch, defined as the center-center distance
 * @param[in] x (x,y)
 * @param[in] y (x,y)
 * @param[out] nx x->nx
 * @param[out] my y->my
 * @return composite index of n and m
 */
int hex_xy2nm(double p, double x, double y, int *nx, int *my);

/** Map offset coordinates (nx,my) to pixel center's Cartesian coordinates (x,y).
 *
 * See hex_xy2nm() for the definition of pixelation.
 *
 * @param[in] p pixel pitch, defined as the center-center distance
 * @param[in] nx (nx,my)
 * @param[in] my (nx,my)
 * @param[out] x nx->x
 * @param[out] y my->y
 */
int hex_nm2xy(double p, int nx, int my, double *x, double *y);

#endif // __HEXLIB_H__
