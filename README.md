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
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S.jpg">
</p>

## Transform to Gray Scale.
```smalltalk
aGrayImage := anImage asGrayScale
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_gray.jpg">
</p>

## Flip Image.
```smalltalk
aFlippedImage := anImage flipHorizontally.
```

<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_flipHorizontally.jpg">
</p>

```smalltalk
aFlippedImage := anImage flipVertically.
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_flipVertically.jpg">
</p>

## Rotate Image.
```smalltalk
aRotatedImage := anImage rotateBy: 45.
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_rotated45.png">
</p>

```smalltalk
aRotatedImage := anImage rotateBy: #left centerAt: 0@0. 
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_rotatedLeft.jpg">
</p>

## Scale Image.
```smalltalk
aScaledImage := anImageA scaled: 100 height: 100. 
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_scaled.jpg">
</p>

## Crop Image.
```smalltalk
aCropImage := anImageForm crop: 0@0 h: 300  w: 500.
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_crop.jpg">
</p>

## Lighter Image.
```smalltalk
aLighterImage := anImageForm lighter:0.25.
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_lighter.jpg">
</p>

## Darker Image.
```smalltalk
aDarkerImage := anImageForm darker:0.25.
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_darker.jpg">
</p>

## Basic Arithmetics.
```smalltalk
anImageA := ImageForm open: '/Users/sdas/Documents/pwq7S.jpg'.
anImageB := ImageForm open: '/Users/sdas/Documents/pharo.png'.

aResultSub := anImageB - anImageA.
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_sub.png">
</p>

```smalltalk
aResultSum := anImageB + anImageA.
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_sum.png">
</p>

## Operations with kernels (3x3 and 5x5)

```smalltalk
anImage := ImageForm open: '/Users/pablo/Documents/pharo/pharo.png'.
aGaussianKernel := {{ 1/256. 4/256. 6/256. 4/256. 1/256. }. 
		    { 4/256. 16/256. 24/256. 16/256. 4/256.}. 
		    { 6/256. 24/256. 36/256. 24/256. 6/256. }. 
		    { 4/256. 16/256. 24/256. 16/256. 4/256. }. 
		    { 1/256. 4/256. 6/256. 4/256. 1/256. }.}.
aResult := anImage applyKernel:  aGaussianKernel flattened .
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_gaussian.png">
</p>


```smalltalk
anImage := ImageForm open: '/Users/pablo/Documents/pharo/pharo.png'.
aGrayImage := anImage asGrayScale.
aSobelKernel := {{-0.1. -0.1. -0.1}. 
		 { -0.1. 0.80. -0.1}. 
		 {-0.1. -0.1. -0.1}}.
aResult := aGrayImage applyKernel:  aSobelKernel flattened .
```
<p align="center">
  <img height=180 src="https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pharo_sobel.png">
</p>



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
