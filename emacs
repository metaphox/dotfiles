(tool-bar-mode -1)
(require 'package)
  (push '("marmalade" . "http://marmalade-repo.org/packages/")
        package-archives)
  (push '("melpa" . "http://melpa.milkbox.net/packages/")
        package-archives)

