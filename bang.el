(defcustom !bangs
  '(("w" . ("Wikipedia"
  "https://en.wikipedia.org/w/index.php?search=%s" " "))
    ("a" . ("Amazon" "https://amazon.com/s?k=%s" " ")) 
    ("gh" . ("GitHub" "https://github.com/search?q=%s" " ")) 
    ("r" . ("Reddit" "https://reddit.com/search?q=%s" " ")) 
    ("g" . ("GitHub" "https://google.com/search?q=%s" " ")) 
    ("imdb" . ("IMDB" "https://imdb.com/find?s=all&q=%s")))
  "A list of bangs")

(defun bang--annotate (b)
  (let* ((match (assoc b !bangs))
	 (name (cadr match))
	 (icon (cadddr match)))
    (format "\t%s\t%s"
	    (or icon "🔍 ")
	    name)))


(defun ! ()
  "Pick a bang from `!bangs', enter search keyword, and open in
`browse-url-browser-function'."
  (interactive)
  (let* ((completion-extra-properties
	  (list :annotation-function
		#'bang--annotate))
	 (bang (completing-read "❕" !bangs))
	 (template-url (caddr (assoc bang !bangs)))
	 (search (read-string "🔍 "))
	 (url (format template-url search)))
    (browse-url url)))

(provide 'bang)
