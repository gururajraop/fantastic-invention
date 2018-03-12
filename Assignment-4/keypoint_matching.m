function [matches, F1, F2, D1, D2] = keypoint_matching(image1, image2)
    [h, w, c] = size(image1);
    [F1, D1] = vl_sift(image1);
    [F2, D2] = vl_sift(image2);

    matches = vl_ubcmatch(D1, D2);    

end