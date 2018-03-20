function [classifiers] = classification(unselected_files, vocab, sift_type, colorspace)
    n = 2;
    classifiers1 = train_classifier(1, n, unselected_files, vocab, sift_type, colorspace);
    classifiers2 = train_classifier(2, n, unselected_files, vocab, sift_type, colorspace);
    classifiers3 = train_classifier(3, n, unselected_files, vocab, sift_type, colorspace);
    classifiers4 = train_classifier(4, n, unselected_files, vocab, sift_type, colorspace);
    

end