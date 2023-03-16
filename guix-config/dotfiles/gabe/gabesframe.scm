;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(define-module (gabe gabesframe)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (guix gexp)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services desktop)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages glib)
  #:use-module (ice-9 regex)
  #:use-module (ice-9 pretty-print)
  #:use-module (ice-9 textual-ports)
  #:use-module (gabe home-services pipewire)
  #:use-module (gabe home-services desktop)
  #:use-module (nongnu packages linux))

(define (read-manifest manifest-path)
  (with-input-from-file manifest-path
    (lambda ()
      (read))))

(define (gather-manifest-packages manifests)
  (if (pair? manifests)
      (begin
	(let ((manifest (read-manifest (string-append
					"/home/gabe/.config/guix/manifests/"
					(symbol->string (car manifests))
					".scm"))))
	  (append (map specification->package+output
		       (cadadr manifest))
		  (gather-manifest-packages (cdr manifests)))))
      '()))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  ;; Package manifests kept under $~/.config/guix/manifests
 (packages (cons*
	   (list glib "bin") ;; For gsettings?
	   (gather-manifest-packages '(emacs))))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list
     (service home-pipewire-service-type)
     (service home-dbus-service-type)
     (service home-desktop-service-type)
     (simple-service 'profile-env-vars-service
		     home-environment-variables-service-type
		     '(
		       ("VISUAL" . "emacsclient")
		       ("EDITOR" . "emacsclient")

		       ("PROMPT_COMMAND" . "mommy \\$\\(exit $?\\);")
		       ("SHELL_MOMMYS_LITTLE" . "boy")
		       
		       ;; Flatpak apps
		       ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share")

		       ;; Guix user
		       ("GUIX_PROFILE" . "/home/gabe/.guix-profile")

		       ;; Wayland variables
		       ("MOZ_ENABLE_WAYLAND" . "1")
		       ("XDG_CURRENT_DESKTOP" . "sway")
		       ("XDG_SESSION_TYPE" . "wayland")
		       ("RTC_USE_PIPEWIRE" . "true")
		       ("CLUTTER_BACKEND" . "wayland")
		       ("SDL_VIDEODRIVER" . "wayland")
		       ("ELM_ENGINE" . "wayland_egl")
		       ("ECORE_EVAS_ENGINE" . "wayland-egl")))
     (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '(("grep" . "grep --color=auto") 
			      ("ll" . "exa -l --icons")
                              ("ls" . "exa --icons")
			      ("nf" . "neofetch")
			      ("update-home" . "guix home -L ~/dotfiles reconfigure ~/dotfiles/gabe/gabesframe.scm")))
                   (bashrc (list 
			     (plain-file "bash-profile-extras"
					 (string-append 
					   "source ~/dotfiles/gabe/shell-mommy.sh\n"))
			     (local-file
                                  "/home/gabe/dotfiles/gabe/.bashrc"
                                  "bashrc")))
                   (bash-profile
		    `(,(plain-file "bash-profile-extras"
				   (string-append
				    "if [ -f /run/current-system/profile/etc/profile.d/nix.sh ]; then\n"
				    " . /run/current-systems/profile/etc/profile.d/nix.sh\n"
				    "fi\n")))))))))

