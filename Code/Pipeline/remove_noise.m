function C = remove_noise(mask)
C= zeros(size(mask));
CC = bwconncomp(mask);
numPixels = cellfun(@numel,CC.PixelIdxList);
[~,idx] = max(numPixels);
C(CC.PixelIdxList{idx}) = 255;

end