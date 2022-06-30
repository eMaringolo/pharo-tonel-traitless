Class {
	#name : #IceFlattenTraitsRepositoryCommand,
	#superclass : #IceTipRepositoryCommand,
	#category : #'Tonel-Traitless-Iceberg'
}

{ #category : #'accessing - defaults' }
IceFlattenTraitsRepositoryCommand class >> defaultName [

	^ 'Flatten source of traits into their users'
]

{ #category : #'private ' }
IceFlattenTraitsRepositoryCommand >> branchName [

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
IceFlattenTraitsRepositoryCommand >> canBeExecuted [

	| repository |
	self hasRepository ifFalse: [ ^ false ].

	repository := self repository.
	^ repository isMissing not and: [ 
		  repository workingCopy isDetached not and: [ 
			  repository head isUnbornBranch not ] ]
]

{ #category : #testing }
IceFlattenTraitsRepositoryCommand >> execute [
	
	IceFlattenFormatAction new 
		repository: self repository;
		branchName: self branchName;
		format: #tonel;
		mergeWithCurrentBranch: false;
		execute
]
