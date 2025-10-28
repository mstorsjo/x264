/****************************************************************************
 * dct-a-common.S: aarch64 transform and zigzag
 *****************************************************************************
 * Copyright (C) 2009-2025 x264 project
 *
 * Authors: David Conrad <lessen42@gmail.com>
 *          Janne Grunau <janne-x264@jannau.net>
 *          David Chen   <david.chen@myais.com.cn>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111, USA.
 *
 * This program is also available under a commercial proprietary license.
 * For more information, contact us at licensing@x264.com.
 *****************************************************************************/

// This file contains the NEON macros that are intended to be used by
// the SVE/SVE2 functions as well

const scan4x4_frame, align=16
.byte    0,1,   8,9,   2,3,   4,5
.byte   10,11, 16,17, 24,25, 18,19
.byte   12,13,  6,7,  14,15, 20,21
.byte   26,27, 28,29, 22,23, 30,31
endconst

const scan4x4_field, align=16
.byte    0,1,   2,3,   8,9,   4,5
.byte    6,7,  10,11, 12,13, 14,15
endconst

const sub4x4_frame, align=16
.byte    0,  1,  4,  8
.byte    5,  2,  3,  6
.byte    9, 12, 13, 10
.byte    7, 11, 14, 15
endconst

const sub4x4_field, align=16
.byte    0,  4,  1,  8
.byte   12,  5,  9, 13
.byte    2,  6, 10, 14
.byte    3,  7, 11, 15
endconst

.macro DCT_1D v0 v1 v2 v3 v4 v5 v6 v7
    SUMSUB_AB   \v1, \v6, \v5, \v6
    SUMSUB_AB   \v3, \v7, \v4, \v7
    add         \v0, \v3, \v1
    add         \v4, \v7, \v7
    add         \v5, \v6, \v6
    sub         \v2, \v3, \v1
    add         \v1, \v4, \v6
    sub         \v3, \v7, \v5
.endm
