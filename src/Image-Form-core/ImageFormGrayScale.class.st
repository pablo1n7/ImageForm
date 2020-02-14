"
Represent a Gray Scale image in Pharo. 

This lib allows basic manipulate and show images.


Example for open a image:

anImageA := ImageFormGrayScale open: '/Users/pablo/Documents/Pharo/pwq7S.jpg'.

Example for sum two images:

anImageB := ImageForm open: '/Users/pablo/Documents/Pharo/pharo.png'.
aResultSum := anImageB - anImageA.

Example to show a image:
anImageA show: 'Image A'.

Example to scaled:

aSacaledImage := anImageA scaledFactor:500 height:100.

Example to flip:

aFlippedImage := anImageA flipHorizontally.

aFlippedImage := anImageA flipVertically.


"
Class {
	#name : #ImageFormGrayScale,
	#superclass : #ImageForm,
	#category : #'Image-Form-core'
}

{ #category : #constants }
ImageFormGrayScale class >> discKernel3x3 [
	"return a Disc Kernel"
	^ #(#(1 0 1) #(1 1 1) #(1 0 1))
]

{ #category : #constants }
ImageFormGrayScale class >> horizontalKernel3x3 [
	"return a Horizontal Kernel"
	^ #(#(1 0 1) #(1 0 1) #(1 0 1))
]

{ #category : #'instance creation' }
ImageFormGrayScale class >> open: aFileName [
	"Open an Image in Gray Scale."
	^ (superclass open: aFileName) asGrayScale
]

{ #category : #constants }
ImageFormGrayScale class >> squareKernel3x3 [
	"return a Square Kernel"
	^ #(#(1 1 1) #(1 1 1) #(1 1 1))
]

{ #category : #constants }
ImageFormGrayScale class >> verticalKernel3x3 [
	"return a Vertical Kernel"
	^ #(#(1 1 1) #(0 0 0) #(1 1 1))
]

{ #category : #converting }
ImageFormGrayScale >> applyKernel: aKernel with: anOperation [
	"Apply convolution to image. AKernel is a flattened list. Return a new ImageFormGrayScale.
	
	anKernel := {{-0.1. -0.1. -0.1}. { -0.1. 0.80. -0.1}. {-0.1. -0.1. -0.1}}.
	anImageResult := anImage applyKernel:  anKernel flattened .
	"
	
	|anImage aDim|
	aDim := aKernel size sqrt.
	(aDim = 3 or: aDim = 5 ) ifFalse:[self error: 'only supported 3x3 or 5x5 kernel size'].
	anImage := self deepCopy.
	0  to: self width  do:[:x| 
	0  to: self height do:[:y|  
								|aPoint aColorA|
								aPoint := Point x: x y: y.
								aColorA := self 
												getNeighborhood:aPoint 
												kernel: aKernel
												with: anOperation .
								anImage colorAt: aPoint put: aColorA]].
	
	^anImage.
]

{ #category : #converting }
ImageFormGrayScale >> asBinaryImage: aThreshold [ 
	"Covert an image in Binary (Black and White). Return a new ImageFormGray. Keep the alpha channel"
	
	| anImageForm |
	anImageForm := self collectColors:[:each | 
										|anIntensity|
										anIntensity := 0. 
										each red > aThreshold ifTrue:[ anIntensity := 1].
										Color r: anIntensity g: anIntensity b: anIntensity alpha: each alpha. ].
									
	^self class newFrom: anImageForm.
	
]

{ #category : #converting }
ImageFormGrayScale >> asGrayScale [
	"Convert Colors to Gray Colors. Return a new ImageForm. the alpha channel is set in 1."
		self error: 'Is in GrayScale'
]

{ #category : #converting }
ImageFormGrayScale >> asGrayScaleWithAlpha [
	"Convert Colors to Gray Colors. Return a new ImageForm. the alpha channel is set in 1."
		self error: 'Is in GrayScale'
]

{ #category : #converting }
ImageFormGrayScale >> closing: aKernel [
	"Closing is reverse of Opening, Dilation followed by Erosion. AKernel is a flattened list. Return a new ImageFormGrayScale."
	
	| dilation |
	dilation := self dilation: aKernel flattened.
	^ dilation erosion: aKernel flattened.
]

{ #category : #converting }
ImageFormGrayScale >> dilation: aKernel [
	"Increases the white region in the image or size of foreground object increases. AKernel is a flattened list. Return a new ImageFormGrayScale."
	^ self applyKernel: aKernel flattened with: #max.

]

{ #category : #converting }
ImageFormGrayScale >> dilation: aKernel iterations: aNum [
	"Increases the white region in the image or size of foreground object increases. AKernel is a flattened list. Return a new ImageFormGrayScale."
	
	| anImage |
	anImage := self dilation: aKernel.
	1 to: aNum -1 do:[ :each| anImage := anImage dilation: aKernel.	].
	^anImage.
		
	
]

{ #category : #converting }
ImageFormGrayScale >> erosion: aKernel [
	"Erodes away the boundaries of foreground object. AKernel is a flattened list. Return a new ImageFormGrayScale."
	^ self applyKernel: aKernel flattened with: #min.

]

{ #category : #converting }
ImageFormGrayScale >> erosion: aKernel iterations: aNum [
	"Erodes away the boundaries of foreground object. AKernel is a flattened list. Return a new ImageFormGrayScale."
	
	| anImage |
	anImage := self erosion: aKernel.
	1 to: aNum -1 do:[ :each| anImage := anImage erosion: aKernel.	].
	^anImage.
	
]

{ #category : #converting }
ImageFormGrayScale >> getNeighborhood: aPoint kernel: aKernel with: aOperation [
 	"Apply convolution to a point with an operation. AKernel is a flattened list. Return a new Color.
	
	aPixelColor := anImage getNeighborhood: 0@0 kernel:{0. 0. 0. 0. 1. 0. 0. 0. 0.} with: #min.
	
	"
	| aPoints anIntensity aKernelR aDim anIntensities |
	aDim := aKernel size sqrt.
	aPoints := self getPointNeighborhood: aPoint ksize: aDim@aDim.
	anIntensities := OrderedCollection new.
	aKernelR := aKernel.
	aPoints collectWithIndex: [:aKPoint :inx| 
											|aKColor aKFactor|
											aKColor := (self colorAt: aKPoint).
											aKFactor := (aKernelR at:inx).
											aKFactor == 1 
												ifTrue:[anIntensities add: (aKColor red)]. 
										].
	anIntensity := anIntensities perform: aOperation.
	^ Color 
		r: anIntensity  
		g: anIntensity 
		b: anIntensity  
]

{ #category : #converting }
ImageFormGrayScale >> opening: aKernel [
	"Opening is just another name of erosion followed by dilation."
	
	|erosion|
	erosion := self erosion: aKernel flattened.
	^ erosion dilation: aKernel.
]
