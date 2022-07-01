Class {
	#name : #BaselineOfTonelTraitless,
	#superclass : #BaselineOf,
	#category : #BaselineOfTonelTraitless
}

{ #category : #baselines }
BaselineOfTonelTraitless >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec package: #'Tonel-Traitless'.
		spec group: 'default' with: #( 'Tonel-Traitless' ) ]
]
