function [] = plotGaborEffect(sigmas, thetas, gammas)
    G1 = createGabor(sigmas(1), thetas(1), 50, 0, gammas(1));
    G2 = createGabor(sigmas(2), thetas(2), 50, 0, gammas(2));
    G3 = createGabor(sigmas(3), thetas(3), 50, 0, gammas(3));
    G4 = createGabor(sigmas(4), thetas(4), 50, 0, gammas(4));
    G5 = createGabor(sigmas(5), thetas(5), 50, 0, gammas(5));
    
    figure;
    subplot(5,2,1), imshow(G1(:,:,1));
    title(['Real: \sigma=', num2str(sigmas(1)), ', \theta=', num2str(thetas(1)), ', \gamma=', num2str(gammas(1))]);
    subplot(5,2,2), imshow(G1(:,:,2));
    title(['Imaginary: \sigma=', num2str(sigmas(1)), ', \theta=', num2str(thetas(1)), ', \gamma=', num2str(gammas(1))]);
    subplot(5,2,3), imshow(G2(:,:,1));
    title(['Real: \sigma=', num2str(sigmas(2)), ', \theta=', num2str(thetas(2)), ', \gamma=', num2str(gammas(2))]);
    subplot(5,2,4), imshow(G2(:,:,2));
    title(['Imaginary: \sigma=', num2str(sigmas(2)), ', \theta=', num2str(thetas(2)), ', \gamma=', num2str(gammas(2))]);
    subplot(5,2,5), imshow(G3(:,:,1));
    title(['Real: \sigma=', num2str(sigmas(3)), ', \theta=', num2str(thetas(3)), ', \gamma=', num2str(gammas(3))]);
    subplot(5,2,6), imshow(G3(:,:,2));
    title(['Imaginary: \sigma=', num2str(sigmas(3)), ', \theta=', num2str(thetas(3)), ', \gamma=', num2str(gammas(3))]);
    subplot(5,2,7), imshow(G4(:,:,1));
    title(['Real: \sigma=', num2str(sigmas(4)), ', \theta=', num2str(thetas(4)), ', \gamma=', num2str(gammas(4))]);
    subplot(5,2,8), imshow(G4(:,:,2));
    title(['Imaginary: \sigma=', num2str(sigmas(4)), ', \theta=', num2str(thetas(4)), ', \gamma=', num2str(gammas(4))]);
    subplot(5,2,9), imshow(G5(:,:,1));
    title(['Real: \sigma=', num2str(sigmas(5)), ', \theta=', num2str(thetas(5)), ', \gamma=', num2str(gammas(5))]);
    subplot(5,2,10), imshow(G5(:,:,2));
    title(['Imaginary: \sigma=', num2str(sigmas(5)), ', \theta=', num2str(thetas(5)), ', \gamma=', num2str(gammas(5))]);
end
