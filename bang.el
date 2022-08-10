(defcustom !bangs
  '(("w" . ("wikipedia" . "https://en.wikipedia.org/w/index.php?search=%s"))
    ("imdb" . ("IMDB" . "https://www.imdb.com/find?s=all&q=%s")))
  "A list of bangs")

(defun bang--annotate (b)
  (cadr
   (assoc b !bangs)))

(defun ! ()
  "DuckDuckGo-style bangs"
  (interactive)
  (let* ((completion-extra-properties
	 (list :annotation-function
	       #'bang--annotate))
	 (bang (completing-read "❕" !bangs))
	 (template-url (cddr (assoc bang !bangs)))
	 (search (read-string "> "))
	 (url (format template-url search)))
    (browse-url url)))
