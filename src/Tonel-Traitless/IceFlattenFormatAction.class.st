Class {
	#name : #IceFlattenFormatAction,
	#superclass : #IceConvertFormatAction,
	#category : #'Tonel-Traitless-Iceberg'
}

{ #category : #accessing }
IceFlattenFormatAction >> migratePackage: packageName commit: commit [
	| filetreePackage srcDir subDirWithDelim mcVersion |
	
	srcDir := self codeDirectory.
	subDirWithDelim := self codeDirectoryWithDelim.
	
	mcVersion := (commit versionFor: packageName) mcVersion.
	mcVersion := self ensureMCVersionWithClassOrganisation: mcVersion.
	mcVersion := self ensureMCClassOrganisationHasCorrectStructure: mcVersion.
	self writerClass 
		forInternalStoreFileOut: mcVersion 
		on: repository.
	filetreePackage := commit writerClass directoryNameFor: packageName.
	
	"(srcDir / filetreePackage) ensureDeleteAll."
	self repository addFilesToIndex: { 
		subDirWithDelim, (IceLibgitTonelWriter directoryNameFor: packageName).
		"subDirWithDelim, (IceLibgitFiletreeWriter directoryNameFor: packageName)" }
]

{ #category : #accessing }
IceFlattenFormatAction >> writerClass [
	
	^IceLibgitTraitlessTonelWriter
]
