# Cofiguarcion de nvida Para Niri
{config, pkgs, ...}:{
hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # ← AGREGA ESTOS PAQUETES:
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  services.xserver.videoDrivers = ["nvidia"];

    boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"

  ];
  environment.sessionVariables = {

  # NVIDIA específico
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";

    # Para reducir problemas con video
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";


  };
  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-niri-vram.json".text = ''
    {
      "rules": [
        {
          "pattern": {
            "feature": "procname",
            "matches": "niri"
          },
          "profile": "Limit free buffer pool on Wayland compositors"
        }
      ],
      "profiles": [
        {
          "name": "Limit free buffer pool on Wayland compositors",
          "settings": [
            {
              "key": "GLVidHeapReuseRatio",
              "value": 0
            }
          ]
        }
      ]
    }
  '';

}
