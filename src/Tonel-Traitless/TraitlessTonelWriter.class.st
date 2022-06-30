Class {
	#name : #TraitlessTonelWriter,
	#superclass : #TonelWriter,
	#category : #'Tonel-Traitless-Monticello'
}

{ #category : #'private definitions' }
TraitlessTonelWriter >> instanceSideMethodDefinitionsOf: aClassDefinition [

	^ ((snapshot definitions select: [ :each | 
		   each isMethodDefinition and: [ 
			   each classIsMeta not and: [ 
				   each className = aClassDefinition className or: [ 
					   self traitMethodDefinition: each isUsedBy: aClassDefinition ] ] ] ]) 
		  sorted: [ :a :b | a selector < b selector ]) collect: [ :method |
			method className asClass isTrait
				ifTrue: [ 
					method copy
						setClassName: aClassDefinition className;
						yourself
					 ]	
				ifFalse: [ method ]
			
		]
]

{ #category : #testing }
TraitlessTonelWriter >> traitMethodDefinition: each isUsedBy: aClassDefinition [

	^ each className asClass isTrait
		  ifTrue: [ 
			  each className asClass users anySatisfy: [ :user | 
				  user name  = aClassDefinition className ] ]
		  ifFalse: [ false ]
]

{ #category : #'private definitions' }
TraitlessTonelWriter >> typeClassDefinitionOf: aClassDefinition [
	| definition |
	
	definition := OrderedDictionary new 
		at: #name put: aClassDefinition className; 
		at: #superclass put: aClassDefinition superclassName;
		yourself.

	aClassDefinition type = #normal ifFalse: [ 
		definition at: #type put: aClassDefinition type ].
	
	"aClassDefinition hasTraitComposition ifTrue: [ 
		definition at: #traits put: aClassDefinition traitCompositionString ].
	
	aClassDefinition hasClassTraitComposition ifTrue: [ 
		definition at: #classTraits put: aClassDefinition classTraitCompositionString ]."
	
	(aClassDefinition variables select: #isInstanceVariable thenCollect: #name), (aClassDefinition className asClass traitComposition slots select: #isInstanceVariable thenCollect: #name)
		ifNotEmpty: [ :vars | definition at: #instVars put: vars asArray ].

	(aClassDefinition variables select: #isClassVariable thenCollect: #name)
		ifNotEmpty: [ :vars | definition at: #classVars put: vars asArray ].
		
	(aClassDefinition variables select: #isPoolImport thenCollect: #name)
		ifNotEmpty: [ :vars | definition at: #pools put: vars asArray ].
		
	(aClassDefinition variables select: #isClassInstanceVariable thenCollect: #name)
		ifNotEmpty: [ :vars | definition at: #classInstVars put: vars asArray ].

	definition 		
		at: #category put: aClassDefinition category.
	
	^ self toSTON: definition
]

{ #category : #'private definitions' }
TraitlessTonelWriter >> typeDefinitionOf: aClassDefinition [

	^ self typeClassDefinitionOf: aClassDefinition
]

{ #category : #'private definitions' }
TraitlessTonelWriter >> typeOf: aClassDefinition [
	(self isClass: aClassDefinition) ifTrue: [ ^ self class classLabel ].

	TonelShouldIgnore signal
]

{ #category : #writing }
TraitlessTonelWriter >> writeInstanceSideMethodDefinitions: aClassDefinition on: aStream [

	(self instanceSideMethodDefinitionsOf: aClassDefinition) do: [ :each | 
		self
			writeMethodDefinition: each
			parent: aClassDefinition
			on: aStream ]
]
