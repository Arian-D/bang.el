(defcustom !bangs
  '(("w" . ("Wikipedia" . "https://en.wikipedia.org/w/index.php?search=%s"))
    ("a" . ("Amazon" . "https://www.amazon.com/s?k=%s")) 
    ("imdb" . ("IMDB" . "https://www.imdb.com/find?s=all&q=%s")))
  "A list of bangs")

(defun bang--annotate (b)
  (format "\t%s"
	  (cadr
	   (assoc b !bangs))))

(defun ! ()
  "Pick a bang from `!bangs', enter search keyword, and open in
`browse-url-browser-function'."
  (interactive)
  (let* ((completion-extra-properties
	  (list :annotation-function
		#'bang--annotate))
	 (bang (completing-read "❕" !bangs))
	 (template-url (cddr (assoc bang !bangs)))
	 (search (read-string "> "))
	 (url (format template-url search)))
    (browse-url url)))

(provide 'bang)
