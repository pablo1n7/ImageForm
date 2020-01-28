Class {
	#name : #BaselineOfImagenForm,
	#superclass : #BaselineOf,
	#category : #BaselineOfImageForm
}

{ #category : #baselines }
BaselineOfImagenForm >> baseline: spec [
	<baseline>
	spec
		for:#common
		do:[
			"Packages"
			spec
				package: 'Image-Form-core';	
				package: 'Image-Form-test' with: [spec requires: #(Image-Form-core)].
		
		]
]
