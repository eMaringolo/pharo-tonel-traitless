Class {
	#name : #IceLibgitTraitlessTonelWriter,
	#superclass : #IceLibgitTonelWriter,
	#traits : 'TIceRepositoryWriter',
	#classTraits : 'TIceRepositoryWriter classTrait',
	#category : #'Tonel-Traitless-Iceberg'
}

{ #category : #testing }
IceLibgitTraitlessTonelWriter class >> description [
	^ 'Tonel (Traitless)'
]

{ #category : #testing }
IceLibgitTraitlessTonelWriter class >> forInternalStore [
	^ TraitlessTonelWriter
]

{ #category : #accessing }
IceLibgitTraitlessTonelWriter class >> id [
	^ #traitlesstonel
]
