[![Build Status](https://travis-ci.org/pablo1n7/ImageForm.svg?branch=master)](https://travis-ci.org/pablo1n7/ImageForm)

# ImageForm

Small Lib for basic Image processing. Programmed in Pharo for Pharo :) 

# Install

```smalltalk
Metacello new
  baseline: #ImageForm;
  repository: 'github://pablo1n7/ImageForm';
  load.
```

# Basic usage

## Open an Image.

```smalltalk
aImage := ImageForm open: '/Users/sdas/Documents/pwq7S.jpg'.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S.jpg)

## Transform to Gray Scale.
```smalltalk
aGrayImage := aImage asGrayScale
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_gray.jpg)


## Flip Image.
```smalltalk
aFlippedImage := aImage flipHorizontally.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_flipHorizontally.jpg)

```smalltalk
aFlippedImage := aImage flipVertically.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_flipVertically.jpg)


## Rotate Image.
```smalltalk
aRotatedImage := aImage rotateBy: 45.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_rotated45.jpg)

```smalltalk
aRotatedImage := aImage rotateBy: #left centerAt: 0@0. 
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_rotatedLeft.jpg)


## Scale Image.
```smalltalk
aScaledImage := aImageA scaled: 100 height: 100. 
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_scaled.jpg)


## Basic Arismetic.
```smalltalk
aImageA := ImageForm open: '/Users/sdas/Documents/pwq7S.jpg'.
aImageB := ImageForm open: '/Users/sdas/Documents/pharo.png'.

aResultSub := aImageB - aImageA.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_sub.png)

```smalltalk
aResultSum := aImageB + aImageA.
```
![](https://raw.githubusercontent.com/pablo1n7/ImageForm/master/examples/pwq7S_sum.png)


## Save Image.
```smalltalk
aScaledImage save:'/Users/pablo/Documents/Pharo/pwq7S_scaled.jpg'.
aScaledImage save:'/Users/pablo/Documents/Pharo/pwq7S_scaled.png'.
```

# TODO: 
* [ ] Operations with Kernels.

