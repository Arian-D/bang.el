(require 'all-the-icons)


(defcustom !bangs
  '(("w" . ("Wikipedia"
  "https://en.wikipedia.org/w/index.php?search=%s" " "))
    ("melpa" . ("MELPA" "https://melpa.org/#/?q=%s"))
    ("hn" . ("Hacker News" "https://hn.algolia.com/?q=%s" " "))
    ("a" . ("Amazon" "https://amazon.com/s?k=%s" " ")) 
    ("gh" . ("GitHub" "https://github.com/search?q=%s" " ")) 
    ("r" . ("Reddit" "https://reddit.com/search?q=%s" " ")) 
    ("tw" . ("Twitter" "https://twitter.com/search?q=%s" " "))
    ("g" . ("Google" "https://google.com/search?q=%s" " ")) 
    ("imdb" . ("IMDB" "https://imdb.com/find?s=all&q=%s"))
    ("ddg" . ("DuckDuckGo" "https://duckduckgo.com/?q=%s")))
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
         (match (assoc bang !bangs))
         (template-url (caddr match))
         (search (read-string (or (cadddr match) "🔍 ")))
         (url (format template-url search)))
    (browse-url url)))

(provide 'bang)
