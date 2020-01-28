Class {
	#name : #BaselineOfImageForm,
	#superclass : #BaselineOf,
	#category : #BaselineOfImageForm
}

{ #category : #baselines }
BaselineOfImageForm >> baseline: spec [
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
