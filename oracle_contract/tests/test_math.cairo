use oracle_consensus::utils::{
    show_tuple_array, show_array, wad_to_string,
    show_wad_array
    };
use oracle_consensus::sort::IndexedMergeSort;
use oracle_consensus::math::{sqrt};
use oracle_consensus::signed_wad_ray::{
    I128Div, I128Display, I128SignedBasics, unsigned_to_signed,
    ray_div, ray_mul, wad_div, wad_mul, ray_to_wad, wad_to_ray, ray, wad, half_ray, half_wad
};

// ==============================================================================


#[test]
fn test_indexed_merge_sort() {
    let input = array![20_i128, 30, 29, 1, 300, 100];

    let prediction = IndexedMergeSort::sort(@input);
    let expected = array![
        (3_usize, 1_i128), 
        (0, 20), 
        (2, 29), 
        (1, 30), 
        (5, 100), 
        (4, 300)
    ];

    // show_tuple_array(res);
    assert!(prediction == expected, "indexed merge sort doesn't work");
}

#[test]
fn test_sqrt() {
    {
        // it works

        // let values = array![
        //     sqrt(0_i128), 
        //     sqrt(9_i128 * wad()), 
        //     sqrt(16_i128 * wad()), 
        //     sqrt(305_i128 * wad())
        // ];

        // show_wad_array(values);
        // wanted : [0, 3, 4, 17.4928]
    }

    assert!(
    (sqrt(9 * wad())) == (3 * wad()),
    "sqrt error"
    );
}



// #[test]
// fn test_i128() {
//     let x : i128 = -90;
//     let y : i128 = -9;
//     let z : i128 = x / y;
    
//     assert!(z == 10_i128, "error");
//     // println!("{}", z);
// }

// #[test]
// fn test_wad() {
//     let x : i128 = -90 * wad();
//     let y : i128 = -9 * wad();
//     let z : i128 = wad_mul(wad_div(x, y) + wad(), 2*wad());

//     assert!(z == 22000000000000000000_i128, "error");
//     // println!("{}", z);
// }