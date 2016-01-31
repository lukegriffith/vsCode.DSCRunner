Import-Module FileCheck1


Configuration CheckingFile {
    
    Import-DscResource -ModuleName FileCheck1


    FileCheck1 TestingFile {
        
        FileName = "expo.json"
        Path = 'c:\temp\'
        Ensure = 'Present'
        
    }
    
}