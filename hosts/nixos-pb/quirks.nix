# Hardware workarounds needed by this specific laptop.
#
# MACHINE-SPECIFIC: none of this is likely to be correct, or needed, elsewhere.

{ ... }:

{
  # ASUS TUF A15: the vendor backlight interface does not accept writes, so
  # brightnessctl (and therefore the i3 brightness keybinds) only works when
  # the kernel exposes the plain ACPI one.
  boot.kernelParams = [ "acpi_backlight=native" ];
}
