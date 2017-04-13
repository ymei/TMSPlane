#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "hexlib.h"

inline void hex_qr2xy(double p, int q, int r, double *x, double *y)
{
    /*                             
     * | x |   | q_vx  r_vx |   | q |
     * |   | = |            | x |   |
     * | y |   | q_vy  r_vy |   | r |
     *                                
     * q_v = p * (sqrt(3)/2, 1/2)
     * r_v = p * (0,         1.0)
     */
    *x = p * (sqrt(3.0)/2.0 * q);
    *y = p * (0.5           * q + 1.0 * r);
}

inline int hex_qr2l(int q, int r)
{
    int s, R, l, i0;

    s = -q -r;
    R = (abs(q) + abs(r) + abs(s)) >> 1;
    if(R == 0) return 0;

    l = i0 = 3 * R * (R-1) + 1;
    if     (r ==  R) l = i0 - q;
    else if(q == -R) l = i0 + R + s;
    else if(s ==  R) l = i0 + 2*R - r;
    else if(r == -R) l = i0 + 3*R + q;
    else if(q ==  R) l = i0 + 4*R - s;
    else if(s == -R) l = i0 + 5*R + r;

    return l;
}

inline void hex_l2qr(int l, int *q, int *r)
{
    int s, l0, dl, R, j;

    if(l==0) {
        *q = 0;
        *r = 0;
        return;
    }
    
    R = (int)ceil(sqrt(l/3.0 + 0.25) - 0.5);
    l0 = 3 * R * (R-1) + 1;
    dl = l-l0;
    j = dl / R;

    switch(j) {
    case 0:
        *r = R;
        *q = -dl;
        break;
    case 1:
        *q = -R;
        s = dl-R;
        *r = -*q -s;
        break;
    case 2:
        s = R;
        *r = 2*R - dl;
        *q = -*r -s;
        break;
    case 3:
        *r = -R;
        *q = dl - 3*R;
        break;
    case 4:
        *q = R;
        s = 4*R - dl;
        *r = -*q -s;
        break;
    case 5:
        s = -R;
        *r = dl - 5*R;
        *q = -*r - s;
        break;
    default:
        fprintf(stderr, "j = %d is >5 or <0\n", j);
        break;
    }   
}

inline int hex_xy2qr(double p, double x, double y, int *q, int *r)
{
    /*
     *            | q_vx  r_vx |    | r_vy -r_vx |
     * Inverse of |            | is |            | / det| |
     *            | q_vy  r_vy |    |-q_vy  q_vx |
     *                              
     */
    double qf, rf, sf, qdf, rdf, sdf;
    int qr, rr, sr;
    
    qf = ( 1.0 * x )                    / (sqrt(3.0)/2.0 * p);
    rf = (-0.5 * x + sqrt(3.0)/2.0 * y) / (sqrt(3.0)/2.0 * p);
    sf = -qf -rf;

    /* rounding */
    qr = lround(qf);
    rr = lround(rf);
    sr = lround(sf);

    qdf = fabs(qr - qf);
    rdf = fabs(rr - rf);
    sdf = fabs(sr - sf);

    *q = qr;
    *r = rr;
    if(qdf > rdf && qdf > sdf) {
        *q = -rr -sr;
    } else if(rdf > sdf) {
        *r = -qr -sr;
    }

    return hex_qr2l(*q, *r);
}

inline int hex_xy2nm(double p, double x, double y, int *nx, int *my)
{
    int m, m2, n;
    double d, dx, dy, xr, yr2;
    double x0=0.0, y0=0.0;

    d = sqrt(3.0)/2.0 * p;
    dx = 3.0/4.0 * d;
    dy = p;

    m2 = (int)floor((y-y0)*2.0 / dy);
    n = (int)floor((x-x0)/dx);

    /* residuals */
    xr = x-x0 - n*dx;
    yr2 = y-y0 - m2 * dy/2.0;

    /* note that a%2 can result in -1,0,1 */
    if(n%2==0 && m2%2==0) { /* \ */
        if((yr2 + sqrt(3.0)*(xr-0.5*d)) < 0) {
            *nx = n; m = m2;
        } else { *nx = n+1; m = m2; }
    }
    if(n%2==0 && m2%2!=0) { /* / */
        if((yr2 - sqrt(3.0)*(xr-0.25*d)) > 0) {
            *nx = n; m = m2+1;
        } else { *nx = n+1; m = m2-1; }
    }
    if(n%2!=0 && m2%2==0) { /* / */
        if((yr2 - sqrt(3.0)*(xr-0.25*d)) > 0) {
            *nx = n; m = m2;
        } else { *nx = n+1; m = m2; }
    }
    if(n%2!=0 && m2%2!=0) { /* \ */
        if((yr2 + sqrt(3.0)*(xr-0.5*d)) < 0) {
            *nx = n; m = m2-1;
        } else { *nx = n+1; m = m2+1; }
    }
    *my = m>>1;
    
    return (*nx)*10000 + (*my);
}

int hex_nm2xy(double p, int nx, int my, double *x, double *y)
{
    double d, dx, dy;

    d = sqrt(3.0)/2.0 * p;
    dx = 3.0/4.0 * d;
    dy = p;

    *x = nx * dx;
    *y = my * dy;
    if(nx % 2) *y += dy/2.0;

    return 0;
}


#ifdef HEXLIB_DEBUG_ENABLEMAIN
int main(int argc, char **argv)
{
    int i, j, l, q, r;
    double x, y;
    
    for(i=-10; i<11; i++) {
        for(j=-10; j<11; j++) {
            hex_qr2xy(10.0, i, j, &x, &y);
            l = hex_qr2l(i, j);
            hex_l2qr(l, &q, &r);
            printf("%g %g %d %d %d %d %d\n", x, y, i, j, l, q, r);
//            x = i; y = j;
//            hex_xy2qr(20.0, x, y, &q, &r);
//            printf("%g %g %d %d\n", x, y, q, r);
        }
    }
    
    return EXIT_SUCCESS;
}
#endif
