// Implementation based on alexandria implementation : https://github.com/keep-starknet-strange/alexandria/blob/main/packages/math/src/wad_ray_math.cairo

use core::fmt::{Display, Formatter, Error};

trait SignedBasics {
    fn is_positive(self: @i128) -> bool;
    fn as_unsigned(self: @i128) -> u128;
    fn as_felt(self: @i128) -> felt252;
    fn as_unsigned_felt(self: @i128) -> felt252;
    fn abs(self: @i128) -> i128;
}

impl I128SignedBasics of SignedBasics {
    fn is_positive(self: @i128) -> bool {
        *self >= 0_i128
    }

    fn as_unsigned(self: @i128) -> u128 {
        if self.is_positive() {
            (*self).try_into().unwrap()
        } else {
            (-1_i128 * *self).try_into().unwrap()
        }
    }

    fn as_felt(self: @i128) -> felt252 {
        (*self).try_into().unwrap()
    }

    fn as_unsigned_felt(self: @i128) -> felt252 {
        self.as_unsigned().try_into().unwrap()
    }

    fn abs(self: @i128) -> i128 {
        if self.is_positive() {
            *self
        } else {
            *self * -1_i128
        }
    }
}

fn unsigned_to_signed(x: @u128) -> i128 {
    (*x).try_into().unwrap()
}

fn felt_to_i128(x: @felt252) -> i128 {
    (*x).try_into().unwrap()
}


impl I128Div of Div<i128> {
    fn div(lhs: i128, rhs: i128) -> i128 {
        let unsigned_div = unsigned_to_signed(@(lhs.as_unsigned() / rhs.as_unsigned()));
        let positive = lhs.is_positive() == rhs.is_positive();

        if positive {
            unsigned_div
        } else {
            unsigned_div * -1_i128
        }
    }
}

impl I128Display of Display<i128> {
    fn fmt(self: @i128, ref f: Formatter) -> Result<(), Error> {
        let sign: ByteArray = if self.is_positive() {
            ""
        } else {
            "-"
        };
        write!(f, "{}{}", sign, self.as_unsigned())
    }
}

/// Provides functions to perform calculations with Wsad and Ray units
/// @dev Provides mul and div function for wsads (decimal numbers with 18 digits of precision) and rays (decimal numbers
/// with 27 digits of precision)
/// Operations are rounded. If a value is >=.5, will be rounded up, otherwise rounded down.
/// https://github.com/aave/aave-v3-core/blob/master/contracts/protocol/libraries/math/WadRayMath.sol

pub(crate) const WSAD: i128 = 1_000_000; // 1e6 instead of  1e18
pub(crate) const HALF_WSAD: i128 = 500_000; // 0.5e6 instead of 0.5e18

pub fn wsad() -> i128 {
    return WSAD;
}

pub fn half_wsad() -> i128 {
    return HALF_WSAD;
}

// const PREVENT_OVERFLOW : bool = true;
// const OVERFLOW_REDUCTION : i128 = 10000000000000; // 1e10
pub fn safe_wsad_mul(a: i128, b: i128) -> i128 {
    wsad_mul(a, b)
// let x = a / OVERFLOW_REDUCTION;
// println!(":: {}", x);
// let y = b / OVERFLOW_REDUCTION;
// println!(":: {}", y);
// println!(":: {}", x*y);
// println!(":: {}", (x*y) * (OVERFLOW_REDUCTION*OVERFLOW_REDUCTION));
// 1

// (OVERFLOW_REDUCTION*OVERFLOW_REDUCTION) * 
// ((a/OVERFLOW_REDUCTION) * (b/OVERFLOW_REDUCTION) + HALF_WSAD) / WSAD
}


pub fn wsad_mul(a: i128, b: i128) -> i128 {
    return (a * b + HALF_WSAD) / WSAD;
}

pub fn wsad_div(a: i128, b: i128) -> i128 {
    return (a * WSAD + (b / 2)) / b;
}
