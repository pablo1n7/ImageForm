"
Represent an image in Pharo. 

This lib allows basic manipulate and show images.


Example for open a image:

anImageA := ImageForm open: '/Users/pablo/Documents/Pharo/pwq7S.jpg'.

Example to transform a GrayScale image.

aGrayScaleImageA := anImageA asGrayScale.


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
	#name : #ImageForm,
	#superclass : #Form,
	#category : #'Image-Form-core'
}

{ #category : #'instance creation' }
ImageForm class >> imageTest [
	"Return a Image test."
	| anImage aForm |
	
	aForm := Form extent: 100@100 depth:32.
	anImage := self newFrom: aForm.
	anImage fillColor: Color red.
	
	0 to: 50  do:[:x| 0 to: 50 
				do:[:y| |aPoint|
							aPoint := Point x: x y: y.
							anImage colorAt: aPoint put: Color blue ]].
							
	50 to: 100  do:[:x| 50 to: 100 
				do:[:y| |aPoint|
							aPoint := Point x: x y: y.
							anImage colorAt: aPoint put: Color yellow]].
							
	0 to: 50  do:[:x| 50 to: 100
				do:[:y| |aPoint|
							aPoint := Point x: x y: y.
							anImage colorAt: aPoint put: Color green]].
	^ anImage
]

{ #category : #'instance creation' }
ImageForm class >> newFrom: aForm [
	"New ImageForm from an object Form."
	
	| anImage |
	anImage := self new.
	anImage copyFrom: aForm.
	^ anImage
]

{ #category : #'instance creation' }
ImageForm class >> newImageColor: aColor width: aWidth height: aHeight [
	"Return a new ImageForm filled with aColor. The size is aWidth x aHeight."
	
	| anImage aForm |
	anImage := self new.
	aForm := Form extent: aWidth @ aHeight depth:32.
	aForm fillColor: aColor.
	anImage copyFrom: aForm.
	^ anImage
]

{ #category : #'instance creation' }
ImageForm class >> open: aFileName [
	"Open an Image."
	
	| anImage aForm |
	aFileName asFileReference exists ifTrue: [ 
		aForm := ImageReadWriter formFromFileNamed: aFileName.
		anImage := self newFrom: aForm.
		^ anImage
	].
	self error: 'File does not exist'.
]

{ #category : #operators }
ImageForm >> + anImage [
	"Sum pixel to pixel two images, and return new ImageForm. The channels that be bigger than 1 is setter in 1. It affects the alpha channel."
	
	|anImageResult|
	
	anImageResult := self deepCopy.
	0 to: self width -1  do: [:x| 
		0 
			to: self height -1
			do: [ :y |  
					| aPoint aColorA aColorB |
					aPoint := Point x: x y: y.
					aColorA := anImageResult colorAt: aPoint.
					aColorB := anImage colorAt: aPoint.
					anImageResult colorAt: aPoint put: aColorA + aColorB ]].
	^ anImageResult

]

{ #category : #operators }
ImageForm >> - anImage [
		"Subtraction pixel to pixel two images, and return new ImageForm. The channels that be lower than 0  is setter in 0.. It affects the alpha channel."
	
	|anImageResult|
	
	anImageResult := self deepCopy.
	0 to: self width -1  do:[:x| 0 to: self height -1
								do:[:y|  
									|aPoint aColorA aColorB aColorC|
									aPoint := (Point x: x y: y).
									aColorA := anImageResult colorAt: aPoint.
									aColorB := anImage colorAt: aPoint.
									aColorC := aColorA - aColorB.
									anImageResult colorAt: aPoint put: aColorC. ]].
	^ anImageResult

]

{ #category : #accesing }
ImageForm >> acumulateColor: aChannel [
	""
	
	| anAcumulate aBlues|
	anAcumulate := OrderedCollection new.
	aBlues := (aChannel * 255) rounded.
	anAcumulate := (0 to: 255) collect:[:each|(aBlues select:[:number|number=each]) size].
	^anAcumulate
]

{ #category : #'image manipulation' }
ImageForm >> applyKernel: aKernel [
	"Apply convolution to image. AKernel is a flattened list. Return a new ImageForm.
	
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
								aColorA := self getNeighborhood:
								aPoint kernel: aKernel.
								anImage colorAt: aPoint put: aColorA]].
	
	^anImage.
]

{ #category : #converting }
ImageForm >> applyMask: aMask [ 
	"Apply a Binary Mask in one image. The Result is a new Image, with color transparent in the position with black color in the mask."
	
	| anImageResult |
	"({Color black. Color white. }  =  aMask colorsUsed)
		ifFalse:[self error: 'the mask only has Black and White color.']."
	anImageResult := self deepCopy.
	0 to: self width  do: [:x| 
		0 
			to: self height 
			do: [ :y |  
					| aPoint aColorA aColorB |
					aPoint := Point x: x y: y.
					aColorA := anImageResult colorAt: aPoint.
					aColorB := aMask colorAt: aPoint.
					aColorB = Color black 
						ifTrue: [ aColorA := Color transparent ].
						
					anImageResult colorAt: aPoint put: aColorA  ]].
	^ anImageResult
]

{ #category : #converting }
ImageForm >> asGrayScale [
	"Convert Colors to Gray Colors. Return a new ImageForm. the alpha channel is set in 1."
	
	| anImageForm|
	
	anImageForm := self collectColors:[:each | 
										|aIntensity|
										aIntensity := (0.2125 * each red) + (0.7154 * each green)  + (0.0721 * each blue).
										Color r:aIntensity g: aIntensity b: aIntensity alpha: 1.0. ].
	^ ImageFormGrayScale newFrom: anImageForm.
	
]

{ #category : #converting }
ImageForm >> asGrayScaleWithAlpha [ 
	"Convert Colors to Gray Colors. Return a new ImageFormGrayScale. Keep the alpha channel"
	
	| anImageForm|
	
	anImageForm := self collectColors:[:each | 
										|aIntensity|
										aIntensity := (0.2125 * each red) + (0.7154 * each green)  + (0.0721 * each blue).
										Color r:aIntensity g: aIntensity b: aIntensity alpha: each alpha. ].
									
	^ImageFormGrayScale newFrom: anImageForm.
	
]

{ #category : #accesing }
ImageForm >> blues [
	""
	^ self colors collect: [ :each | each blue.].
]

{ #category : #'image manipulation' }
ImageForm >> colors [
	"Create a new copy of the receiver with all the colors transformed by aBlock"
	|aColors|
	aColors := OrderedCollection new.
	0 to: self width -1  do: [:x| 
		0 
			to: self height -1 
			do: [ :y |  
					| aPoint aColor|
					aPoint := Point x: x y: y.
					aColor:= self colorAt: aPoint.
					aColors add: aColor.]].
	^ aColors
]

{ #category : #'image manipulation' }
ImageForm >> crop: aPoint h: aH w: aW [
	"Crop an image begin for aPoint. degrees the image. Return a new ImageForm.
	aCropImage := anImage crop: 0@0 h:200 w: 400. "
	
	| aForm aFormImage|
	
	aForm := Form extent: aW@aH depth:32.
	aFormImage := self deepCopy.
	aPoint x  to: (aPoint x + aW)  do:[:x| aPoint y  to: (aPoint y + aH) 
								do:[:y|  
									|aCoord aNewPoint|
									aCoord := (Point x: x y: y).
									aNewPoint := (aCoord x - aPoint x)@(aCoord y - aPoint y).
									aForm colorAt: aNewPoint put: (aFormImage colorAt: aCoord). ]].
	^ self class newFrom: aForm.
]

{ #category : #'image manipulation' }
ImageForm >> darker: aFactor [
	"Darker an image. aFactor is a float from 0 to 1. Return a new ImageForm."
	
	| aForm aFormImage |
	aForm:= super darker:aFactor.
	aFormImage := self class newFrom: aForm.
	
	^ aFormImage
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

{ #category : #accessing }
ImageForm >> getNeighborhood: aPoint kernel: aKernel [
 	"Apply convolution to a point. AKernel is a flattened list. Return a new Color.
	
	aPixelColor := anImage getNeighborhood: 0@0 kernel:{0. 0. 0. 0. 1. 0. 0. 0. 0.}.
	
	"
	
	
	|aPoints aRed aGreen aBlue aKernelR aDim|
	aDim := aKernel size sqrt.
	aPoints := self getPointNeighborhood: aPoint ksize: aDim@aDim.
	aRed := 0.
	aGreen := 0.
	aBlue := 0.
	aKernelR := aKernel.
	aPoints collectWithIndex: [:aKPoint :inx| 
											|aKColor aKFactor|
											aKColor := (self colorAt: aKPoint).
											aKFactor := (aKernelR at:inx).
											aRed := aRed + (aKColor red * aKFactor). 
											aGreen := aGreen + (aKColor green * aKFactor).
											aBlue := aBlue + (aKColor blue * aKFactor).		
										].
	^ Color r: aRed g: aGreen  b: aBlue.  
]

{ #category : #accessing }
ImageForm >> getPointNeighborhood: aPoint ksize: aKsize [
 	"Get a Neighbordhood of a point, aKsize is a shape like 3@3. Return a list of points. If the points are out of the image, it repeats the image border.
	
	 anImage getPointNeighborhood: 0@0 ksize: 3@3.
	
	"
	
	|aPoints aXvalues aYvalues factor|
	
	factor := (aKsize x -1 ) / 2.
	aPoints := OrderedCollection new.
	aXvalues := (aPoint x - factor) to: (aPoint x +  factor).
	aYvalues := (aPoint y - factor) to: (aPoint y +  factor).
	
	aXvalues do: [ :x |
		aYvalues do: [ :y |
				|xK yK|
				xK := x.
				yK := y.
				x < 0 ifTrue: [xK := 0]. "this need refactoring"
				y < 0 ifTrue: [yK := 0].
				x > (self width-1) ifTrue: [xK := self width-1].
				y > (self height-1) ifTrue: [yK := self height-1].
				
				aPoints add: xK@yK.
		].
	].
	^aPoints
]

{ #category : #accesing }
ImageForm >> greens [
	""
	^ self colors collect: [ :each | each green.].
]

{ #category : #'image manipulation' }
ImageForm >> lighter: aFactor [
	"Lighter an image. aFactor is a float from 0 to 1. Return a new ImageForm."
	
	| aForm aFormImage|
	
	aForm:= super lighter:aFactor.
	aFormImage := self class newFrom: aForm.
		
	^ aFormImage
]

{ #category : #converting }
ImageForm >> negated [ 
	"Convert an image to negated image form. Return a new ImageForm. Keep the alpha channel"
	
	| anImageForm|
	
	anImageForm := self collectColors:[:each | each negated].
									
	^self class newFrom: anImageForm.
	
]

{ #category : #accesing }
ImageForm >> reds [
	""
	^ self colors collect: [ :each | each red.].
]

{ #category : #'image manipulation' }
ImageForm >> rotateBy: aDeg [
	"rotate aDeg degrees the image. Return a new ImageForm."
	
	| aForm aFormImage |
	aFormImage := self deepCopy.
	aForm:= super rotateBy: aDeg.
	aFormImage := self class newFrom: aForm.
	^ aFormImage
]

{ #category : #'image manipulation' }
ImageForm >> rotateBy: direction centerAt: aPoint [
	"Rotate in a direction with the center in point. Return a new ImageForm. Possible values for
	direction = #left, #right or #pi"
	
	| aForm aFormImage |
	aFormImage := self deepCopy.
	aForm:= super rotateBy: direction centerAt: aPoint.
	aFormImage := self class newFrom: aForm.
		
	^ aFormImage
]

{ #category : #'file in/out' }
ImageForm >> save: aName [
	"Save in disk a image. Supported extensions: .png; .jpg; .bmp; and .jpeg"
	
	('*.png' match: aName) 
		ifTrue: [ self writePNGFileNamed: aName. ^self ].
	
	(('*.jpg' match: aName) | ('*.jpeg' match: aName)) 
		ifTrue: [ self writeJPEGfileNamed: aName. ^self ].
		
	('*.bmp' match: aName) 
		ifTrue: [ self writeBMPfileNamed: aName. ^self ].
		
	self error:'Only support extension: .png; .jpg; .bmp; and .jpeg'.
		
	
]

{ #category : #'image manipulation' }
ImageForm >> scaled: aWidth height: aHeight [
	"Scaled one image. This method try to Keep relation of aspect. Return a new ImageForm."

	^ self class newFrom: (super scaledToSize: (Point x: aWidth y: aHeight))
]

{ #category : #'image manipulation' }
ImageForm >> scaledIntoFormOfSize: aSize [
	"Scaled one image in aSize. Return a new ImageForm width shape aSizeXaSize."

	^ self class newFrom: (super scaledIntoFormOfSize: aSize)
]

{ #category : #accessing }
ImageForm >> shape [
	"return a string with format: widthXheight"

	^ self width printString, 'X', self height printString
]

{ #category : #showing }
ImageForm >> show [
	"show one image in the world"
	
	self show:'Image'
]

{ #category : #showing }
ImageForm >> show: anTitle [
	"show one image in the world with a title. Always sacaled the image in 500x500"
	
	| im |
	im := (ImageMorph withForm: (self scaledIntoFormOfSize:500) ). 
	im withSnapshotBorder.
	im borderWidth: 5.
	im color: (Color gray).
	im openInWindowLabeled: (anTitle, '| ', self shape).
]
