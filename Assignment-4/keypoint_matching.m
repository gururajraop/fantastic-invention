function [matches, F1, F2, D1, D2] = keypoint_matching(image1, image2)
    [h, w, c] = size(image1);
    [F1, D1] = vl_sift(image1);
    [F2, D2] = vl_sift(image2);

    matches = vl_ubcmatch(D1, D2);    
%     i = imshowpair(image1, image2, 'montage');
%     alpha(i, .5);
%     hold on;
%     
% 
%     perm = randperm(size(matches,2)) ;
%     sel = perm(1:50);

%     
%     for s = sel
%         F1_index = matches(1, s);
%         F2_index = matches(2, s);
%         
%         data1 = F1(:, F1_index);
%         h1 = vl_plotframe(data1);
%         set(h1,'color','r','linewidth',2);
%         
%         data2 = F2(:, F2_index);
%         data2(1) = data2(1) + w;
%         
%         h2 = vl_plotframe(data2);        
%         set(h2,'color','r','linewidth',2);
%         
%         plot([data1(1) data2(1)], [data1(2) data2(2)], 'b-', 'LineWidth', 2);
%     end
end