# Local LLM inference via ollama. Not imported by default.
#
# NOTE ON THE PACKAGE: this was `pkgs.ollama-cuda`, but that only pays off
# with the proprietary NVIDIA driver loaded. On nixos-pb the hardware.nvidia
# block is not enabled, nouveau binds the RTX 3070 Ti, there is no /dev/nvidia*,
# and every ollama start logged exactly one backend:
#
#     msg="inference compute" id=cpu library=cpu ... total="14.9 GiB"
#
# So the CUDA build was a large download doing nothing. If you ever enable the
# proprietary driver, switch this back to pkgs.ollama-cuda.

{ pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama;
  };

  environment.systemPackages = [ pkgs.ollama ];
}
