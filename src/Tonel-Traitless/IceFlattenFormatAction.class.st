Class {
	#name : #IceFlattenFormatAction,
	#superclass : #IceConvertFormatAction,
	#category : #'Tonel-Traitless-Iceberg'
}

{ #category : #accessing }
IceFlattenFormatAction >> writerClass [
	
	format = #tonel ifTrue: [ ^IceLibgitTraitlessTonelWriter ].
	
	self error: 'This action only works in Tonel repositories'
]
