enum Ensure {
    Present
    Absent
}

[DscResource()]
Class FileCheck1 {

    [DscProperty(Key, Mandatory)]
    [String]$FileName

    [DscProperty(Mandatory)]
    [string]$path

    [DSCProperty(Mandatory)]
    [Ensure]$Ensure
    
    [DSCProperty()]
    [String]$SourceFilePath

    [DscProperty(NotConfigurable)]
    [boolean]$Present


    [FileCheck1]Get()
    {
    
        $FilePath = Join-Path -Path $this.path -ChildPath $this.FileName    
        $this.Present = $this.TestFile($FilePath)

        return $this
    }
    
    
    [void]Set(){
    
    }
    
    [boolean]Test(){

        $FilePath = Join-Path -Path $this.path -ChildPath $this.FileName    
        $this.Present = $this.TestFile($FilePath)

        if ($this.Ensure -eq 'Present')
        {
            if ($this.Present -eq $true)
            {
                return $true
            } else {
                return $false
            } 
        }
        else
        {
            if ($this.Present -eq $true)
            {
                return $false
            } else {
                return $true
            }
        }        
    
    }

    [bool]TestFile($filePath){
                
        try {
            Get-Item $filePath -ErrorAction Stop
            return $true
        }
        catch {
            return $false
        }
    }
}


