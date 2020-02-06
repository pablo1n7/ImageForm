[![Build Status](https://travis-ci.org/pablo1n7/ImageForm.svg?branch=master)](https://travis-ci.org/pablo1n7/ImageForm)

# ImageForm

Small Lib for basic Image processing. Programmed in Pharo for Pharo :) 

# Install

```smalltalk
Metacello new
  baseline: #ImageForm;
  repository: 'github://pablo1n7/ImageForm/src';
  load.
```

# Basic usage

## Open an Image.

```smalltalk
anImage := ImageForm open: '/Users/sdas/Documents/pwq7S.jpg'.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S.jpg)

## Transform to Gray Scale.
```smalltalk
aGrayImage := anImage asGrayScale
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_gray.jpg)


## Flip Image.
```smalltalk
aFlippedImage := anImage flipHorizontally.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_flipHorizontally.jpg)

```smalltalk
aFlippedImage := anImage flipVertically.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_flipVertically.jpg)


## Rotate Image.
```smalltalk
aRotatedImage := anImage rotateBy: 45.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_rotated45.jpg)

```smalltalk
aRotatedImage := anImage rotateBy: #left centerAt: 0@0. 
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_rotatedLeft.jpg)


## Scale Image.
```smalltalk
aScaledImage := anImageA scaled: 100 height: 100. 
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_scaled.jpg)


## Crop Image.
```smalltalk
aCropImage := anImageForm crop: 0@0 h: 300  w: 500.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_crop.jpg)

## Lighter Image.
```smalltalk
aCropImage := anImageForm lighter:0.25.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_lighter.jpg)

## Basic Arithmetic.
```smalltalk
anImageA := ImageForm open: '/Users/sdas/Documents/pwq7S.jpg'.
anImageB := ImageForm open: '/Users/sdas/Documents/pharo.png'.

aResultSub := anImageB - anImageA.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_sub.png)

```smalltalk
aResultSum := anImageB + anImageA.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_sum.png)

## Operations with kernels (3x3 and 5x5)

```smalltalk
anImage := ImageForm open: '/Users/pablo/Documents/pharo/pharo.png'.
aGrayImage := anImage asGrayScale.
aSobelKernel := {{-0.1. -0.1. -0.1}. { -0.1. 0.80. -0.1}. {-0.1. -0.1. -0.1}}.
aResult := aGrayImage applyKernel:  aSobelKernel flattened .
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pharo_sobel.png)


```smalltalk
anImage := ImageForm open: '/Users/pablo/Documents/pharo/pharo.png'.
aGaussianKernel := {{ 1/256. 4/256. 6/256. 4/256. 1/256. }. { 4/256. 16/256. 24/256. 16/256. 4/256. }. { 6/256. 24/256. 36/256. 24/256. 6/256. }. { 4/256. 16/256. 24/256. 16/256. 4/256. }. { 1/256. 4/256. 6/256. 4/256. 1/256. }.}.
aResult := anImage applyKernel:  aGaussianKernel flattened .
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_gaussian.png)

```smalltalk
anImage := ImageForm open: '/Users/pablo/Documents/pharo/pharo.png'.
anImagegray := anImage asGrayScale.
anSobelKernel := {{-0.1. -0.1. -0.1}. { -0.1. 0.80. -0.1}. {-0.1. -0.1. -0.1}}.
anImageResult := anImagegray applyKernel:  anSobelKernel flattened .
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pharo_sobel.png)




## Show Image.
```smalltalk
anImage show: 'Eileen Collins'.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/show.jpg)

## Save Image.
```smalltalk
aScaledImage save:'/Users/pablo/Documents/Pharo/pwq7S_scaled.jpg'.
aScaledImage save:'/Users/pablo/Documents/Pharo/pwq7S_scaled.png'.
```


# TODO: 
* [ ] Operations with Kernels.
* [ ] Create Histogram for images.

