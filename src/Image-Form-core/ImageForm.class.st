"
Represent a image in Pharo. 

This lib allows basic manipulate and show images.


Example for open a image:

aImageA := ImageForm open: '/Users/pablo/Documents/Pharo/pwq7S.jpg'.

Example to transform a GrayScale image.

aGrayScaleImageA := aImageA asGrayScale.


Example for sum two images:

aImageB := ImageForm open: '/Users/pablo/Documents/Pharo/pharo.png'.
aResultSum := aImageB - aImageA.

Example to show a image:
aImageA show: 'Image A'.

Example to scaled:

aSacaledImage := aImageA scaledFactor:500 height:100.

Example to flip:

aFlippedImage := aImageA flipHorizontally.

aFlippedImage := aImageA flipVertically.


"
Class {
	#name : #ImageForm,
	#superclass : #Form,
	#category : #'Image-Form-core'
}

{ #category : #'instance creation' }
ImageForm class >> imageTest [
	"comment stating purpose of message"
	| aImage aForm|
	
	aForm := Form extent: 100@100 depth:32.
	aImage := self newFrom: aForm.
	aImage fillColor: Color red.
	
	0 to: 50  do:[:x| 0 to: 50 
				do:[:y| |aPoint|
							aPoint := (Point x: x y: y).
							aImage colorAt: aPoint put: (Color blue).]].
							
	50 to: 100  do:[:x| 50 to: 100 
				do:[:y| |aPoint|
							aPoint := (Point x: x y: y).
							aImage colorAt: aPoint put: (Color yellow ).]].
							
	0 to: 50  do:[:x| 50 to: 100
				do:[:y| |aPoint|
							aPoint := (Point x: x y: y).
							aImage colorAt: aPoint put: (Color green ).]].
	^ aImage.
]

{ #category : #'instance creation' }
ImageForm class >> newFrom: aForm [
	"comment stating purpose of message"
	| aImage|
	
	aImage := self new.
	aImage copyFrom: aForm.
	^ aImage.
]

{ #category : #'instance creation' }
ImageForm class >> open: aFileName [
	"comment stating purpose of message"
	| aImage aForm|
	
	(aFileName asFileReference exists) ifTrue: [ 
		aForm := ImageReadWriter formFromFileNamed: aFileName.
		aImage := self newFrom: aForm.
		^ aImage.
	].
	
	self error: 'File does not exist'.
]

{ #category : #operators }
ImageForm >> + aImage [
	"Sum pixel to pixel two images, and return new ImageForm. The channels that be bigger than 1 is setter in 1. It affects the alpha channel."
	|aImageResult|
	
	aImageResult := self deepCopy.
	
	0  to: self width  do:[:x| 0  to: self height 
								do:[:y|  
									|aPoint aColorA aColorB|
									aPoint := (Point x: x y: y).
									aColorA := aImageResult colorAt: aPoint.
									aColorB := aImage colorAt: aPoint.
									aImageResult colorAt: aPoint put: (aColorA + aColorB). ]].
	^ aImageResult

]

{ #category : #operators }
ImageForm >> - aImage [
		"Subtraction pixel to pixel two images, and return new ImageForm. The channels that be lower than 0  is setter in 0.. It affects the alpha channel."
	|aImageResult|
	
	aImageResult := self deepCopy.
	
	0 to: self width  do:[:x| 0 to: self height 
								do:[:y|  
									|aPoint aColorA aColorB aColorC|
									aPoint := (Point x: x y: y).
									aColorA := aImageResult colorAt: aPoint.
									aColorB := aImage colorAt: aPoint.
									aColorC := aColorA - aColorB.
									aImageResult colorAt: aPoint put: aColorC. ]].
	^ aImageResult

]

{ #category : #converting }
ImageForm >> asGrayScale [
	"Convert Colors to Gray Colors. Return a new ImageForm. the alpha channel is set in 1."
	| aImageForm|
	aImageForm := self collectColors:[:each | 
										|aIntensity|
										aIntensity := (0.2125 * each red) + (0.7154 * each green)  + (0.0721 * each blue).
										Color r:aIntensity g: aIntensity b: aIntensity alpha: 1.0. ].
	
		^ImageForm newFrom: aImageForm.
	
]

{ #category : #converting }
ImageForm >> asGrayScaleWithAlpha [ 
	"Convert Colors to Gray Colors. Return a new ImageForm. Keep the alpha channel"
	| aImageForm|
	aImageForm := self collectColors:[:each | 
										|aIntensity|
										aIntensity := (0.2125 * each red) + (0.7154 * each green)  + (0.0721 * each blue).
										Color r:aIntensity g: aIntensity b: aIntensity alpha: each alpha. ].
									
	^ImageForm newFrom: aImageForm.
	
]

{ #category : #'image manipulation' }
ImageForm >> flipHorizontally [
	"Flip Horizontally. Return a new ImageForm."
	| aForm aFormImage|
	aForm:= super flipBy: #horizontal centerAt: (0@0).
	aFormImage := self class newFrom: aForm.
		
	^ aFormImage
]

{ #category : #'image manipulation' }
ImageForm >> flipVertically [
	"Flip Vertically. Return a new ImageForm."
	| aForm aFormImage|
	aForm:= super flipBy: #vertical centerAt: (0@0).
	aFormImage := self class newFrom: aForm.
		
	^ aFormImage
]

{ #category : #'image manipulation' }
ImageForm >> rotateBy: aDeg [
	"rotate aDeg degrees the image. Return a new ImageForm."
	
	| aForm aFormImage|
	aFormImage := self deepCopy.
	aForm:= super rotateBy: aDeg.
	aFormImage := self class newFrom: aForm.
		
	^ aFormImage
]

{ #category : #'image manipulation' }
ImageForm >> rotateBy: direction centerAt: aPoint [
	"Rotate in a direction with the center in point. Return a new ImageForm. Possible values for
	direction = #left, #right or #pi"
	| aForm aFormImage|
	aFormImage := self deepCopy.
	aForm:= super rotateBy: direction centerAt: aPoint.
	aFormImage := self class newFrom: aForm.
		
	^ aFormImage
]

{ #category : #'file in/out' }
ImageForm >> save: aName [
	"save in disk a image. The extension support are .png; .jpg; or .jpge"
	('*.png' match: aName) 
		ifTrue:[self writePNGFileNamed: aName. ^self].
	
	(('*.jpg' match: aName) | ('*.jpge' match: aName)) 
		ifTrue:[self writeJPEGfileNamed: aName. ^self.].
		
		self error:'Only support extension: .png; .jpg; or .jpge'.
		
	
]

{ #category : #'image manipulation' }
ImageForm >> scaled: aWidth height: aHeight [
	"Scaled one image. This method try to Keep relation of aspect. Return a new ImageForm."

	^ self class newFrom: (super scaledToSize: (Point x: aWidth y: aHeight)).
]

{ #category : #'image manipulation' }
ImageForm >> scaledIntoFormOfSize: aSize [
	"Scaled one image in aSize. Return a new ImageForm width shape aSizeXaSize."

	^ self class newFrom: (super scaledIntoFormOfSize: aSize).
]

{ #category : #accessing }
ImageForm >> shape [
	"return a string with format: widthXheight"

	^ self width printString, 'X', self height printString.
]

{ #category : #showing }
ImageForm >> show [
	"show one image in the world"
	self show:'Image'
]

{ #category : #showing }
ImageForm >> show: anTitle [
	"show one image in the world with a title. Always sacaled the image in 500x500"
	
	|im|

	im := (ImageMorph withForm: (self scaledIntoFormOfSize:500) ). 
	im withSnapshotBorder.
	im borderWidth: 5.
	im color: (Color gray).
	im openInWindowLabeled: (anTitle, '| ', self shape).
]
