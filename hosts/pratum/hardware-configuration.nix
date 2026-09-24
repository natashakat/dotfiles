{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" "zfs" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "zfs" ];
  boot.supportedFilesystems.zfs = true;
  boot.initrd.supportedFilesystems.zfs = true;

  fileSystems."/" =
    { device = "/dev/mapper/luks-62394ebf-71fd-4fd4-93ee-08fba6678afd";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-62394ebf-71fd-4fd4-93ee-08fba6678afd".device = "/dev/disk/by-uuid/62394ebf-71fd-4fd4-93ee-08fba6678afd";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1FD4-8E21";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/media/cheery" =
    { device = "/dev/disk/by-uuid/895b2921-2cf8-4c54-8f47-6f8e3d45a9a3";
      fsType = "ext4";
    };

  fileSystems."/media/Meine-Dateien" =
    { device = "/dev/disk/by-uuid/76ba9a3e-305a-486f-b895-af944bc3229e";
      fsType = "ext4";
    };

  fileSystems."/media/data" =
    { device = "/dev/disk/by-uuid/e3ffa4c0-fbad-4ef1-94d3-7c2689bb42c3";
      fsType = "ext4";
    };

  fileSystems."/tank" =
    { device = "merrick-g";
      fsType = "zfs";
      # zfsutil: mount via `zfs mount` (dataset uses a native ZFS mountpoint,
      # plain mount(8) refuses it)
      options = [ "zfsutil" ];
    };

  fileSystems."/vault" =
    { device = "vault";
      fsType = "zfs";
      # Mounted manually after unlocking in KDE (keys live in the password manager)
      options = [ "zfsutil" "noauto" ];
    };

  boot.zfs.extraPools = [ "merrick-g" "vault" ];
  # Explicit true silences warning; required while forceImportAll is set
  boot.zfs.forceImportRoot = true;
  # No boot-time key prompt: keys are unlocked later in KDE from the password manager.
  # Pools still import at boot, encrypted datasets simply stay locked until then.
  boot.zfs.requestEncryptionCredentials = false;
  boot.zfs.useKeyringForCredentials = true;
  boot.zfs.forceImportAll = true;

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
