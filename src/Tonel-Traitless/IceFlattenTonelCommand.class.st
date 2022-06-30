Class {
	#name : #IceFlattenTonelCommand,
	#superclass : #IceTipCommand,
	#category : #'Tonel-Traitless-Iceberg'
}

{ #category : #'accessing - defaults' }
IceFlattenTonelCommand class >> defaultName [

	^ 'Flatten source of traits into their users'
]

{ #category : #'private ' }
IceFlattenTonelCommand >> branchName [

	| baseName suffix count |
	count := 0.
	baseName := 'traitless'.
	suffix := ''.
	[ true ] whileTrue: [ 
		self repository
			branchNamed: baseName , suffix
			ifAbsent: [ ^ baseName , suffix ].
		count := count + 1.
		suffix := '-' , count asString ]
]

{ #category : #testing }
IceFlattenTonelCommand >> canBeExecuted [

	| repository |
	self hasRepository ifFalse: [ ^ false ].

	repository := self repository.
	^ repository isMissing not and: [ 
		  repository workingCopy isDetached not and: [ 
			  repository head isUnbornBranch not ] ]
]

{ #category : #testing }
IceFlattenTonelCommand >> execute [
	
	IceFlattenFormatAction new 
		repository: self repository;
		branchName: self branchName;
		format: #toneltraitless;
		mergeWithCurrentBranch: false;
		execute
]
