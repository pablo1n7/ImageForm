"
An ImageFormGrayScaleTest is a test class for testing the behavior of ImageFormGrayScale
"
Class {
	#name : #ImageFormGrayScaleTest,
	#superclass : #ImageFormTest,
	#category : #'Image-Form-test'
}

{ #category : #test }
ImageFormGrayScaleTest >> imageFormGrayScaleClass [
	^ ImageFormGrayScale
]

{ #category : #test }
ImageFormGrayScaleTest >> testApplyKernelWith [
	"Apply convolution to a image using a Identity Kernel. The image should not be changed"

	| anImage anImageKernel |
	anImage := self imageFormGrayScaleClass
		newFrom: (self formClass extent: 50 @ 50 depth: 32).
	anImage fillColor: Color black.
	anImage colorAt: 25@25 put: Color white. 
	anImageKernel := anImage applyKernel: ImageFormGrayScale squareKernel3x3 flattened with: #min.
	self 
		assert: (anImageKernel colorAt: 25@25)
		equals: Color black.
	anImageKernel := anImage applyKernel: ImageFormGrayScale squareKernel3x3 flattened with: #max.
	self 
		assert: (anImageKernel colorAt: 25@25)
		equals: Color white.
]

{ #category : #test }
ImageFormGrayScaleTest >> testAsBinaryImage [
	"Covert an image in Binary (Black and White). The color in position 0,0 should be changed"

	| aForm aGrayImage aImage |
	aForm := self formClass extent: 10 @ 10 depth: 32.
	aImage := self imageFormGrayScaleClass newFrom: aForm.
	aImage fillColor: (Color gray).
	aGrayImage := aImage asBinaryImage: 0.3.
	self
		assert: (aGrayImage colorAt: 0 @ 0)
		equals: Color white
]

{ #category : #test }
ImageFormGrayScaleTest >> testAsGrayScale [
	
	| aForm  aGrayImage |
	aForm := self formClass extent: 10 @ 10 depth: 32.
	aGrayImage := self imageFormGrayScaleClass newFrom: aForm.
	aGrayImage fillColor: (Color gray).
	self should:[ aGrayImage asGrayScale ]  raise: Error  
]

{ #category : #test }
ImageFormGrayScaleTest >> testAsGrayScaleWithAlpha [ 
	
	| aForm  aGrayImage |
	aForm := self formClass extent: 10 @ 10 depth: 32.
	aGrayImage := self imageFormGrayScaleClass newFrom: aForm.
	aGrayImage fillColor: (Color gray).
	self should:[ aGrayImage asGrayScaleWithAlpha  ]  raise: Error
]

{ #category : #test }
ImageFormGrayScaleTest >> testClosing [

	| aForm  aGrayImage aClosing |
	aForm := self formClass extent: 12 @ 12 depth: 32.
	aGrayImage := self imageFormGrayScaleClass newFrom: aForm.
	aGrayImage fillColor: (Color black).
	aGrayImage colorAt: 6@6 put: Color white.
	aClosing:= aGrayImage closing: ImageFormGrayScale squareKernel3x3.
	self 
		assert: (aClosing colorAt: 6@6)
		equals: Color white
]

{ #category : #test }
ImageFormGrayScaleTest >> testDilation [

	| aForm  aGrayImage aDilation |
	aForm := self formClass extent: 12 @ 12 depth: 32.
	aGrayImage := self imageFormGrayScaleClass newFrom: aForm.
	aGrayImage fillColor: (Color white).
	aGrayImage colorAt: 6@6 put: Color black.
	aDilation := aGrayImage dilation: ImageFormGrayScale squareKernel3x3.
	self 
		assert: (aDilation colorAt: 6@6)
		equals: Color white
]

{ #category : #test }
ImageFormGrayScaleTest >> testErosion [

	| aForm  aGrayImage aErosion |
	aForm := self formClass extent: 12 @ 12 depth: 32.
	aGrayImage := self imageFormGrayScaleClass newFrom: aForm.
	aGrayImage fillColor: (Color black).
	aGrayImage colorAt: 6@6 put: Color white.
	aErosion := aGrayImage dilation: ImageFormGrayScale squareKernel3x3.
	self 
		assert: (aErosion colorAt: 5@5)
		equals: Color white
]

{ #category : #test }
ImageFormGrayScaleTest >> testGetNeighborhoodKernelWith [

	| aForm  aGrayImage aColor |
	aForm := self formClass extent: 12 @ 12 depth: 32.
	aGrayImage := self imageFormGrayScaleClass newFrom: aForm.
	aGrayImage fillColor: (Color white).
	aGrayImage colorAt: 6@6 put: Color black.
	
	aColor := aGrayImage getNeighborhood: 6@6 kernel: {0. 0. 0. 1. 1. 1. 0. 0. 0.}  with: #min.
	self 
		assert: aColor
		equals: Color black.
		
	aColor := aGrayImage getNeighborhood: 6@6 kernel: {0. 0. 0. 1. 1. 1. 0. 0. 0.}  with: #max.
	self 
		assert: aColor
		equals: Color white.
]

{ #category : #test }
ImageFormGrayScaleTest >> testOpen [
	"Save an image in the imageDirectory and Open it. The image should be the same. Before exit remove the image."

	| aImage aPath aImageSave |
	aPath := FileLocator imageDirectory fullPath pathString
		, '/test_image.png'.
	aImage := self imageFormClass imageTest.
	aImage save: aPath.
	aImageSave := self imageFormGrayScaleClass open: aPath.
	self 
		assert: (aImageSave colorAt: 5@5) 
		equals: (Color r: 0.07 g: 0.07  b: 0.07) .
]

{ #category : #test }
ImageFormGrayScaleTest >> testOpening [

	| aForm  aGrayImage aOpening |
	aForm := self formClass extent: 12 @ 12 depth: 32.
	aGrayImage := self imageFormGrayScaleClass newFrom: aForm.
	aGrayImage fillColor: (Color black).
	aGrayImage colorAt: 6@6 put: Color white.
	aOpening := aGrayImage opening: ImageFormGrayScale squareKernel3x3.
	self 
		assert: (aOpening colorAt: 5@5)
		equals: Color black
]
