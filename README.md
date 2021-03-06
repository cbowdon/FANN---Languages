# Classifying languages with HFANN (Haskell FANN bindings)

This is an implementation of the language classifier described in the FANN ["getting started" article.] [1] It uses relative letter frequency to distinguish languages.

I compiled training data from 4 languages, English, French, Norwegian and Swedish, trained the FANN to the same accuracy as in the article and tested it against an unfamiliar sentence in each language. It performed reasonably well in my unscientific testing; it identifies most of the 4 languages accurately, and this holds even if I retrain. English is currently mis-classified as French quite often. Better results could almost certainly be achieved with a greater amount of training data (and longer test sentences).

There's also a few dials in the FANN itself that I haven't played with yet: size of hidden layer, activation function, training algorithm. A neural network is probably overkill for this task, logistic regression could do the same.

My hidden agenda here was to get more familiar with Haskell. Following the advice in Real World Haskell, I have eschewed do notation in favour of explicitly calling the monad functions, for now. HLint has also been quite helpful, although I'd personally prefer something stricter and dogmatic like JSLint - command me how to use whitespace so I can stop worrying about it and focus on the problem at hand.

License (code only, not data): [GPLv3] [2]

[1]: http://fann.sourceforge.net/fann_en.pdf
[2]: http://www.gnu.org/licenses/gpl-3.0-standalone.html
