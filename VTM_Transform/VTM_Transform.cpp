#include "VTM_Transform.h"

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits>
#include <memory.h>
#include <malloc.h>


// ********************************** DCT-II **********************************

//Fast DCT-II transforms
void fastForwardDCT2_B2(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
  int j;
  TCoeff E, O;
  TCoeff add = (shift > 0) ? (1 << (shift - 1)) : 0;

  const TMatrixCoeff *iT = g_trCoreDCT2P2[TRANSFORM_FORWARD][0];

  TCoeff *pCoef = dst;
  const int  reducedLine = line - iSkipLine;
  for (j = 0; j<reducedLine; j++)
  {
    /* E and O */
    E = src[0] + src[1];
    O = src[0] - src[1];

    dst[0] = (iT[0] * E + add) >> shift;
    dst[line] = (iT[2] * O + add) >> shift;


    src += 2;
    dst++;
  }
  if (iSkipLine)
  {
    dst = pCoef + reducedLine;
    for (j = 0; j<2; j++)
    {
      memset(dst, 0, sizeof(TCoeff)*iSkipLine);
      dst += line;
    }
  }
}


/** 4x4 forward transform implemented using partial butterfly structure (1D)
*  \param src   input data (residual)
*  \param dst   output data (transform coefficients)
*  \param shift specifies right shift after 1D transform
*  \param line
*/
void fastForwardDCT2_B4(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
  int j;
  TCoeff E[2], O[2];
  TCoeff add = (shift > 0) ? (1 << (shift - 1)) : 0;

  const TMatrixCoeff *iT = g_trCoreDCT2P4[TRANSFORM_FORWARD][0];

  TCoeff *pCoef = dst;
  const int  reducedLine = line - iSkipLine;
  for (j = 0; j<reducedLine; j++)
  {
    /* E and O */
    E[0] = src[0] + src[3];
    O[0] = src[0] - src[3];
    E[1] = src[1] + src[2];
    O[1] = src[1] - src[2];

    dst[0] = (iT[0] * E[0] + iT[1] * E[1] + add) >> shift;
    dst[2 * line] = (iT[8] * E[0] + iT[9] * E[1] + add) >> shift;
    dst[line] = (iT[4] * O[0] + iT[5] * O[1] + add) >> shift;
    dst[3 * line] = (iT[12] * O[0] + iT[13] * O[1] + add) >> shift;

    src += 4;
    dst++;
  }
  if (iSkipLine)
  {
    dst = pCoef + reducedLine;
    for (j = 0; j<4; j++)
    {
      memset(dst, 0, sizeof(TCoeff)*iSkipLine);
      dst += line;
    }
  }
}


template< int uiTrSize >
inline void _fastForwardMM( const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2, const TMatrixCoeff* tc )
{
  const TCoeff rnd_factor = TCoeff(1) << (shift - 1);
  const int  reducedLine = line - iSkipLine;
  const int  cutoff      = uiTrSize - iSkipLine2;
  TCoeff *pCoef;

  for( int i = 0; i<reducedLine; i++ )
  {
    pCoef = dst;
    const TMatrixCoeff* iT = tc;

    for( int j = 0; j<cutoff; j++ )
    {
      TCoeff iSum = 0;
      for( int k = 0; k<uiTrSize; k++ )
      {
        iSum += src[k] * iT[k];
      }
      pCoef[i] = (iSum + rnd_factor) >> shift;
      pCoef += line;
      iT += uiTrSize;
    }
    src += uiTrSize;
  }

  if( iSkipLine )
  {
    pCoef = dst + reducedLine;
    for( int j = 0; j<cutoff; j++ )
    {
      memset(pCoef, 0, sizeof(TCoeff) * iSkipLine);
      pCoef += line;
    }
  }

  if( iSkipLine2 )
  {
    pCoef = dst + line*cutoff;
    memset(pCoef, 0, sizeof(TCoeff) * line * iSkipLine2);
  }
}

/** 8x8 forward transform implemented using partial butterfly structure (1D)
*  \param src   input data (residual)
*  \param dst   output data (transform coefficients)
*  \param shift specifies right shift after 1D transform
*  \param line
*/
void fastForwardDCT2_B8( const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2 )
{
  int j, k;
  TCoeff E[4], O[4];
  TCoeff EE[2], EO[2];
  TCoeff add = ( shift > 0 ) ? ( 1 << ( shift - 1 ) ) : 0;

  const TMatrixCoeff *iT = g_trCoreDCT2P8[TRANSFORM_FORWARD][0];

  TCoeff *pCoef = dst;
  const int  reducedLine = line - iSkipLine;
  for( j = 0; j < reducedLine; j++ )
  {
    /* E and O*/
    for( k = 0; k < 4; k++ )
    {
      E[k] = src[k] + src[7 - k];
      O[k] = src[k] - src[7 - k];
    }
    /* EE and EO */
    EE[0] = E[0] + E[3];
    EO[0] = E[0] - E[3];
    EE[1] = E[1] + E[2];
    EO[1] = E[1] - E[2];

    dst[0       ] = (iT[ 0] * EE[0] + iT[ 1] * EE[1] + add) >> shift;
    dst[4 * line] = (iT[32] * EE[0] + iT[33] * EE[1] + add) >> shift;
    dst[2 * line] = (iT[16] * EO[0] + iT[17] * EO[1] + add) >> shift;
    dst[6 * line] = (iT[48] * EO[0] + iT[49] * EO[1] + add) >> shift;

    dst[    line] = (iT[ 8] * O[0] + iT[ 9] * O[1] + iT[10] * O[2] + iT[11] * O[3] + add) >> shift;
    dst[3 * line] = (iT[24] * O[0] + iT[25] * O[1] + iT[26] * O[2] + iT[27] * O[3] + add) >> shift;
    dst[5 * line] = (iT[40] * O[0] + iT[41] * O[1] + iT[42] * O[2] + iT[43] * O[3] + add) >> shift;
    dst[7 * line] = (iT[56] * O[0] + iT[57] * O[1] + iT[58] * O[2] + iT[59] * O[3] + add) >> shift;

    src += 8;
    dst++;
  }
  if( iSkipLine )
  {
    dst = pCoef + reducedLine;
    for( j = 0; j < 8; j++ )
    {
      memset( dst, 0, sizeof( TCoeff )*iSkipLine );
      dst += line;
    }
  }
}


/** 16x16 forward transform implemented using partial butterfly structure (1D)
*  \param src   input data (residual)
*  \param dst   output data (transform coefficients)
*  \param shift specifies right shift after 1D transform
*  \param line
*/
void fastForwardDCT2_B16(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
  int j, k;
  TCoeff E  [8], O  [8];
  TCoeff EE [4], EO [4];
  TCoeff EEE[2], EEO[2];
  TCoeff add = ( shift > 0 ) ? ( 1 << ( shift - 1 ) ) : 0;

  const TMatrixCoeff *iT = g_trCoreDCT2P16[TRANSFORM_FORWARD][0];

  TCoeff *pCoef = dst;
  const int  reducedLine = line - iSkipLine;
  for( j = 0; j < reducedLine; j++ )
  {
    /* E and O*/
    for( k = 0; k < 8; k++ )
    {
      E[k] = src[k] + src[15 - k];
      O[k] = src[k] - src[15 - k];
    }
    /* EE and EO */
    for( k = 0; k < 4; k++ )
    {
      EE[k] = E[k] + E[7 - k];
      EO[k] = E[k] - E[7 - k];
    }
    /* EEE and EEO */
    EEE[0] = EE[0] + EE[3];
    EEO[0] = EE[0] - EE[3];
    EEE[1] = EE[1] + EE[2];
    EEO[1] = EE[1] - EE[2];

    dst[ 0       ] = ( iT[ 0     ] * EEE[0] + iT[          1] * EEE[1] + add ) >> shift;
    dst[ 8 * line] = ( iT[ 8 * 16] * EEE[0] + iT[ 8 * 16 + 1] * EEE[1] + add ) >> shift;
    dst[ 4 * line] = ( iT[ 4 * 16] * EEO[0] + iT[ 4 * 16 + 1] * EEO[1] + add ) >> shift;
    dst[12 * line] = ( iT[12 * 16] * EEO[0] + iT[12 * 16 + 1] * EEO[1] + add ) >> shift;

    for( k = 2; k < 16; k += 4 )
    {
      dst[k*line] = ( iT[k * 16] * EO[0] + iT[k * 16 + 1] * EO[1] + iT[k * 16 + 2] * EO[2] + iT[k * 16 + 3] * EO[3] + add ) >> shift;
    }

    for( k = 1; k < 16; k += 2 )
    {
      dst[k*line] = ( iT[k * 16    ] * O[0] + iT[k * 16 + 1] * O[1] + iT[k * 16 + 2] * O[2] + iT[k * 16 + 3] * O[3] +
                      iT[k * 16 + 4] * O[4] + iT[k * 16 + 5] * O[5] + iT[k * 16 + 6] * O[6] + iT[k * 16 + 7] * O[7] + add ) >> shift;
    }

    src += 16;
    dst++;

  }
  if( iSkipLine )
  {
    dst = pCoef + reducedLine;
    for( j = 0; j < 16; j++ )
    {
      memset( dst, 0, sizeof( TCoeff )*iSkipLine );
      dst += line;
    }
  }
}

/** 32x32 forward transform implemented using partial butterfly structure (1D)
*  \param src   input data (residual)
*  \param dst   output data (transform coefficients)
*  \param shift specifies right shift after 1D transform
*  \param line
*/
void fastForwardDCT2_B32( const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2 )
{
  int j, k;
  TCoeff E   [16], O   [16];
  TCoeff EE  [ 8], EO  [ 8];
  TCoeff EEE [ 4], EEO [ 4];
  TCoeff EEEE[ 2], EEEO[ 2];
  TCoeff add = ( shift > 0 ) ? ( 1 << ( shift - 1 ) ) : 0;

  const TMatrixCoeff *iT = g_trCoreDCT2P32[TRANSFORM_FORWARD][0];

  TCoeff *pCoef = dst;
  const int  reducedLine = line - iSkipLine;
  for (j = 0; j<reducedLine; j++)
  {
    /* E and O*/
    for (k = 0;k<16;k++)
    {
      E[k] = src[k] + src[31 - k];
      O[k] = src[k] - src[31 - k];
    }
    /* EE and EO */
    for (k = 0;k<8;k++)
    {
      EE[k] = E[k] + E[15 - k];
      EO[k] = E[k] - E[15 - k];
    }
    /* EEE and EEO */
    for (k = 0;k<4;k++)
    {
      EEE[k] = EE[k] + EE[7 - k];
      EEO[k] = EE[k] - EE[7 - k];
    }
    /* EEEE and EEEO */
    EEEE[0] = EEE[0] + EEE[3];
    EEEO[0] = EEE[0] - EEE[3];
    EEEE[1] = EEE[1] + EEE[2];
    EEEO[1] = EEE[1] - EEE[2];

    dst[0] = (iT[0 * 32 + 0] * EEEE[0] + iT[0 * 32 + 1] * EEEE[1] + add) >> shift;
    dst[16 * line] = (iT[16 * 32 + 0] * EEEE[0] + iT[16 * 32 + 1] * EEEE[1] + add) >> shift;
    dst[8 * line] = (iT[8 * 32 + 0] * EEEO[0] + iT[8 * 32 + 1] * EEEO[1] + add) >> shift;
    dst[24 * line] = (iT[24 * 32 + 0] * EEEO[0] + iT[24 * 32 + 1] * EEEO[1] + add) >> shift;
    for (k = 4;k<32;k += 8)
    {
      dst[k*line] = (iT[k * 32 + 0] * EEO[0] + iT[k * 32 + 1] * EEO[1] + iT[k * 32 + 2] * EEO[2] + iT[k * 32 + 3] * EEO[3] + add) >> shift;
    }
    for (k = 2;k<32;k += 4)
    {
      dst[k*line] = (iT[k * 32 + 0] * EO[0] + iT[k * 32 + 1] * EO[1] + iT[k * 32 + 2] * EO[2] + iT[k * 32 + 3] * EO[3] +
                      iT[k * 32 + 4] * EO[4] + iT[k * 32 + 5] * EO[5] + iT[k * 32 + 6] * EO[6] + iT[k * 32 + 7] * EO[7] + add) >> shift;
    }
    for (k = 1;k<32;k += 2)
    {
      dst[k*line] = (iT[k * 32 + 0] * O[0] + iT[k * 32 + 1] * O[1] + iT[k * 32 + 2] * O[2] + iT[k * 32 + 3] * O[3] +
                      iT[k * 32 + 4] * O[4] + iT[k * 32 + 5] * O[5] + iT[k * 32 + 6] * O[6] + iT[k * 32 + 7] * O[7] +
                      iT[k * 32 + 8] * O[8] + iT[k * 32 + 9] * O[9] + iT[k * 32 + 10] * O[10] + iT[k * 32 + 11] * O[11] +
                      iT[k * 32 + 12] * O[12] + iT[k * 32 + 13] * O[13] + iT[k * 32 + 14] * O[14] + iT[k * 32 + 15] * O[15] + add) >> shift;
    }
    src += 32;
    dst++;
  }
  if (iSkipLine)
  {
    dst = pCoef + reducedLine;
    for (j = 0; j<32; j++)
    {
      memset(dst, 0, sizeof(TCoeff)*iSkipLine);
      dst += line;
    }
  }
}

void fastForwardDCT2_B64(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
  int rnd_factor = 1 << (shift - 1);

  const int uiTrSize = 64;
  const TMatrixCoeff *iT = g_trCoreDCT2P64[TRANSFORM_FORWARD][0];

  int   j, k;
  TCoeff E[32], O[32];
  TCoeff EE[16], EO[16];
  TCoeff EEE[8], EEO[8];
  TCoeff EEEE[4], EEEO[4];
  TCoeff EEEEE[2], EEEEO[2];
  TCoeff *tmp = dst;

  //bool zo = iSkipLine2 >= 32;
  bool zo = iSkipLine2 != 0;
  for (j = 0; j<line - iSkipLine; j++)
  {
    /* E and O*/
    for (k = 0;k<32;k++)
    {
      E[k] = src[k] + src[63 - k];
      O[k] = src[k] - src[63 - k];
    }
    /* EE and EO */
    for (k = 0;k<16;k++)
    {
      EE[k] = E[k] + E[31 - k];
      EO[k] = E[k] - E[31 - k];
    }
    /* EEE and EEO */
    for (k = 0;k<8;k++)
    {
      EEE[k] = EE[k] + EE[15 - k];
      EEO[k] = EE[k] - EE[15 - k];
    }
    /* EEEE and EEEO */
    for (k = 0;k<4;k++)
    {
      EEEE[k] = EEE[k] + EEE[7 - k];
      EEEO[k] = EEE[k] - EEE[7 - k];
    }
    /* EEEEE and EEEEO */
    EEEEE[0] = EEEE[0] + EEEE[3];
    EEEEO[0] = EEEE[0] - EEEE[3];
    EEEEE[1] = EEEE[1] + EEEE[2];
    EEEEO[1] = EEEE[1] - EEEE[2];

    dst[0] = (iT[0 * 64 + 0] * EEEEE[0] + iT[0 * 64 + 1] * EEEEE[1] + rnd_factor) >> shift;
    dst[16 * line] = (iT[16 * 64 + 0] * EEEEO[0] + iT[16 * 64 + 1] * EEEEO[1] + rnd_factor) >> shift;

    if (!zo)
    {
      dst[32 * line] = (iT[32 * 64 + 0] * EEEEE[0] + iT[32 * 64 + 1] * EEEEE[1] + rnd_factor) >> shift;
      dst[48 * line] = (iT[48 * 64 + 0] * EEEEO[0] + iT[48 * 64 + 1] * EEEEO[1] + rnd_factor) >> shift;
    }
    for (k = 8;k<(zo ? 32 : 64);k += 16)
    {
      dst[k*line] = (iT[k * 64 + 0] * EEEO[0] + iT[k * 64 + 1] * EEEO[1] + iT[k * 64 + 2] * EEEO[2] + iT[k * 64 + 3] * EEEO[3] + rnd_factor) >> shift;
    }
    for (k = 4;k<(zo ? 32 : 64);k += 8)
    {
      dst[k*line] = (iT[k * 64 + 0] * EEO[0] + iT[k * 64 + 1] * EEO[1] + iT[k * 64 + 2] * EEO[2] + iT[k * 64 + 3] * EEO[3] +
                      iT[k * 64 + 4] * EEO[4] + iT[k * 64 + 5] * EEO[5] + iT[k * 64 + 6] * EEO[6] + iT[k * 64 + 7] * EEO[7] + rnd_factor) >> shift;
    }
    for (k = 2;k<(zo ? 32 : 64);k += 4)
    {
      dst[k*line] = (iT[k * 64 + 0] * EO[0] + iT[k * 64 + 1] * EO[1] + iT[k * 64 + 2] * EO[2] + iT[k * 64 + 3] * EO[3] +
                      iT[k * 64 + 4] * EO[4] + iT[k * 64 + 5] * EO[5] + iT[k * 64 + 6] * EO[6] + iT[k * 64 + 7] * EO[7] +
                      iT[k * 64 + 8] * EO[8] + iT[k * 64 + 9] * EO[9] + iT[k * 64 + 10] * EO[10] + iT[k * 64 + 11] * EO[11] +
                      iT[k * 64 + 12] * EO[12] + iT[k * 64 + 13] * EO[13] + iT[k * 64 + 14] * EO[14] + iT[k * 64 + 15] * EO[15] + rnd_factor) >> shift;
    }
    for (k = 1;k<(zo ? 32 : 64);k += 2)
    {
      dst[k*line] = (iT[k * 64 + 0] * O[0] + iT[k * 64 + 1] * O[1] + iT[k * 64 + 2] * O[2] + iT[k * 64 + 3] * O[3] +
                      iT[k * 64 + 4] * O[4] + iT[k * 64 + 5] * O[5] + iT[k * 64 + 6] * O[6] + iT[k * 64 + 7] * O[7] +
                      iT[k * 64 + 8] * O[8] + iT[k * 64 + 9] * O[9] + iT[k * 64 + 10] * O[10] + iT[k * 64 + 11] * O[11] +
                      iT[k * 64 + 12] * O[12] + iT[k * 64 + 13] * O[13] + iT[k * 64 + 14] * O[14] + iT[k * 64 + 15] * O[15] +
                      iT[k * 64 + 16] * O[16] + iT[k * 64 + 17] * O[17] + iT[k * 64 + 18] * O[18] + iT[k * 64 + 19] * O[19] +
                      iT[k * 64 + 20] * O[20] + iT[k * 64 + 21] * O[21] + iT[k * 64 + 22] * O[22] + iT[k * 64 + 23] * O[23] +
                      iT[k * 64 + 24] * O[24] + iT[k * 64 + 25] * O[25] + iT[k * 64 + 26] * O[26] + iT[k * 64 + 27] * O[27] +
                      iT[k * 64 + 28] * O[28] + iT[k * 64 + 29] * O[29] + iT[k * 64 + 30] * O[30] + iT[k * 64 + 31] * O[31] + rnd_factor) >> shift;
    }
    src += uiTrSize;
    dst++;
  }

  const int  reducedLine = line - iSkipLine;
  const int  cutoff = uiTrSize - iSkipLine2;
  if (iSkipLine)
  {
    dst = tmp + reducedLine;
    for (j = 0; j<cutoff; j++)
    {
      memset(dst, 0, sizeof(TCoeff)*iSkipLine);
      dst += line;
    }
  }
  if (iSkipLine2)
  {
    dst = tmp + line*cutoff;
    memset(dst, 0, sizeof(TCoeff)*line*iSkipLine2);
  }
}

// ********************************** DST-VII **********************************
void fastForwardDST7_B4(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
  int i;
  TCoeff rnd_factor = (shift > 0) ? (1 << (shift - 1)) : 0;

  const TMatrixCoeff *iT = g_trCoreDST7P4[TRANSFORM_FORWARD][0];

  TCoeff c[4];
  TCoeff *pCoeff = dst;
  const int  reducedLine = line - iSkipLine;
  for (i = 0; i<reducedLine; i++)
  {
    // Intermediate Variables
    c[0] = src[0] + src[3];
    c[1] = src[1] + src[3];
    c[2] = src[0] - src[1];
    c[3] = iT[2] * src[2];

    dst[0 * line] = (iT[0] * c[0] + iT[1] * c[1] + c[3] + rnd_factor) >> shift;
    dst[1 * line] = (iT[2] * (src[0] + src[1] - src[3]) + rnd_factor) >> shift;
    dst[2 * line] = (iT[0] * c[2] + iT[1] * c[0] - c[3] + rnd_factor) >> shift;
    dst[3 * line] = (iT[1] * c[2] - iT[0] * c[1] + c[3] + rnd_factor) >> shift;

    src += 4;
    dst++;
  }
  if (iSkipLine)
  {
    dst = pCoeff + reducedLine;
    for (i = 0; i<4; i++)
    {
      memset(dst, 0, sizeof(TCoeff)*iSkipLine);
      dst += line;
    }
  }
}

void fastForwardDST7_B8(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
  _fastForwardMM< 8 >( src, dst, shift, line, iSkipLine, iSkipLine2, g_trCoreDST7P8[TRANSFORM_FORWARD][0] );
}

void fastForwardDST7_B16(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
#if !JVET_M0497_MATRIX_MULT
  int j, k;
  TCoeff a[5], b[5], c[5], d[5], t;
  TCoeff add = (shift > 0) ? (1 << (shift - 1)) : 0;

  const TMatrixCoeff *iT = g_trCoreDST7P16[TRANSFORM_FORWARD][0];

  TCoeff *pCoef = dst;
  const int  reducedLine = line - iSkipLine;
  const int  cutoff = 16 - iSkipLine2;

  for (j = 0; j < reducedLine; j++)
  {
    for (k = 0; k < 5; k++)
    {
      a[k] = src[    k] + src[11 + k];
      b[k] = src[9 - k] + src[11 + k];
      c[k] = src[    k] - src[ 9 - k];
      d[k] = src[    k] + src[ 9 - k] - src[11 + k];
    }

    t = iT[10] * src[10];

    dst[ 1 * line] = ( iT[ 2]*d[0] + iT[ 5]*d[1] + iT[ 8]*d[2] + iT[11]*d[3] + iT[14]*d[4] + add) >> shift;
    dst[ 4 * line] = ( iT[ 8]*d[0] + iT[14]*d[1] + iT[ 5]*d[2] - iT[ 2]*d[3] - iT[11]*d[4] + add) >> shift;
    dst[ 7 * line] = ( iT[14]*d[0] + iT[ 2]*d[1] - iT[11]*d[2] - iT[ 5]*d[3] + iT[ 8]*d[4] + add) >> shift;
    dst[10 * line] = ( iT[11]*d[0] - iT[ 8]*d[1] - iT[ 2]*d[2] + iT[14]*d[3] - iT[ 5]*d[4] + add) >> shift;
    dst[13 * line] = ( iT[ 5]*d[0] - iT[11]*d[1] + iT[14]*d[2] - iT[ 8]*d[3] + iT[ 2]*d[4] + add) >> shift;

    dst[5 * line] = ( iT[10] * (src[0] + src[1] - src[3] - src[4] + src[6] + src[7] - src[9] - src[10] + src[12] + src[13] - src[15]) + add) >> shift;

    dst[ 0 * line] = ( iT[0]*a[0] + iT[9]*b[0] + iT[1]*a[1] + iT[8]*b[1] + iT[2]*a[2] + iT[7]*b[2] + iT[3]*a[3] + iT[6]*b[3] + iT[4]*a[4] + iT[5]*b[4] + t + add ) >> shift;
    dst[ 2 * line] = ( iT[4]*c[0] - iT[5]*b[0] + iT[9]*c[1] - iT[0]*b[1] + iT[6]*c[2] + iT[3]*a[2] + iT[1]*c[3] + iT[8]*a[3] + iT[7]*a[4] + iT[2]*b[4] - t + add ) >> shift;
    dst[ 3 * line] = ( iT[6]*a[0] + iT[3]*b[0] + iT[2]*c[1] + iT[7]*a[1] + iT[9]*c[2] + iT[0]*a[2] + iT[4]*c[3] - iT[5]*b[3] - iT[1]*a[4] - iT[8]*b[4] + t + add ) >> shift;
    dst[ 6 * line] = ( iT[8]*a[0] + iT[1]*c[0] + iT[6]*c[1] - iT[3]*b[1] - iT[5]*a[2] - iT[4]*b[2] - iT[7]*c[3] - iT[2]*a[3] - iT[0]*c[4] + iT[9]*b[4] + t + add ) >> shift;
    dst[ 8 * line] = ( iT[4]*c[0] + iT[5]*a[0] - iT[0]*c[1] + iT[9]*b[1] - iT[3]*c[2] - iT[6]*a[2] + iT[1]*c[3] - iT[8]*b[3] + iT[2]*c[4] + iT[7]*a[4] - t + add ) >> shift;
    dst[ 9 * line] = ( iT[7]*c[0] + iT[2]*a[0] - iT[4]*a[1] - iT[5]*b[1] - iT[8]*c[2] + iT[1]*b[2] + iT[9]*a[3] + iT[0]*b[3] + iT[3]*c[4] - iT[6]*b[4] + t + add ) >> shift;
    dst[11 * line] = ( iT[9]*a[0] + iT[0]*b[0] - iT[8]*c[1] - iT[1]*a[1] + iT[2]*c[2] - iT[7]*b[2] + iT[6]*a[3] + iT[3]*b[3] - iT[5]*c[4] - iT[4]*a[4] - t + add ) >> shift;
    dst[12 * line] = ( iT[7]*c[0] - iT[2]*b[0] - iT[5]*c[1] - iT[4]*a[1] + iT[8]*a[2] + iT[1]*b[2] - iT[0]*a[3] - iT[9]*b[3] - iT[6]*c[4] + iT[3]*b[4] + t + add ) >> shift;
    dst[14 * line] = ( iT[3]*a[0] + iT[6]*b[0] - iT[7]*a[1] - iT[2]*b[1] + iT[0]*c[2] + iT[9]*a[2] - iT[4]*c[3] - iT[5]*a[3] + iT[8]*c[4] + iT[1]*a[4] - t + add ) >> shift;
    dst[15 * line] = ( iT[1]*c[0] - iT[8]*b[0] - iT[3]*c[1] + iT[6]*b[1] + iT[5]*c[2] - iT[4]*b[2] - iT[7]*c[3] + iT[2]*b[3] + iT[9]*c[4] - iT[0]*b[4] + t + add ) >> shift;

    int tt[16];
    for (int i = 0; i < 16; i++)
      tt[i] = iT[i];

    src += 16;
    dst++;
  }

  if (iSkipLine)
  {
    dst = pCoef + reducedLine;
    for (j = 0; j < cutoff; j++)
    {
      memset(dst, 0, sizeof(TCoeff)*iSkipLine);
      dst += line;
    }
  }

  if (iSkipLine2)
  {
    dst = pCoef + line * cutoff;
    memset(dst, 0, sizeof(TCoeff) * line * iSkipLine2);
  }
#else
  _fastForwardMM< 16 >( src, dst, shift, line, iSkipLine, iSkipLine2, g_trCoreDST7P16[TRANSFORM_FORWARD][0] );
#endif
}

void fastForwardDST7_B32(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
#if !JVET_M0497_MATRIX_MULT
  int j, k;
  TCoeff a[10][6];
  TCoeff t[2];
  TCoeff b[6];
  TCoeff c[2];

  TCoeff add = (shift > 0) ? (1 << (shift - 1)) : 0;
  const TMatrixCoeff *iT = g_trCoreDST7P32[TRANSFORM_FORWARD][0];

  TCoeff *pCoef = dst;
  const int  reducedLine = line - iSkipLine;
  const int  cutoff = 32 - iSkipLine2;

  for (j = 0; j < reducedLine; j++)
  {
    for (k = 0; k < 6; k++)
    {
      a[0][k] = src[     k] - src[11 - k];
      a[1][k] = src[     k] + src[13 + k];
      a[2][k] = src[     k] + src[24 - k];
      a[3][k] = src[     k] - src[26 + k];
      a[4][k] = src[ 6 + k] + src[18 - k];
      a[5][k] = src[ 6 + k] + src[19 + k];
      a[6][k] = src[ 6 + k] - src[31 - k];
      a[7][k] = src[13 + k] - src[24 - k];
      a[8][k] = src[13 + k] + src[26 + k];
      a[9][k] = src[19 + k] + src[31 - k];

      b[k] = src[k] + src[11 - k] - src[13 + k] - src[24 - k] + src[26 + k];
    }
    for (k = 0; k < 2; k++)
    {
      c[k] = src[k] + src[3 - k] - src[5 + k] - src[8 - k] + src[10 + k] + src[13 - k] - src[15 + k] - src[18 - k] + src[20 + k] + src[23 - k] - src[25 + k] - src[28 - k] + src[30 + k];
    }

    t[0] = iT[12] * src[12] + iT[25] * src[25];
    t[1] = iT[12] * src[25] - iT[25] * src[12];

    dst[ 0 * line] = ( iT[0] * a[3][0] + iT[11] * a[6][5] + iT[13] * a[8][0] + iT[24] * a[9][5] + iT[1] * a[3][1] + iT[10] * a[6][4] + iT[14] * a[8][1] + iT[23] * a[9][4] + iT[2] * a[3][2] + iT[9] * a[6][3] + iT[15] * a[8][2] + iT[22] * a[9][3] + iT[3] * a[3][3] + iT[8] * a[6][2] + iT[16] * a[8][3] + iT[21] * a[9][2] + iT[4] * a[3][4] + iT[7] * a[6][1] + iT[17] * a[8][4] + iT[20] * a[9][1] + iT[5] * a[3][5] + iT[6] * a[6][0] + iT[18] * a[8][5] + iT[19] * a[9][0] + t[0] + add) >> shift;
    dst[ 1 * line] = (-iT[0] * a[5][2] + iT[11] * a[0][3] + iT[13] * a[4][2] + iT[24] * a[6][2] + iT[1] * a[9][1] + iT[10] * a[8][4] + iT[14] * a[3][4] + iT[23] * a[6][1] + iT[2] * a[0][0] - iT[9] * a[5][5] + iT[15] * a[6][5] + iT[22] * a[4][5] - iT[3] * a[5][3] + iT[8] * a[0][2] + iT[16] * a[4][3] + iT[21] * a[6][3] + iT[4] * a[9][0] + iT[7] * a[8][5] + iT[17] * a[3][5] + iT[20] * a[6][0] + iT[5] * a[0][1] - iT[6] * a[5][4] + iT[18] * a[6][4] + iT[19] * a[4][4] - t[1] + add) >> shift;
    dst[ 3 * line] = (-iT[0] * a[9][4] - iT[11] * a[5][4] + iT[13] * a[2][1] - iT[24] * a[7][1] - iT[1] * a[0][3] - iT[10] * a[1][3] + iT[14] * a[3][3] + iT[23] * a[2][3] + iT[2] * a[8][5] + iT[9] * a[9][0] + iT[15] * a[6][0] + iT[22] * a[3][5] - iT[3] * a[1][4] - iT[8] * a[0][4] + iT[16] * a[2][4] + iT[21] * a[3][4] - iT[4] * a[5][3] - iT[7] * a[9][3] - iT[17] * a[7][2] + iT[20] * a[2][2] + iT[5] * a[8][0] + iT[6] * a[1][0] - iT[18] * a[4][5] - iT[19] * a[7][0] + t[1] + add) >> shift;
    dst[ 4 * line] = (-iT[0] * a[3][2] - iT[11] * a[2][2] + iT[13] * a[1][2] + iT[24] * a[0][2] + iT[1] * a[6][0] + iT[10] * a[3][5] + iT[14] * a[9][0] + iT[23] * a[8][5] - iT[2] * a[2][3] - iT[9] * a[3][3] + iT[15] * a[0][3] + iT[22] * a[1][3] - iT[3] * a[7][0] + iT[8] * a[2][0] - iT[16] * a[9][5] - iT[21] * a[5][5] + iT[4] * a[4][4] + iT[7] * a[6][4] + iT[17] * a[0][1] - iT[20] * a[5][4] - iT[5] * a[7][4] - iT[6] * a[4][1] + iT[18] * a[8][4] + iT[19] * a[1][4] - t[0] + add) >> shift;
    dst[ 5 * line] = (-iT[0] * a[3][5] - iT[11] * a[6][0] - iT[13] * a[8][5] - iT[24] * a[9][0] + iT[1] * a[6][5] + iT[10] * a[3][0] + iT[14] * a[9][5] + iT[23] * a[8][0] - iT[2] * a[7][4] + iT[9] * a[2][4] - iT[15] * a[9][1] - iT[22] * a[5][1] - iT[3] * a[7][1] - iT[8] * a[4][4] + iT[16] * a[8][1] + iT[21] * a[1][1] + iT[4] * a[6][2] + iT[7] * a[4][2] - iT[17] * a[5][2] + iT[20] * a[0][3] - iT[5] * a[3][2] - iT[6] * a[2][2] + iT[18] * a[1][2] + iT[19] * a[0][2] + t[0] + add) >> shift;
    dst[ 8 * line] = ( iT[0] * a[9][3] + iT[11] * a[8][2] + iT[13] * a[3][2] + iT[24] * a[6][3] + iT[1] * a[1][5] + iT[10] * a[0][5] - iT[14] * a[2][5] - iT[23] * a[3][5] - iT[2] * a[1][3] - iT[9] * a[8][3] + iT[15] * a[7][3] + iT[22] * a[4][2] - iT[3] * a[9][5] - iT[8] * a[5][5] + iT[16] * a[2][0] - iT[21] * a[7][0] - iT[4] * a[1][1] - iT[7] * a[0][1] + iT[17] * a[2][1] + iT[20] * a[3][1] + iT[5] * a[5][1] + iT[6] * a[9][1] + iT[18] * a[7][4] - iT[19] * a[2][4] + t[1] + add) >> shift;
    dst[ 9 * line] = (-iT[0] * a[2][1] - iT[11] * a[3][1] + iT[13] * a[0][1] + iT[24] * a[1][1] + iT[1] * a[7][3] - iT[10] * a[2][3] + iT[14] * a[9][2] + iT[23] * a[5][2] + iT[2] * a[4][0] + iT[9] * a[7][5] - iT[15] * a[1][5] - iT[22] * a[8][5] + iT[3] * a[3][4] + iT[8] * a[2][4] - iT[16] * a[1][4] - iT[21] * a[0][4] + iT[4] * a[6][3] + iT[7] * a[3][2] + iT[17] * a[9][3] + iT[20] * a[8][2] + iT[5] * a[4][5] + iT[6] * a[6][5] + iT[18] * a[0][0] - iT[19] * a[5][5] - t[0] + add) >> shift;
    dst[10 * line] = (-iT[0] * a[6][1] - iT[11] * a[4][1] + iT[13] * a[5][1] - iT[24] * a[0][4] + iT[1] * a[2][2] - iT[10] * a[7][2] - iT[14] * a[5][3] - iT[23] * a[9][3] + iT[2] * a[6][4] + iT[9] * a[4][4] - iT[15] * a[5][4] + iT[22] * a[0][1] - iT[3] * a[2][5] + iT[8] * a[7][5] + iT[16] * a[5][0] + iT[21] * a[9][0] - iT[4] * a[7][0] - iT[7] * a[4][5] + iT[17] * a[8][0] + iT[20] * a[1][0] + iT[5] * a[4][2] + iT[6] * a[7][3] - iT[18] * a[1][3] - iT[19] * a[8][3] + t[0] + add) >> shift;
    dst[11 * line] = ( iT[0] * a[1][3] + iT[11] * a[0][3] - iT[13] * a[2][3] - iT[24] * a[3][3] + iT[1] * a[9][1] + iT[10] * a[5][1] - iT[14] * a[2][4] + iT[23] * a[7][4] + iT[2] * a[8][0] + iT[9] * a[9][5] + iT[15] * a[6][5] + iT[22] * a[3][0] - iT[3] * a[0][2] + iT[8] * a[5][3] - iT[16] * a[6][3] - iT[21] * a[4][3] - iT[4] * a[5][0] + iT[7] * a[0][5] + iT[17] * a[4][0] + iT[20] * a[6][0] - iT[5] * a[9][4] - iT[6] * a[5][4] + iT[18] * a[2][1] - iT[19] * a[7][1] - t[1] + add) >> shift;
    dst[13 * line] = (-iT[0] * a[0][0] - iT[11] * a[1][0] + iT[13] * a[3][0] + iT[24] * a[2][0] - iT[1] * a[5][4] + iT[10] * a[0][1] + iT[14] * a[4][4] + iT[23] * a[6][4] + iT[2] * a[9][3] + iT[9] * a[5][3] - iT[15] * a[2][2] + iT[22] * a[7][2] - iT[3] * a[8][3] - iT[8] * a[9][2] - iT[16] * a[6][2] - iT[21] * a[3][3] + iT[4] * a[1][4] + iT[7] * a[8][4] - iT[17] * a[7][4] - iT[20] * a[4][1] - iT[5] * a[0][5] - iT[6] * a[1][5] + iT[18] * a[3][5] + iT[19] * a[2][5] + t[1] + add) >> shift;
    dst[14 * line] = ( iT[0] * a[4][2] + iT[11] * a[7][3] - iT[13] * a[1][3] - iT[24] * a[8][3] + iT[1] * a[4][1] + iT[10] * a[6][1] + iT[14] * a[0][4] - iT[23] * a[5][1] - iT[2] * a[3][0] - iT[9] * a[2][0] + iT[15] * a[1][0] + iT[22] * a[0][0] - iT[3] * a[6][3] - iT[8] * a[4][3] + iT[16] * a[5][3] - iT[21] * a[0][2] - iT[4] * a[7][5] - iT[7] * a[4][0] + iT[17] * a[8][5] + iT[20] * a[1][5] + iT[5] * a[6][4] + iT[6] * a[3][1] + iT[18] * a[9][4] + iT[19] * a[8][1] - t[0] + add) >> shift;
    dst[15 * line] = (-iT[0] * a[7][4] - iT[11] * a[4][1] + iT[13] * a[8][4] + iT[24] * a[1][4] + iT[1] * a[2][2] + iT[10] * a[3][2] - iT[14] * a[0][2] - iT[23] * a[1][2] + iT[2] * a[2][1] - iT[9] * a[7][1] - iT[15] * a[5][4] - iT[22] * a[9][4] - iT[3] * a[7][5] + iT[8] * a[2][5] - iT[16] * a[9][0] - iT[21] * a[5][0] - iT[4] * a[2][0] - iT[7] * a[3][0] + iT[17] * a[0][0] + iT[20] * a[1][0] - iT[5] * a[2][3] + iT[6] * a[7][3] + iT[18] * a[5][2] + iT[19] * a[9][2] + t[0] + add) >> shift;
    dst[16 * line] = (-iT[0] * a[0][1] + iT[11] * a[5][4] - iT[13] * a[6][4] - iT[24] * a[4][4] + iT[1] * a[0][3] - iT[10] * a[5][2] + iT[14] * a[6][2] + iT[23] * a[4][2] - iT[2] * a[0][5] + iT[9] * a[5][0] - iT[15] * a[6][0] - iT[22] * a[4][0] - iT[3] * a[0][4] - iT[8] * a[1][4] + iT[16] * a[3][4] + iT[21] * a[2][4] + iT[4] * a[0][2] + iT[7] * a[1][2] - iT[17] * a[3][2] - iT[20] * a[2][2] - iT[5] * a[0][0] - iT[6] * a[1][0] + iT[18] * a[3][0] + iT[19] * a[2][0] - t[1] + add) >> shift;
    dst[18 * line] = ( iT[0] * a[0][5] + iT[11] * a[1][5] - iT[13] * a[3][5] - iT[24] * a[2][5] - iT[1] * a[1][0] - iT[10] * a[0][0] + iT[14] * a[2][0] + iT[23] * a[3][0] - iT[2] * a[5][1] + iT[9] * a[0][4] + iT[15] * a[4][1] + iT[22] * a[6][1] - iT[3] * a[8][1] - iT[8] * a[1][1] + iT[16] * a[4][4] + iT[21] * a[7][1] - iT[4] * a[9][2] - iT[7] * a[5][2] + iT[17] * a[2][3] - iT[20] * a[7][3] - iT[5] * a[9][3] - iT[6] * a[8][2] - iT[18] * a[3][2] - iT[19] * a[6][3] + t[1] + add) >> shift;
    dst[20 * line] = (-iT[0] * a[4][0] - iT[11] * a[6][0] - iT[13] * a[0][5] + iT[24] * a[5][0] + iT[1] * a[6][5] + iT[10] * a[4][5] - iT[14] * a[5][5] + iT[23] * a[0][0] - iT[2] * a[6][1] - iT[9] * a[3][4] - iT[15] * a[9][1] - iT[22] * a[8][4] + iT[3] * a[4][4] + iT[8] * a[7][1] - iT[16] * a[1][1] - iT[21] * a[8][1] - iT[4] * a[3][3] - iT[7] * a[2][3] + iT[17] * a[1][3] + iT[20] * a[0][3] + iT[5] * a[7][2] - iT[6] * a[2][2] + iT[18] * a[9][3] + iT[19] * a[5][3] + t[0] + add) >> shift;
    dst[21 * line] = (-iT[0] * a[1][2] - iT[11] * a[8][2] + iT[13] * a[7][2] + iT[24] * a[4][3] - iT[1] * a[1][5] - iT[10] * a[8][5] + iT[14] * a[7][5] + iT[23] * a[4][0] - iT[2] * a[5][2] - iT[9] * a[9][2] - iT[15] * a[7][3] + iT[22] * a[2][3] - iT[3] * a[5][5] - iT[8] * a[9][5] - iT[16] * a[7][0] + iT[21] * a[2][0] - iT[4] * a[8][1] - iT[7] * a[9][4] - iT[17] * a[6][4] - iT[20] * a[3][1] - iT[5] * a[8][4] - iT[6] * a[9][1] - iT[18] * a[6][1] - iT[19] * a[3][4] - t[1] + add) >> shift;
    dst[23 * line] = (-iT[0] * a[8][4] - iT[11] * a[9][1] - iT[13] * a[6][1] - iT[24] * a[3][4] + iT[1] * a[8][2] + iT[10] * a[1][2] - iT[14] * a[4][3] - iT[23] * a[7][2] + iT[2] * a[0][1] + iT[9] * a[1][1] - iT[15] * a[3][1] - iT[22] * a[2][1] - iT[3] * a[5][0] - iT[8] * a[9][0] - iT[16] * a[7][5] + iT[21] * a[2][5] + iT[4] * a[9][5] + iT[7] * a[8][0] + iT[17] * a[3][0] + iT[20] * a[6][5] - iT[5] * a[5][2] + iT[6] * a[0][3] + iT[18] * a[4][2] + iT[19] * a[6][2] + t[1] + add) >> shift;
    dst[24 * line] = (-iT[0] * a[2][3] + iT[11] * a[7][3] + iT[13] * a[5][2] + iT[24] * a[9][2] + iT[1] * a[4][1] + iT[10] * a[7][4] - iT[14] * a[1][4] - iT[23] * a[8][4] - iT[2] * a[4][5] - iT[9] * a[7][0] + iT[15] * a[1][0] + iT[22] * a[8][0] + iT[3] * a[4][3] + iT[8] * a[6][3] + iT[16] * a[0][2] - iT[21] * a[5][3] - iT[4] * a[2][5] - iT[7] * a[3][5] + iT[17] * a[0][5] + iT[20] * a[1][5] + iT[5] * a[2][1] + iT[6] * a[3][1] - iT[18] * a[0][1] - iT[19] * a[1][1] - t[0] + add) >> shift;
    dst[25 * line] = ( iT[0] * a[4][5] + iT[11] * a[6][5] + iT[13] * a[0][0] - iT[24] * a[5][5] + iT[1] * a[3][1] + iT[10] * a[2][1] - iT[14] * a[1][1] - iT[23] * a[0][1] - iT[2] * a[7][2] - iT[9] * a[4][3] + iT[15] * a[8][2] + iT[22] * a[1][2] - iT[3] * a[6][2] - iT[8] * a[3][3] - iT[16] * a[9][2] - iT[21] * a[8][3] - iT[4] * a[2][4] + iT[7] * a[7][4] + iT[17] * a[5][1] + iT[20] * a[9][1] + iT[5] * a[4][0] + iT[6] * a[6][0] + iT[18] * a[0][5] - iT[19] * a[5][0] + t[0] + add) >> shift;
    dst[26 * line] = ( iT[0] * a[8][0] + iT[11] * a[1][0] - iT[13] * a[4][5] - iT[24] * a[7][0] + iT[1] * a[5][4] + iT[10] * a[9][4] + iT[14] * a[7][1] - iT[23] * a[2][1] - iT[2] * a[1][2] - iT[9] * a[0][2] + iT[15] * a[2][2] + iT[22] * a[3][2] - iT[3] * a[9][2] - iT[8] * a[8][3] - iT[16] * a[3][3] - iT[21] * a[6][2] + iT[4] * a[0][4] - iT[7] * a[5][1] + iT[17] * a[6][1] + iT[20] * a[4][1] + iT[5] * a[8][5] + iT[6] * a[1][5] - iT[18] * a[4][0] - iT[19] * a[7][5] - t[1] + add) >> shift;
    dst[28 * line] = (-iT[0] * a[5][1] - iT[11] * a[9][1] - iT[13] * a[7][4] + iT[24] * a[2][4] + iT[1] * a[8][2] + iT[10] * a[9][3] + iT[14] * a[6][3] + iT[23] * a[3][2] - iT[2] * a[9][4] - iT[9] * a[8][1] - iT[15] * a[3][1] - iT[22] * a[6][4] + iT[3] * a[9][0] + iT[8] * a[5][0] - iT[16] * a[2][5] + iT[21] * a[7][5] - iT[4] * a[5][5] + iT[7] * a[0][0] + iT[17] * a[4][5] + iT[20] * a[6][5] + iT[5] * a[1][3] + iT[6] * a[0][3] - iT[18] * a[2][3] - iT[19] * a[3][3] + t[1] + add) >> shift;
    dst[29 * line] = (-iT[0] * a[6][4] - iT[11] * a[3][1] - iT[13] * a[9][4] - iT[24] * a[8][1] + iT[1] * a[7][3] + iT[10] * a[4][2] - iT[14] * a[8][3] - iT[23] * a[1][3] + iT[2] * a[3][5] + iT[9] * a[2][5] - iT[15] * a[1][5] - iT[22] * a[0][5] - iT[3] * a[2][4] - iT[8] * a[3][4] + iT[16] * a[0][4] + iT[21] * a[1][4] - iT[4] * a[4][3] - iT[7] * a[7][2] + iT[17] * a[1][2] + iT[20] * a[8][2] + iT[5] * a[3][0] + iT[6] * a[6][5] + iT[18] * a[8][0] + iT[19] * a[9][5] - t[0] + add) >> shift;
    dst[30 * line] = (-iT[0] * a[7][2] + iT[11] * a[2][2] - iT[13] * a[9][3] - iT[24] * a[5][3] - iT[1] * a[6][0] - iT[10] * a[4][0] + iT[14] * a[5][0] - iT[23] * a[0][5] - iT[2] * a[4][2] - iT[9] * a[6][2] - iT[15] * a[0][3] + iT[22] * a[5][2] + iT[3] * a[2][0] - iT[8] * a[7][0] - iT[16] * a[5][5] - iT[21] * a[9][5] + iT[4] * a[7][1] - iT[7] * a[2][1] + iT[17] * a[9][4] + iT[20] * a[5][4] + iT[5] * a[6][1] + iT[6] * a[4][1] - iT[18] * a[5][1] + iT[19] * a[0][4] + t[0] + add) >> shift;
    dst[31 * line] = (-iT[0] * a[8][5] - iT[11] * a[1][5] + iT[13] * a[4][0] + iT[24] * a[7][5] + iT[1] * a[1][0] + iT[10] * a[8][0] - iT[14] * a[7][0] - iT[23] * a[4][5] + iT[2] * a[8][4] + iT[9] * a[1][4] - iT[15] * a[4][1] - iT[22] * a[7][4] - iT[3] * a[1][1] - iT[8] * a[8][1] + iT[16] * a[7][1] + iT[21] * a[4][4] - iT[4] * a[8][3] - iT[7] * a[1][3] + iT[17] * a[4][2] + iT[20] * a[7][3] + iT[5] * a[1][2] + iT[6] * a[8][2] - iT[18] * a[7][2] - iT[19] * a[4][3] - t[1] + add) >> shift;

    dst[ 2 * line] = (iT[ 4]*b[0] + iT[ 9]*b[1] + iT[14]*b[2] + iT[19]*b[3] + iT[24]*b[4] + iT[29]*b[5] + add) >> shift;
    dst[ 7 * line] = (iT[14]*b[0] + iT[29]*b[1] + iT[19]*b[2] + iT[ 4]*b[3] - iT[ 9]*b[4] - iT[24]*b[5] + add) >> shift;
    dst[12 * line] = (iT[24]*b[0] + iT[14]*b[1] - iT[ 9]*b[2] - iT[29]*b[3] - iT[ 4]*b[4] + iT[19]*b[5] + add) >> shift;
    dst[17 * line] = (iT[29]*b[0] - iT[ 4]*b[1] - iT[24]*b[2] + iT[ 9]*b[3] + iT[19]*b[4] - iT[14]*b[5] + add) >> shift;
    dst[22 * line] = (iT[19]*b[0] - iT[24]*b[1] + iT[ 4]*b[2] + iT[14]*b[3] - iT[29]*b[4] + iT[ 9]*b[5] + add) >> shift;
    dst[27 * line] = (iT[ 9]*b[0] - iT[19]*b[1] + iT[29]*b[2] - iT[24]*b[3] + iT[14]*b[4] - iT[ 4]*b[5] + add) >> shift;

    dst[ 6 * line] = (iT[12]*c[0] + iT[25]*c[1] + add) >> shift;
    dst[19 * line] = (iT[25]*c[0] - iT[12]*c[1] + add) >> shift;

    int tt[32];
    for (int i = 0; i < 32; i++)
      tt[i] = iT[i];

    src += 32;
    dst++;
  }

  if (iSkipLine)
  {
    dst = pCoef + reducedLine;
    for (j = 0; j < cutoff; j++)
    {
      memset(dst, 0, sizeof(TCoeff)*iSkipLine);
      dst += line;
    }
  }

  if (iSkipLine2)
  {
    dst = pCoef + line * cutoff;
    memset(dst, 0, sizeof(TCoeff) * line * iSkipLine2);
  }
#else
  _fastForwardMM< 32 >( src, dst, shift, line, iSkipLine, iSkipLine2, g_trCoreDST7P32[TRANSFORM_FORWARD][0] );
#endif
}


// ********************************** DCT-VIII **********************************
void fastForwardDCT8_B4(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
  int i;
  int rnd_factor = 1 << (shift - 1);
  const TMatrixCoeff *iT = g_trCoreDCT8P4[TRANSFORM_FORWARD][0];

  TCoeff c[4];
  TCoeff *pCoeff = dst;
  const int  reducedLine = line - iSkipLine;
  for (i = 0; i<reducedLine; i++)
  {
    // Intermediate Variables
    c[0] = src[0] + src[3];
    c[1] = src[2] + src[0];
    c[2] = src[3] - src[2];
    c[3] = iT[1] * src[1];

    dst[0 * line] = (iT[3] * c[0] + iT[2] * c[1] + c[3] + rnd_factor) >> shift;
    dst[1 * line] = (iT[1] * (src[0] - src[2] - src[3]) + rnd_factor) >> shift;
    dst[2 * line] = (iT[3] * c[2] + iT[2] * c[0] - c[3] + rnd_factor) >> shift;
    dst[3 * line] = (iT[3] * c[1] - iT[2] * c[2] - c[3] + rnd_factor) >> shift;

    src += 4;
    dst++;
  }
  if (iSkipLine)
  {
    dst = pCoeff + reducedLine;
    for (i = 0; i<4; i++)
    {
      memset(dst, 0, sizeof(TCoeff)*iSkipLine);
      dst += line;
    }
  }
}



void fastForwardDCT8_B8(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
  _fastForwardMM< 8 >( src, dst, shift, line, iSkipLine, iSkipLine2, g_trCoreDCT8P8[TRANSFORM_FORWARD][0] );
}



void fastForwardDCT8_B16(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
#if !JVET_M0497_MATRIX_MULT
  int j, k;
  TCoeff a[5], b[5], c[5], d[5], t;
  TCoeff add = (shift > 0) ? (1 << (shift - 1)) : 0;

  const TMatrixCoeff *iT = g_trCoreDST7P16[TRANSFORM_FORWARD][0];

  TCoeff *pCoef = dst;
  const int  reducedLine = line - iSkipLine;
  const int  cutoff = 16 - iSkipLine2;

  for (j = 0; j < reducedLine; j++)
  {
    for (k = 0; k < 5; k++)
    {
      a[k] = src[15 - k] + src[ 4 - k];
      b[k] = src[ 6 + k] + src[ 4 - k];
      c[k] = src[15 - k] - src[ 6 + k];
      d[k] = src[15 - k] + src[ 6 + k] - src[ 4 - k];
    }

    t = iT[10] * src[5];

    dst[ 1 * line] = ( - iT[ 2]*d[0] - iT[ 5]*d[1] - iT[ 8]*d[2] - iT[11]*d[3] - iT[14]*d[4] + add) >> shift;
    dst[ 4 * line] = (   iT[ 8]*d[0] + iT[14]*d[1] + iT[ 5]*d[2] - iT[ 2]*d[3] - iT[11]*d[4] + add) >> shift;
    dst[ 7 * line] = ( - iT[14]*d[0] - iT[ 2]*d[1] + iT[11]*d[2] + iT[ 5]*d[3] - iT[ 8]*d[4] + add) >> shift;
    dst[10 * line] = (   iT[11]*d[0] - iT[ 8]*d[1] - iT[ 2]*d[2] + iT[14]*d[3] - iT[ 5]*d[4] + add) >> shift;
    dst[13 * line] = ( - iT[ 5]*d[0] + iT[11]*d[1] - iT[14]*d[2] + iT[ 8]*d[3] - iT[ 2]*d[4] + add) >> shift;

    dst[ 5 * line] = ( - iT[10] * (src[15] + src[14] - src[12] - src[11] + src[9] + src[8] - src[6] - src[5] + src[3] + src[2] - src[0]) + add) >> shift;

    dst[ 0 * line] = (   iT[0]*a[0] + iT[9]*b[0] + iT[1]*a[1] + iT[8]*b[1] + iT[2]*a[2] + iT[7]*b[2] + iT[3]*a[3] + iT[6]*b[3] + iT[4]*a[4] + iT[5]*b[4] + t + add ) >> shift;
    dst[ 2 * line] = (   iT[4]*c[0] - iT[5]*b[0] + iT[9]*c[1] - iT[0]*b[1] + iT[6]*c[2] + iT[3]*a[2] + iT[1]*c[3] + iT[8]*a[3] + iT[7]*a[4] + iT[2]*b[4] - t + add ) >> shift;
    dst[ 3 * line] = ( - iT[6]*a[0] - iT[3]*b[0] - iT[2]*c[1] - iT[7]*a[1] - iT[9]*c[2] - iT[0]*a[2] - iT[4]*c[3] + iT[5]*b[3] + iT[1]*a[4] + iT[8]*b[4] - t + add ) >> shift;
    dst[ 6 * line] = (   iT[8]*a[0] + iT[1]*c[0] + iT[6]*c[1] - iT[3]*b[1] - iT[5]*a[2] - iT[4]*b[2] - iT[7]*c[3] - iT[2]*a[3] - iT[0]*c[4] + iT[9]*b[4] + t + add ) >> shift;
    dst[ 8 * line] = (   iT[4]*c[0] + iT[5]*a[0] - iT[0]*c[1] + iT[9]*b[1] - iT[3]*c[2] - iT[6]*a[2] + iT[1]*c[3] - iT[8]*b[3] + iT[2]*c[4] + iT[7]*a[4] - t + add ) >> shift;
    dst[ 9 * line] = ( - iT[7]*c[0] - iT[2]*a[0] + iT[4]*a[1] + iT[5]*b[1] + iT[8]*c[2] - iT[1]*b[2] - iT[9]*a[3] - iT[0]*b[3] - iT[3]*c[4] + iT[6]*b[4] - t + add ) >> shift;
    dst[11 * line] = ( - iT[9]*a[0] - iT[0]*b[0] + iT[8]*c[1] + iT[1]*a[1] - iT[2]*c[2] + iT[7]*b[2] - iT[6]*a[3] - iT[3]*b[3] + iT[5]*c[4] + iT[4]*a[4] + t + add ) >> shift;
    dst[12 * line] = (   iT[7]*c[0] - iT[2]*b[0] - iT[5]*c[1] - iT[4]*a[1] + iT[8]*a[2] + iT[1]*b[2] - iT[0]*a[3] - iT[9]*b[3] - iT[6]*c[4] + iT[3]*b[4] + t + add ) >> shift;
    dst[14 * line] = (   iT[3]*a[0] + iT[6]*b[0] - iT[7]*a[1] - iT[2]*b[1] + iT[0]*c[2] + iT[9]*a[2] - iT[4]*c[3] - iT[5]*a[3] + iT[8]*c[4] + iT[1]*a[4] - t + add ) >> shift;
    dst[15 * line] = ( - iT[1]*c[0] + iT[8]*b[0] + iT[3]*c[1] - iT[6]*b[1] - iT[5]*c[2] + iT[4]*b[2] + iT[7]*c[3] - iT[2]*b[3] - iT[9]*c[4] + iT[0]*b[4] - t + add ) >> shift;

    src += 16;
    dst++;
  }

  if (iSkipLine)
  {
    dst = pCoef + reducedLine;
    for (j = 0; j < cutoff; j++)
    {
      memset(dst, 0, sizeof(TCoeff)*iSkipLine);
      dst += line;
    }
  }

  if (iSkipLine2)
  {
    dst = pCoef + line * cutoff;
    memset(dst, 0, sizeof(TCoeff) * line * iSkipLine2);
  }
#else
  _fastForwardMM< 16 >( src, dst, shift, line, iSkipLine, iSkipLine2, g_trCoreDCT8P16[TRANSFORM_FORWARD][0] );
#endif
}



void fastForwardDCT8_B32(const TCoeff *src, TCoeff *dst, int shift, int line, int iSkipLine, int iSkipLine2)
{
#if !JVET_M0497_MATRIX_MULT
  int j, k;
  TCoeff a[10][6];
  TCoeff t[2];
  TCoeff b[6];
  TCoeff c[2];

  TCoeff add = (shift > 0) ? (1 << (shift - 1)) : 0;
  const TMatrixCoeff *iT = g_trCoreDST7P32[TRANSFORM_FORWARD][0];
  
  TCoeff *pCoef = dst;
  const int  reducedLine = line - iSkipLine;
  const int  cutoff = 32 - iSkipLine2;

  for (j = 0; j < reducedLine; j++)
  {
    for (k = 0; k < 6; k++)
    {
      a[0][k] = src[31-k] - src[20+k];
      a[1][k] = src[31-k] + src[18-k];
      a[2][k] = src[31-k] + src[ 7+k];
      a[3][k] = src[31-k] - src[ 5-k];
      a[4][k] = src[25-k] + src[13+k];
      a[5][k] = src[25-k] + src[12-k];
      a[6][k] = src[25-k] - src[   k];
      a[7][k] = src[18-k] - src[ 7+k];
      a[8][k] = src[18-k] + src[ 5-k];
      a[9][k] = src[12-k] + src[   k];

      b[k] = src[31-k] + src[20+k] - src[18-k] - src[7+k] + src[5-k];
    }

    for (k = 0; k < 2; k++)
    {
      c[k] = src[31-k] + src[28+k] - src[26-k] - src[23+k] + src[21-k] + src[18+k] - src[16-k] - src[13+k] + src[11-k] + src[8+k] - src[6-k] - src[3+k] + src[1-k];
    }

    t[0] = iT[12] * src[19] + iT[25] * src[6];
    t[1] = iT[12] * src[6] - iT[25] * src[19];

    dst[ 0 * line] = (   iT[0] * a[3][0] + iT[11] * a[6][5] + iT[13] * a[8][0] + iT[24] * a[9][5] + iT[1] * a[3][1] + iT[10] * a[6][4] + iT[14] * a[8][1] + iT[23] * a[9][4] + iT[2] * a[3][2] + iT[9] * a[6][3] + iT[15] * a[8][2] + iT[22] * a[9][3] + iT[3] * a[3][3] + iT[8] * a[6][2] + iT[16] * a[8][3] + iT[21] * a[9][2] + iT[4] * a[3][4] + iT[7] * a[6][1] + iT[17] * a[8][4] + iT[20] * a[9][1] + iT[5] * a[3][5] + iT[6] * a[6][0] + iT[18] * a[8][5] + iT[19] * a[9][0] + t[0] + add) >> shift;
    dst[ 1 * line] = (   iT[0] * a[5][2] - iT[11] * a[0][3] - iT[13] * a[4][2] - iT[24] * a[6][2] - iT[1] * a[9][1] - iT[10] * a[8][4] - iT[14] * a[3][4] - iT[23] * a[6][1] - iT[2] * a[0][0] + iT[9] * a[5][5] - iT[15] * a[6][5] - iT[22] * a[4][5] + iT[3] * a[5][3] - iT[8] * a[0][2] - iT[16] * a[4][3] - iT[21] * a[6][3] - iT[4] * a[9][0] - iT[7] * a[8][5] - iT[17] * a[3][5] - iT[20] * a[6][0] - iT[5] * a[0][1] + iT[6] * a[5][4] - iT[18] * a[6][4] - iT[19] * a[4][4] + t[1] + add) >> shift;
    dst[ 3 * line] = (   iT[0] * a[9][4] + iT[11] * a[5][4] - iT[13] * a[2][1] + iT[24] * a[7][1] + iT[1] * a[0][3] + iT[10] * a[1][3] - iT[14] * a[3][3] - iT[23] * a[2][3] - iT[2] * a[8][5] - iT[9] * a[9][0] - iT[15] * a[6][0] - iT[22] * a[3][5] + iT[3] * a[1][4] + iT[8] * a[0][4] - iT[16] * a[2][4] - iT[21] * a[3][4] + iT[4] * a[5][3] + iT[7] * a[9][3] + iT[17] * a[7][2] - iT[20] * a[2][2] - iT[5] * a[8][0] - iT[6] * a[1][0] + iT[18] * a[4][5] + iT[19] * a[7][0] - t[1] + add) >> shift;
    dst[ 4 * line] = ( - iT[0] * a[3][2] - iT[11] * a[2][2] + iT[13] * a[1][2] + iT[24] * a[0][2] + iT[1] * a[6][0] + iT[10] * a[3][5] + iT[14] * a[9][0] + iT[23] * a[8][5] - iT[2] * a[2][3] - iT[9] * a[3][3] + iT[15] * a[0][3] + iT[22] * a[1][3] - iT[3] * a[7][0] + iT[8] * a[2][0] - iT[16] * a[9][5] - iT[21] * a[5][5] + iT[4] * a[4][4] + iT[7] * a[6][4] + iT[17] * a[0][1] - iT[20] * a[5][4] - iT[5] * a[7][4] - iT[6] * a[4][1] + iT[18] * a[8][4] + iT[19] * a[1][4] - t[0] + add) >> shift;
    dst[ 5 * line] = (   iT[0] * a[3][5] + iT[11] * a[6][0] + iT[13] * a[8][5] + iT[24] * a[9][0] - iT[1] * a[6][5] - iT[10] * a[3][0] - iT[14] * a[9][5] - iT[23] * a[8][0] + iT[2] * a[7][4] - iT[9] * a[2][4] + iT[15] * a[9][1] + iT[22] * a[5][1] + iT[3] * a[7][1] + iT[8] * a[4][4] - iT[16] * a[8][1] - iT[21] * a[1][1] - iT[4] * a[6][2] - iT[7] * a[4][2] + iT[17] * a[5][2] - iT[20] * a[0][3] + iT[5] * a[3][2] + iT[6] * a[2][2] - iT[18] * a[1][2] - iT[19] * a[0][2] - t[0] + add) >> shift;
    dst[ 8 * line] = (   iT[0] * a[9][3] + iT[11] * a[8][2] + iT[13] * a[3][2] + iT[24] * a[6][3] + iT[1] * a[1][5] + iT[10] * a[0][5] - iT[14] * a[2][5] - iT[23] * a[3][5] - iT[2] * a[1][3] - iT[9] * a[8][3] + iT[15] * a[7][3] + iT[22] * a[4][2] - iT[3] * a[9][5] - iT[8] * a[5][5] + iT[16] * a[2][0] - iT[21] * a[7][0] - iT[4] * a[1][1] - iT[7] * a[0][1] + iT[17] * a[2][1] + iT[20] * a[3][1] + iT[5] * a[5][1] + iT[6] * a[9][1] + iT[18] * a[7][4] - iT[19] * a[2][4] + t[1] + add) >> shift;
    dst[ 9 * line] = (   iT[0] * a[2][1] + iT[11] * a[3][1] - iT[13] * a[0][1] - iT[24] * a[1][1] - iT[1] * a[7][3] + iT[10] * a[2][3] - iT[14] * a[9][2] - iT[23] * a[5][2] - iT[2] * a[4][0] - iT[9] * a[7][5] + iT[15] * a[1][5] + iT[22] * a[8][5] - iT[3] * a[3][4] - iT[8] * a[2][4] + iT[16] * a[1][4] + iT[21] * a[0][4] - iT[4] * a[6][3] - iT[7] * a[3][2] - iT[17] * a[9][3] - iT[20] * a[8][2] - iT[5] * a[4][5] - iT[6] * a[6][5] - iT[18] * a[0][0] + iT[19] * a[5][5] + t[0] + add) >> shift;
    dst[10 * line] = ( - iT[0] * a[6][1] - iT[11] * a[4][1] + iT[13] * a[5][1] - iT[24] * a[0][4] + iT[1] * a[2][2] - iT[10] * a[7][2] - iT[14] * a[5][3] - iT[23] * a[9][3] + iT[2] * a[6][4] + iT[9] * a[4][4] - iT[15] * a[5][4] + iT[22] * a[0][1] - iT[3] * a[2][5] + iT[8] * a[7][5] + iT[16] * a[5][0] + iT[21] * a[9][0] - iT[4] * a[7][0] - iT[7] * a[4][5] + iT[17] * a[8][0] + iT[20] * a[1][0] + iT[5] * a[4][2] + iT[6] * a[7][3] - iT[18] * a[1][3] - iT[19] * a[8][3] + t[0] + add) >> shift;
    dst[11 * line] = ( - iT[0] * a[1][3] - iT[11] * a[0][3] + iT[13] * a[2][3] + iT[24] * a[3][3] - iT[1] * a[9][1] - iT[10] * a[5][1] + iT[14] * a[2][4] - iT[23] * a[7][4] - iT[2] * a[8][0] - iT[9] * a[9][5] - iT[15] * a[6][5] - iT[22] * a[3][0] + iT[3] * a[0][2] - iT[8] * a[5][3] + iT[16] * a[6][3] + iT[21] * a[4][3] + iT[4] * a[5][0] - iT[7] * a[0][5] - iT[17] * a[4][0] - iT[20] * a[6][0] + iT[5] * a[9][4] + iT[6] * a[5][4] - iT[18] * a[2][1] + iT[19] * a[7][1] + t[1] + add) >> shift;
    dst[13 * line] = (   iT[0] * a[0][0] + iT[11] * a[1][0] - iT[13] * a[3][0] - iT[24] * a[2][0] + iT[1] * a[5][4] - iT[10] * a[0][1] - iT[14] * a[4][4] - iT[23] * a[6][4] - iT[2] * a[9][3] - iT[9] * a[5][3] + iT[15] * a[2][2] - iT[22] * a[7][2] + iT[3] * a[8][3] + iT[8] * a[9][2] + iT[16] * a[6][2] + iT[21] * a[3][3] - iT[4] * a[1][4] - iT[7] * a[8][4] + iT[17] * a[7][4] + iT[20] * a[4][1] + iT[5] * a[0][5] + iT[6] * a[1][5] - iT[18] * a[3][5] - iT[19] * a[2][5] - t[1] + add) >> shift;
    dst[14 * line] = (   iT[0] * a[4][2] + iT[11] * a[7][3] - iT[13] * a[1][3] - iT[24] * a[8][3] + iT[1] * a[4][1] + iT[10] * a[6][1] + iT[14] * a[0][4] - iT[23] * a[5][1] - iT[2] * a[3][0] - iT[9] * a[2][0] + iT[15] * a[1][0] + iT[22] * a[0][0] - iT[3] * a[6][3] - iT[8] * a[4][3] + iT[16] * a[5][3] - iT[21] * a[0][2] - iT[4] * a[7][5] - iT[7] * a[4][0] + iT[17] * a[8][5] + iT[20] * a[1][5] + iT[5] * a[6][4] + iT[6] * a[3][1] + iT[18] * a[9][4] + iT[19] * a[8][1] - t[0] + add) >> shift;
    dst[15 * line] = (   iT[0] * a[7][4] + iT[11] * a[4][1] - iT[13] * a[8][4] - iT[24] * a[1][4] - iT[1] * a[2][2] - iT[10] * a[3][2] + iT[14] * a[0][2] + iT[23] * a[1][2] - iT[2] * a[2][1] + iT[9] * a[7][1] + iT[15] * a[5][4] + iT[22] * a[9][4] + iT[3] * a[7][5] - iT[8] * a[2][5] + iT[16] * a[9][0] + iT[21] * a[5][0] + iT[4] * a[2][0] + iT[7] * a[3][0] - iT[17] * a[0][0] - iT[20] * a[1][0] + iT[5] * a[2][3] - iT[6] * a[7][3] - iT[18] * a[5][2] - iT[19] * a[9][2] - t[0] + add) >> shift;
    dst[16 * line] = ( - iT[0] * a[0][1] + iT[11] * a[5][4] - iT[13] * a[6][4] - iT[24] * a[4][4] + iT[1] * a[0][3] - iT[10] * a[5][2] + iT[14] * a[6][2] + iT[23] * a[4][2] - iT[2] * a[0][5] + iT[9] * a[5][0] - iT[15] * a[6][0] - iT[22] * a[4][0] - iT[3] * a[0][4] - iT[8] * a[1][4] + iT[16] * a[3][4] + iT[21] * a[2][4] + iT[4] * a[0][2] + iT[7] * a[1][2] - iT[17] * a[3][2] - iT[20] * a[2][2] - iT[5] * a[0][0] - iT[6] * a[1][0] + iT[18] * a[3][0] + iT[19] * a[2][0] - t[1] + add) >> shift;
    dst[18 * line] = (   iT[0] * a[0][5] + iT[11] * a[1][5] - iT[13] * a[3][5] - iT[24] * a[2][5] - iT[1] * a[1][0] - iT[10] * a[0][0] + iT[14] * a[2][0] + iT[23] * a[3][0] - iT[2] * a[5][1] + iT[9] * a[0][4] + iT[15] * a[4][1] + iT[22] * a[6][1] - iT[3] * a[8][1] - iT[8] * a[1][1] + iT[16] * a[4][4] + iT[21] * a[7][1] - iT[4] * a[9][2] - iT[7] * a[5][2] + iT[17] * a[2][3] - iT[20] * a[7][3] - iT[5] * a[9][3] - iT[6] * a[8][2] - iT[18] * a[3][2] - iT[19] * a[6][3] + t[1] + add) >> shift;
    dst[20 * line] = ( - iT[0] * a[4][0] - iT[11] * a[6][0] - iT[13] * a[0][5] + iT[24] * a[5][0] + iT[1] * a[6][5] + iT[10] * a[4][5] - iT[14] * a[5][5] + iT[23] * a[0][0] - iT[2] * a[6][1] - iT[9] * a[3][4] - iT[15] * a[9][1] - iT[22] * a[8][4] + iT[3] * a[4][4] + iT[8] * a[7][1] - iT[16] * a[1][1] - iT[21] * a[8][1] - iT[4] * a[3][3] - iT[7] * a[2][3] + iT[17] * a[1][3] + iT[20] * a[0][3] + iT[5] * a[7][2] - iT[6] * a[2][2] + iT[18] * a[9][3] + iT[19] * a[5][3] + t[0] + add) >> shift;
    dst[21 * line] = (   iT[0] * a[1][2] + iT[11] * a[8][2] - iT[13] * a[7][2] - iT[24] * a[4][3] + iT[1] * a[1][5] + iT[10] * a[8][5] - iT[14] * a[7][5] - iT[23] * a[4][0] + iT[2] * a[5][2] + iT[9] * a[9][2] + iT[15] * a[7][3] - iT[22] * a[2][3] + iT[3] * a[5][5] + iT[8] * a[9][5] + iT[16] * a[7][0] - iT[21] * a[2][0] + iT[4] * a[8][1] + iT[7] * a[9][4] + iT[17] * a[6][4] + iT[20] * a[3][1] + iT[5] * a[8][4] + iT[6] * a[9][1] + iT[18] * a[6][1] + iT[19] * a[3][4] + t[1] + add) >> shift;
    dst[23 * line] = (   iT[0] * a[8][4] + iT[11] * a[9][1] + iT[13] * a[6][1] + iT[24] * a[3][4] - iT[1] * a[8][2] - iT[10] * a[1][2] + iT[14] * a[4][3] + iT[23] * a[7][2] - iT[2] * a[0][1] - iT[9] * a[1][1] + iT[15] * a[3][1] + iT[22] * a[2][1] + iT[3] * a[5][0] + iT[8] * a[9][0] + iT[16] * a[7][5] - iT[21] * a[2][5] - iT[4] * a[9][5] - iT[7] * a[8][0] - iT[17] * a[3][0] - iT[20] * a[6][5] + iT[5] * a[5][2] - iT[6] * a[0][3] - iT[18] * a[4][2] - iT[19] * a[6][2] - t[1] + add) >> shift;
    dst[24 * line] = ( - iT[0] * a[2][3] + iT[11] * a[7][3] + iT[13] * a[5][2] + iT[24] * a[9][2] + iT[1] * a[4][1] + iT[10] * a[7][4] - iT[14] * a[1][4] - iT[23] * a[8][4] - iT[2] * a[4][5] - iT[9] * a[7][0] + iT[15] * a[1][0] + iT[22] * a[8][0] + iT[3] * a[4][3] + iT[8] * a[6][3] + iT[16] * a[0][2] - iT[21] * a[5][3] - iT[4] * a[2][5] - iT[7] * a[3][5] + iT[17] * a[0][5] + iT[20] * a[1][5] + iT[5] * a[2][1] + iT[6] * a[3][1] - iT[18] * a[0][1] - iT[19] * a[1][1] - t[0] + add) >> shift;
    dst[25 * line] = ( - iT[0] * a[4][5] - iT[11] * a[6][5] - iT[13] * a[0][0] + iT[24] * a[5][5] - iT[1] * a[3][1] - iT[10] * a[2][1] + iT[14] * a[1][1] + iT[23] * a[0][1] + iT[2] * a[7][2] + iT[9] * a[4][3] - iT[15] * a[8][2] - iT[22] * a[1][2] + iT[3] * a[6][2] + iT[8] * a[3][3] + iT[16] * a[9][2] + iT[21] * a[8][3] + iT[4] * a[2][4] - iT[7] * a[7][4] - iT[17] * a[5][1] - iT[20] * a[9][1] - iT[5] * a[4][0] - iT[6] * a[6][0] - iT[18] * a[0][5] + iT[19] * a[5][0] - t[0] + add) >> shift;
    dst[26 * line] = (   iT[0] * a[8][0] + iT[11] * a[1][0] - iT[13] * a[4][5] - iT[24] * a[7][0] + iT[1] * a[5][4] + iT[10] * a[9][4] + iT[14] * a[7][1] - iT[23] * a[2][1] - iT[2] * a[1][2] - iT[9] * a[0][2] + iT[15] * a[2][2] + iT[22] * a[3][2] - iT[3] * a[9][2] - iT[8] * a[8][3] - iT[16] * a[3][3] - iT[21] * a[6][2] + iT[4] * a[0][4] - iT[7] * a[5][1] + iT[17] * a[6][1] + iT[20] * a[4][1] + iT[5] * a[8][5] + iT[6] * a[1][5] - iT[18] * a[4][0] - iT[19] * a[7][5] - t[1] + add) >> shift;
    dst[28 * line] = ( - iT[0] * a[5][1] - iT[11] * a[9][1] - iT[13] * a[7][4] + iT[24] * a[2][4] + iT[1] * a[8][2] + iT[10] * a[9][3] + iT[14] * a[6][3] + iT[23] * a[3][2] - iT[2] * a[9][4] - iT[9] * a[8][1] - iT[15] * a[3][1] - iT[22] * a[6][4] + iT[3] * a[9][0] + iT[8] * a[5][0] - iT[16] * a[2][5] + iT[21] * a[7][5] - iT[4] * a[5][5] + iT[7] * a[0][0] + iT[17] * a[4][5] + iT[20] * a[6][5] + iT[5] * a[1][3] + iT[6] * a[0][3] - iT[18] * a[2][3] - iT[19] * a[3][3] + t[1] + add) >> shift;
    dst[29 * line] = (   iT[0] * a[6][4] + iT[11] * a[3][1] + iT[13] * a[9][4] + iT[24] * a[8][1] - iT[1] * a[7][3] - iT[10] * a[4][2] + iT[14] * a[8][3] + iT[23] * a[1][3] - iT[2] * a[3][5] - iT[9] * a[2][5] + iT[15] * a[1][5] + iT[22] * a[0][5] + iT[3] * a[2][4] + iT[8] * a[3][4] - iT[16] * a[0][4] - iT[21] * a[1][4] + iT[4] * a[4][3] + iT[7] * a[7][2] - iT[17] * a[1][2] - iT[20] * a[8][2] - iT[5] * a[3][0] - iT[6] * a[6][5] - iT[18] * a[8][0] - iT[19] * a[9][5] + t[0] + add) >> shift;
    dst[30 * line] = ( - iT[0] * a[7][2] + iT[11] * a[2][2] - iT[13] * a[9][3] - iT[24] * a[5][3] - iT[1] * a[6][0] - iT[10] * a[4][0] + iT[14] * a[5][0] - iT[23] * a[0][5] - iT[2] * a[4][2] - iT[9] * a[6][2] - iT[15] * a[0][3] + iT[22] * a[5][2] + iT[3] * a[2][0] - iT[8] * a[7][0] - iT[16] * a[5][5] - iT[21] * a[9][5] + iT[4] * a[7][1] - iT[7] * a[2][1] + iT[17] * a[9][4] + iT[20] * a[5][4] + iT[5] * a[6][1] + iT[6] * a[4][1] - iT[18] * a[5][1] + iT[19] * a[0][4] + t[0] + add) >> shift;
    dst[31 * line] = (   iT[0] * a[8][5] + iT[11] * a[1][5] - iT[13] * a[4][0] - iT[24] * a[7][5] - iT[1] * a[1][0] - iT[10] * a[8][0] + iT[14] * a[7][0] + iT[23] * a[4][5] - iT[2] * a[8][4] - iT[9] * a[1][4] + iT[15] * a[4][1] + iT[22] * a[7][4] + iT[3] * a[1][1] + iT[8] * a[8][1] - iT[16] * a[7][1] - iT[21] * a[4][4] + iT[4] * a[8][3] + iT[7] * a[1][3] - iT[17] * a[4][2] - iT[20] * a[7][3] - iT[5] * a[1][2] - iT[6] * a[8][2] + iT[18] * a[7][2] + iT[19] * a[4][3] + t[1] + add) >> shift;

    dst[ 2 * line] = (   iT[ 4] * b[0] + iT[ 9] * b[1] + iT[14] * b[2] + iT[19] * b[3] + iT[24] * b[4] + iT[29] * b[5] + add) >> shift;
    dst[ 7 * line] = ( - iT[14] * b[0] - iT[29] * b[1] - iT[19] * b[2] - iT[ 4] * b[3] + iT[ 9] * b[4] + iT[24] * b[5] + add) >> shift;
    dst[12 * line] = (   iT[24] * b[0] + iT[14] * b[1] - iT[ 9] * b[2] - iT[29] * b[3] - iT[ 4] * b[4] + iT[19] * b[5] + add) >> shift;
    dst[17 * line] = ( - iT[29] * b[0] + iT[ 4] * b[1] + iT[24] * b[2] - iT[ 9] * b[3] - iT[19] * b[4] + iT[14] * b[5] + add) >> shift;
    dst[22 * line] = (   iT[19] * b[0] - iT[24] * b[1] + iT[ 4] * b[2] + iT[14] * b[3] - iT[29] * b[4] + iT[ 9] * b[5] + add) >> shift;
    dst[27 * line] = ( - iT[ 9] * b[0] + iT[19] * b[1] - iT[29] * b[2] + iT[24] * b[3] - iT[14] * b[4] + iT[ 4] * b[5] + add) >> shift;

    dst[ 6 * line] = (   iT[12] * c[0] + iT[25] * c[1] + add) >> shift;
    dst[19 * line] = ( - iT[25] * c[0] + iT[12] * c[1] + add) >> shift;

    src += 32;
    dst++;
  }

  if (iSkipLine)
  {
    dst = pCoef + reducedLine;
    for (j = 0; j < cutoff; j++)
    {
      memset(dst, 0, sizeof(TCoeff)*iSkipLine);
      dst += line;
    }
  }

  if (iSkipLine2)
  {
    dst = pCoef + line * cutoff;
    memset(dst, 0, sizeof(TCoeff) * line * iSkipLine2);
  }
#else
  _fastForwardMM< 32 >( src, dst, shift, line, iSkipLine, iSkipLine2, g_trCoreDCT8P32[TRANSFORM_FORWARD][0] );
#endif
}


FwdTrans *fastFwdTrans[NUM_TRANS_TYPE][g_numTransformMatrixSizes] =
{
  { fastForwardDCT2_B2, fastForwardDCT2_B4, fastForwardDCT2_B8, fastForwardDCT2_B16, fastForwardDCT2_B32, fastForwardDCT2_B64 },
  { nullptr,            fastForwardDCT8_B4, fastForwardDCT8_B8, fastForwardDCT8_B16, fastForwardDCT8_B32, nullptr },
  { nullptr,            fastForwardDST7_B4, fastForwardDST7_B8, fastForwardDST7_B16, fastForwardDST7_B32, nullptr },
};

int main()
{
  int width = 8;
  int height = 8;
  int bitDepth = 8;
  int maxLog2TrDynamicRange = 15;

  const int      TRANSFORM_MATRIX_SHIFT = g_transformMatrixShift[TRANSFORM_FORWARD];
  const uint32_t transformWidthIndex    = log2(width ) - 1;  // nLog2WidthMinus1, since transform start from 2-point
  const uint32_t transformHeightIndex   = log2(height) - 1;  // nLog2HeightMinus1, since transform start from 2-point

  int trTypeHor = DCT8;
  int trTypeVer = DCT8;

  int  skipWidth  = ( trTypeHor != DCT2 && width  == 32 ) ? 16 : width  > JVET_C0024_ZERO_OUT_TH ? width  - JVET_C0024_ZERO_OUT_TH : 0;
  int  skipHeight = ( trTypeVer != DCT2 && height == 32 ) ? 16 : height > JVET_C0024_ZERO_OUT_TH ? height - JVET_C0024_ZERO_OUT_TH : 0;
  
  bool useLFNST = false;
  if( useLFNST )
  {
    if( (width == 4 && height > 4) || (width > 4 && height == 4) )
    {
      skipWidth  = width  - 4;
      skipHeight = height - 4;
    }
    else if( (width >= 8 && height >= 8) )
    {
      skipWidth  = width  - 8;
      skipHeight = height - 8;
    }
  }

  TCoeff block[ 64 * 64 ] = {0};
  TCoeff coeff[ 64 * 64 ] = {0};
  
  
  FILE *fp_r, *fp_w;
  fp_r = fopen("../result/origin_data/origin_data_8x8.txt", "r");
  for (int i = 0; i < height; i++)
  {
    for (int j = 0; j < width; j++)
    {
      fscanf(fp_r, "%d", &block[i * width + j]);
    }
  }
  fclose(fp_r);

  if( width > 1 && height > 1 ) // 2-D transform
  {
    const int      shift_1st              = ((log2(width )) + bitDepth + TRANSFORM_MATRIX_SHIFT) - maxLog2TrDynamicRange + COM16_C806_TRANS_PREC;// log2(iWidth) + g_bitDepth - 9
    const int      shift_2nd              =  (log2(height))            + TRANSFORM_MATRIX_SHIFT                          + COM16_C806_TRANS_PREC;// log2(iHeight) + 6
    TCoeff *tmp = (TCoeff *) alloca(width * height * sizeof(TCoeff));

    fastFwdTrans[trTypeHor][transformWidthIndex](block, tmp, shift_1st, height, 0, skipWidth);
    fastFwdTrans[trTypeVer][transformHeightIndex](tmp, coeff, shift_2nd, width, skipWidth, skipHeight);
  }
  //应该只有DST会用到
  else if( height == 1 ) //1-D horizontal transform
  {
    const int      shift              = ((log2(width )) + bitDepth + TRANSFORM_MATRIX_SHIFT) - maxLog2TrDynamicRange + COM16_C806_TRANS_PREC;
    fastFwdTrans[trTypeHor][transformWidthIndex]( block, coeff, shift, 1, 0, skipWidth );
  }
  else   // if (width == 1) //1-D vertical transform
  {
    int shift = ( ( log2(height) ) + bitDepth + TRANSFORM_MATRIX_SHIFT ) - maxLog2TrDynamicRange + COM16_C806_TRANS_PREC;
    fastFwdTrans[trTypeVer][transformHeightIndex]( block, coeff, shift, 1, 0, skipHeight );
  }
  
  // fp_w = fopen("../result/vtm_coeff/vtm_coeff_64x32.txt", "w");
  // for (int i = 0; i < width; i++)
  // {
  //   for (int j = 0; j < height; j++)
  //   {
  //     fprintf(fp_w, "%6d", coeff[i + j * width]);
  //     if (j < height - 1)
  //     {
  //       fprintf(fp_w, " ");
  //     }
  //   }
  //   fprintf(fp_w, "\n");
  // }
  // fclose(fp_w);

}