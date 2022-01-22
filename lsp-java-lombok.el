;;; lsp-java-lombok.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 amnore
;;
;; Author: amnore <https://github.com/amnore>
;; Maintainer: amnore <me@markle.one>
;; Created: January 21, 2022
;; Modified: January 21, 2022
;; Version: 0.0.1
;; Keywords: languages lsp java lombok
;; Homepage: https://github.com/czg/lsp-java-lombok
;; Package-Requires: ((emacs "24.4"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;; This package automatically downloads lombok and set vmargs for lsp-java
;;
;;; Code:

(require 'f)
(require 'lsp-java)
(require 'lsp-mode)

(defvar lsp-java-lombok--jar-path
  (if (boundp 'doom-cache-dir)
      (f-join doom-cache-dir "lombok/lombok.jar")
    (f-join user-emacs-directory ".local/cache/lombok/lombok.jar")))

(defun lsp-java-lombok-download ()
  "Download the latest lombok jar."
  (make-directory (f-dirname lsp-java-lombok--jar-path) t)
  (when (f-exists-p lsp-java-lombok--jar-path)
    (f-delete lsp-java-lombok--jar-path))
  (lsp--info "Downloading lombok...")
  (url-copy-file "https://projectlombok.org/downloads/lombok.jar"
                 lsp-java-lombok--jar-path))

;;;###autoload
(defun lsp-java-lombok-init ()
  "Download lombok and set vmargs."
  (unless (f-exists-p lsp-java-lombok--jar-path)
    (lsp-java-lombok-download))
  (add-to-list 'lsp-java-vmargs
               (concat "-javaagent:" lsp-java-lombok--jar-path)))

(provide 'lsp-java-lombok)
;;; lsp-java-lombok.el ends here
