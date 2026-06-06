#                                                        Common
#                                                      BOOT MODULE

{ ... }:
{

  ####################--------------------Boot--------------------####################

  
 
 boot = {

    #--- Bootloader.
    loader = {

      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0; # Hold space to make the boot menu appear !
    };

    # This enables the splash screen
    plymouth.enable = true;

    # Standard kernel parameters for a silent boot
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # This hides the text "Starting version 25x..."
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

}
