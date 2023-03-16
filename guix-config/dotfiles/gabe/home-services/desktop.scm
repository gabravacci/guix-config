(define-module (gabe home-services desktop)
  #:use-module (gnu packages)
  #:use-module (gnu packages linux)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (guix gexp)
  ;;----------------------------------------
  #:export (home-desktop-service-type))

(define (home-desktop-profile-service config)
  (map specification->package+output
       '(;; Sway setup
	 "sway"
	 "swayidle"
	 "swaybg"
	 "swaylock"
	 "waybar"
	 "dunst"
	 "dbus"
	 "feh"
	 "libnotify"
         "gtk+:bin"
 	 "flatpak"
	 "libinput"
	 "foot"
	 "wofi"
	 "flameshot"
	 
	 "xdg-desktop-portal"
	 "xdg-desktop-portal-gtk"
	 "xdg-desktop-portal-wlr"
	 "xdg-utils"
	 "xdg-dbus-proxy"

	 "matcha-theme"
	 "papirus-icon-theme"
	 "breeze-icons"

	 ;; Fonts
	 "font-google-noto"
	 "font-iosevka"
	 "font-iosevka-aile"
	 "font-terminus"
	 "font-jetbrains-mono"
	 "font-liberation"
	 "font-awesome"
	 "gucharmap"

	 ;; Audio
	 "alsa-utils"
	 "pavucontrol"
	 "pamixer"

	 ;; Browsers
	 ;;"firefox-wayland"
	 "qutebrowser"
	 "qtwayland"

	 ;; Utils
	 "mcron"
	 "zip"
	 "unzip"
	 "unrar"
	 "openssh"
	 "curl"
	 "wget"

	 ;; CLI
	 "neofetch"
	 "network-manager-applet"
	 "exa"
	 "htop"
	 "pcmanfm"

	 ;; PDF reading
	 "zathura"
	 "zathura-pdf-mupdf"

	 ;; Media
	 "mpv"
	 "youtube-dl"
	 "inkscape")))

(define home-desktop-service-type
  (service-type (name 'home-desktop)
                (description "My desktop environment service.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-desktop-profile-service)))
                (default-value #f)))
