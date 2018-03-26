function [classifiers] = classification(unselected_files, vocab, sift_type, colorspace, train_set_size)
    disp('Training for class 1');    
    classifier1 = train_classifier(1, train_set_size, unselected_files, vocab, sift_type, colorspace);
    disp('Training for class 2');
    classifier2 = train_classifier(2, train_set_size, unselected_files, vocab, sift_type, colorspace);
    disp('Training for class 3');
    classifier3 = train_classifier(3, train_set_size, unselected_files, vocab, sift_type, colorspace);
    disp('Training for class 4');
    classifier4 = train_classifier(4, train_set_size, unselected_files, vocab, sift_type, colorspace);
    
    classifiers = {classifier1, classifier2, classifier3, classifier4};
end