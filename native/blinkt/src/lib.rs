use std::sync::Mutex;

use blinkt::Blinkt;
use rustler::{Error as NifError, NifUnitEnum};

lazy_static::lazy_static!{
    static ref BLINKT: Mutex<Blinkt> = Mutex::new(Blinkt::new().expect("failed to initialise blinkt"));
}

#[derive(NifUnitEnum)]
enum Atoms {
    Ok,
}

fn prepare_blinkt(_env: rustler::Env<'_>, _load_info: rustler::Term<'_>) -> bool {
    BLINKT.lock().unwrap().set_all_pixels_brightness(1.0);
    true
}

#[rustler::nif]
fn set_pixel(pixel: usize, r: u8, g: u8, b: u8) -> Atoms {
    BLINKT.lock().unwrap().set_pixel(pixel, r, g, b);
    Atoms::Ok
}

#[rustler::nif]
fn set_pixel_brightness(pixel: usize, brightness: f32) -> Atoms {
    BLINKT.lock().unwrap().set_pixel_brightness(pixel, brightness);
    Atoms::Ok
}

#[rustler::nif]
fn set_brightness(brightness: f32) -> Atoms {
    BLINKT.lock().unwrap().set_all_pixels_brightness(brightness);
    Atoms::Ok
}

#[rustler::nif]
fn set_all_pixels(r: u8, g: u8, b: u8) -> Atoms {
    BLINKT.lock().unwrap().set_all_pixels(r, g, b);
    Atoms::Ok
}

#[rustler::nif]
fn show() -> rustler::NifResult<Atoms> {
    BLINKT.lock().unwrap().show().map_err(|e| NifError::Term(Box::new(e.to_string())))
        .map(|_| Atoms::Ok)
}

#[rustler::nif]
fn debug_state() -> String {
    let mut blinkt = BLINKT.lock().unwrap();
    let s = blinkt.iter_mut().map(|p| {
        let (r, g, b, br) = p.rgbb();
        format!("0x{:x}{:x}{:x}({})", r, g, b, br)
    }).collect::<String>();
    s
}

rustler::init!("Elixir.Blinkt", [
    set_pixel,
    set_pixel_brightness,
    set_all_pixels,
    set_brightness,
    show,
    debug_state,
], load = prepare_blinkt);
