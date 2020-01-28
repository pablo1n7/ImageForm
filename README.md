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

## Transform to Gray Scale.
```smalltalk
aGrayImage := aImage asGrayScale
```
![](https://raw.githubusercontent.com/pablo1n7/Smallbook/master/StaticFiles/slide_1.jpg)


## Flip Image.
```smalltalk
aFlippedImage := aImage flipHorizontally.
```
![](https://raw.githubusercontent.com/pablo1n7/Smallbook/master/StaticFiles/slide_2.jpg)

```smalltalk
aFlippedImage := aImage flipVertically.
```
![](https://raw.githubusercontent.com/pablo1n7/Smallbook/master/StaticFiles/slide_2.jpg)


## Rotate Image.
```smalltalk
aRotatedImage := aImage rotateBy: 45.
```
![](https://raw.githubusercontent.com/pablo1n7/Smallbook/master/StaticFiles/slide_3.jpg)

```smalltalk
aRotatedImage := aImage rotateBy: #left centerAt: 0@0. 
```
![](https://raw.githubusercontent.com/pablo1n7/Smallbook/master/StaticFiles/slide_3.jpg)


## Scale Image.
```smalltalk
aScaledImage := aImageA scaled: 100 height: 100. 
```
## Basic Arismetic.
```smalltalk
aImageA := ImageForm open: '/Users/sdas/Documents/pwq7S.jpg'.
aImageB := ImageForm open: '/Users/sdas/Documents/pharo.png'.

aResultSub := aImageB - aImageA.
```
![](https://raw.githubusercontent.com/pablo1n7/Smallbook/master/StaticFiles/slide_3.jpg)

```smalltalk
aResultSum := aImageB + aImageA.
```
![](https://raw.githubusercontent.com/pablo1n7/Smallbook/master/StaticFiles/slide_3.jpg)


## Save Image.
```smalltalk
aScaledImage save:'/Users/pablo/Documents/Pharo/pwq7S_scaled.jpg'.
aScaledImage save:'/Users/pablo/Documents/Pharo/pwq7S_scaled.png'.
```

# TODO: 
* [ ] Operations with Kernels.

