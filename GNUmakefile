TEST=TestFann.hs
TRAIN=TrainFann.hs
COMPILE=CompileTraining.hs

all: $(TEST)
	runhaskell $(TEST)

full: $(TEST) $(TRAIN) $(COMPILE)
	runhaskell $(COMPILE)
	runhaskell $(TRAIN)
	runhaskell $(TEST)
