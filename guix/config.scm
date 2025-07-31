;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu))
(use-service-modules cups desktop networking ssh xorg)
(use-package-modules base certs gnome networking shells web linux vim librewolf package-management admin containers)

(operating-system
  (locale "pt_BR.utf8")
  (timezone "America/Sao_Paulo")
  (keyboard-layout (keyboard-layout "br"))
  (host-name "guix")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "liquuid")
                  (comment "Liquuid")
                  (group "users")
                  (home-directory "/home/liquuid")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  ;;(packages (append (list (specification->package( "nss-certs" "firefox")))
  ;;                 %base-packages))
  (packages 
	(append 
		(list
                     vim
                     librewolf
                     flatpak
                     htop
                     fastfetch
                     glibc-locales
                     distrobox
		     podman
		     podman-compose
		     ;;mpv

                     gvfs)
                    %base-packages))
                          

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service xfce-desktop-service-type)
		 (service gnome-desktop-service-type)
		 (service plasma-desktop-service-type)
                  
                 ;; To configure OpenSSH, pass an 'openssh-configuration'
                 ;; record as a second argument to 'service' below.
                 (service openssh-service-type)
                 (set-xorg-configuration
                  (xorg-configuration (keyboard-layout keyboard-layout))))

           ;; This is the default list of services we
           ;; are appending to.
           %desktop-services))
  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/vda"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "e93deb0e-81c6-417a-9360-d4df7c8cb0ea")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "0f45c012-0fb1-4370-b758-17972e5c5d44"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
