;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (nongnu packages linux)
	     (gnu system)
	     (srfi srfi-1))

(use-service-modules guix nix dbus audio cups desktop networking ssh xorg)

(operating-system
 (kernel linux)
 (firmware (list linux-firmware))
  (locale "en_CA.utf8")
  (timezone "America/Vancouver")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "framework")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "gabe")
                  (comment "Gabriel Ravacci")
                  (group "users")
                  (home-directory "/home/gabe")
                  (supplementary-groups '("wheel" "netdev" "audio" "video" "lp")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (map specification->package 
			  '("git"
			    "vim"
			    "ntfs-3g"
			    "stow"
			    "bluez"
			    "brightnessctl"
			    "bluez-alsa"
			    "blueman"
			    "tlp"
			    "xf86-input-libinput"
			    "gvfs"
			    "nss-certs"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services (append
	     (modify-services %desktop-services
			      (delete gdm-service-type))
	     (cons*
	      (simple-service 'blueman dbus-root-service-type (list blueman)))  ;; Blueman as bluetooth manager
	     (list
	      (service bluetooth-service-type
		       (bluetooth-configuration
			(auto-enable? #t)))
	      (service nix-service-type))))

  
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "75a2db76-cbdc-42b1-8ef5-1eebe56aa19a"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "C20D-1416"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
