clc;
clear all
close all
%membaca gambar input berupa gambar grayscale
%dan mengkonversi gambar ke double
r=double(imread('cameraman.tif'));

%meletakkan ukuran dari r, m untuk jumlah baris dan n untuk jumlah kolom 
[m,n] = size(r);


%menginputkan nilai r1,s1,r2,s2
r1 = input('Enter r1 :');
r2 = input('Enter r2: ');
s1 = input('Enter s1: ');
s2 = input('Enter s2: ');

%contrast stretching ada 3 kondisi dengan
% 4 region (dibawah r1, diantara r1 dan r2 dan lebih besar dari r2

%nilai alpha
a = s1/r1;
%nilai beta
b = (s2-s1)/(r2-r1);
%nilai gamma , nilai akhir itu 255 
c = (255-s2)/(255-r2);

for i=1:m
    for j = 1:n
      %region dibawah r1, pakai a
        if r(i,j) < r1
            s(i,j) = a*r(i,j);
            %region diantara r1 dan r2, pakai b
        elseif r(i,j) >= r1 && r(i,j) <= r2
            s(i,j) = b*(r(i,j)-r1)+s1;
            %region lebih besar dari r2, pakai c
        else
            s(i,j) = c*(r(i,j)-r2)+s2;
        end
    end
end

figure;imshow(uint8(r));
title('Original image');
figure;imshow(uint8(s));
title('Contrast Stretching image');


    